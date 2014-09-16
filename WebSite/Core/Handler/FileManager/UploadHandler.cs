using System;
using System.Collections;
using System.Collections.Generic;
using System.EnterpriseServices;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Xml.Serialization;
using Backstage.Core;
using Backstage.Core.Entity;
using Backstage.Core.Logic;
using LitJson;

namespace Backstage.Handler
{
    public class UploadHandler : BaseHandler
    {
        public override void ProcessRequest(HttpContext context)
        {
            RoleType = RoleType.ThirdUser; //需商家管理权限
            ImageType imgType = (ImageType)Convert.ToInt32(context.Request.QueryString["type"]);

            base.ProcessRequest(HttpContext.Current);

            //String aspxUrl = context.Request.Path.Substring(0, context.Request.Path.LastIndexOf("/") + 1);

            //文件保存目录路径
            String savePath = "../../File/" + CurrentUser.Id.ToString() + "/";// "../attached/";

            //文件保存目录URL
            String saveUrl = Utility._domainurl + "/File/" + CurrentUser.Id.ToString() + "/"; ;// "../attached/";

            //定义允许上传的文件扩展名
            Hashtable extTable = new Hashtable();
            extTable.Add("image", "gif,jpg,jpeg,png,bmp");
            extTable.Add("flash", "swf,flv");
            extTable.Add("media", "swf,flv,mp3,wav,wma,wmv,mid,avi,mpg,asf,rm,rmvb");
            extTable.Add("file", "doc,docx,xls,xlsx,ppt,htm,html,txt,zip,rar,gz,bz2");

            //最大文件大小
            int maxSize = 1000000;

            HttpPostedFile imgFile = context.Request.Files["imgFile"];
            if (imgFile == null)
            {
                showError("请选择文件。");
            }

            String dirPath = context.Server.MapPath(savePath);
            if (!Directory.Exists(dirPath))
            {
                //showError("上传目录不存在。");
                Directory.CreateDirectory(dirPath);
            }

            String dirName = context.Request.QueryString["dir"];
            if (String.IsNullOrEmpty(dirName))
            {
                dirName = "image";
            }
            if (!extTable.ContainsKey(dirName))
            {
                showError("目录名不正确。");
            }

            String fileName = imgFile.FileName;
            String fileExt = Path.GetExtension(fileName).ToLower();

            if (imgFile.InputStream == null || imgFile.InputStream.Length > maxSize)
            {
                showError("上传文件大小超过限制。");
            }

            if (String.IsNullOrEmpty(fileExt) ||
                Array.IndexOf(((String)extTable[dirName]).Split(','), fileExt.Substring(1).ToLower()) == -1)
            {
                showError("上传文件扩展名是不允许的扩展名。\n只允许" + ((String)extTable[dirName]) + "格式。");
            }


            var typeName = GetTypeName(context);
            //创建文件夹
            dirPath += dirName + typeName + "/";
            saveUrl += dirName + typeName + "/";
            if (!Directory.Exists(dirPath))
            {
                Directory.CreateDirectory(dirPath);
            }
            String ymd = DateTime.Now.ToString("yyyyMMdd", DateTimeFormatInfo.InvariantInfo);
            dirPath += ymd + "/";
            saveUrl += ymd + "/";
            if (!Directory.Exists(dirPath))
            {
                Directory.CreateDirectory(dirPath);
            }

            //String newFileName = DateTime.Now.ToString("yyyyMMddHHmmss_ffff", DateTimeFormatInfo.InvariantInfo) + fileExt;
            //String filePath = dirPath + newFileName;

            var originalFileName = DateTime.Now.ToUnixTime().ToString() + Utility.GetRandom(1, 1000);
            fileName = originalFileName + fileExt;
            //fileName = fileName.Replace(',', '.');//防止图片名称中存在，分隔符
            String filePath = dirPath + fileName;
            var index = 2;
            while (File.Exists(filePath))
            {
                fileName = originalFileName + string.Format("({0})", index) + fileExt;
                filePath = dirPath + fileName;
                index++;
            }

            imgFile.SaveAs(filePath);

            //String fileUrl = saveUrl + newFileName;
            String fileUrl = saveUrl + fileName;

            var addId = 0;
            //添加商户图片
            if (imgType == ImageType.Img)
            {
                //TODO:暂时这么添加 图片名称及图片描述 这个后面再根据需求定怎么赋初值 后面应该加上图片类型！（上传）
                var sm = new SourceMaterial();
                sm.SellerId = CurrentUser.Id;
                sm.Title = Path.GetFileNameWithoutExtension(fileName);
                sm.Url = fileUrl;
                sm.Description = Path.GetFileNameWithoutExtension(fileName);
                sm.CreateTime = DateTime.Now;
                sm.ImageType = ImageType.Img;
                addId = SourceMaterialHelper.Create(sm);
            }


            Hashtable hash = new Hashtable();
            hash["error"] = 0;
            hash["url"] = fileUrl;
            hash["id"] = addId;
            context.Response.AddHeader("Content-Type", "text/html; charset=UTF-8");
            context.Response.Write(JsonMapper.ToJson(hash));
            context.Response.End();
        }

        private void showError(string message)
        {
            Hashtable hash = new Hashtable();
            hash["error"] = 1;
            hash["message"] = message;
            Response.AddHeader("Content-Type", "text/html; charset=UTF-8");
            Response.Write(JsonMapper.ToJson(hash));
            Response.End();
        }

        public static string GetTypeName(HttpContext context)
        {
            var typeName = "";
            ImageType type = (ImageType)Convert.ToInt32(context.Request.QueryString["type"]);
            switch (type)
            {
                case ImageType.All: typeName = ""; break;
                case ImageType.Goods: typeName = "/goods"; break;
                default: break;
            }
            return typeName;
        }
    }
}