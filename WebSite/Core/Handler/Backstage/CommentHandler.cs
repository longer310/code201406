using System.Data;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using Backstage.Core.Entity;
using Backstage.Model;

namespace Backstage.Core.Handler.Backstage
{
    /// <summary>
    /// SourceMaterial 的摘要说明
    /// </summary>
    public class CommentHandler : BaseApiHandler
    {

        public override void ProcessRequest(HttpContext context)
        {
            base.SetApiName("ActiveHandler");
            base.ProcessRequest(HttpContext.Current);
            switch (Action)
            {
                case "getlist":
                    GetList(); break;
                case "update":
                    Update(); break;
                case "delete":
                    Delete(); break;
                //case "update":
                //    Update(); break;
                //case "deldata":
                //    Delete(); break;
                default: break;
            }
        }

        private void Delete()
        {
            var ids = Utility.GetListint(GetString("ids"));
            foreach (var id in ids)
            {
                CommentHelper.Delete(id);
            }
        }

        private void Update()
        {
            var id = GetInt("id");
            var item = CommentHelper.GetItem(id);
            item.Title = GetString("title");
            item.Content = GetString("content");
            item.Feedback = GetString("feedback");
            CommentHelper.Update(item);
        }

        public void GetList()
        {
            int sellerid = GetInt("sellerid");
            int start = GetInt("start");
            int limit = GetInt("limit");
            var result = CommentHelper.GetPagings(sellerid, CommentType.All, 0, start * limit, limit);
            var data = new PagResults<object>();
            foreach (var item in result.Results)
            {
                var user = AccountHelper.GetUser(item.UserId);
                var feedbackStauts = item.Feedback != null && item.Feedback.Length > 0;
                var o = new
                {
                    Id = item.Id,
                    Title = item.Title,
                    Content = item.Content,
                    Feedback = item.Feedback,
                    FeedbackStatus = feedbackStauts ? "已回复" : "未回复",
                    CreateTime = item.CreateTime.ToString("yyyy-MM-dd HH:mm:ss"),
                    Type = EnumHelper.CommentTypeToName(item.Type),
                    UserId = item.UserId,
                    NickName = user.NickName
                };
                data.Results.Add(o);
            }
            data.TotalCount = result.TotalCount;
            JsonTransfer jt = new JsonTransfer();
            jt.AddSuccessParam();
            jt.Add("data", data);
            Response.Write(DesEncrypt(jt).ToLower());
            Response.End();
        }

        //        public static void Create()
        //        {
        //            string connectionString = GlobalConfig.DbConn;
        //            string commandText = @"INSERT INTO material 
        //	                                ( 
        //	                                Name, 
        //	                                Address,
        //	                                Remark,
        //	                                )
        //	                                VALUES
        //	                                ( 
        //	                                ?Name, 
        //	                                ?Address, 
        //	                                ?Remark
        //	                                )";

        //            List<MySqlParameter> parameters = new List<MySqlParameter>();
        //            parameters.Add(new MySqlParameter("?Name", sm.Name));
        //            parameters.Add(new MySqlParameter("?Address", sm.Address));
        //            parameters.Add(new MySqlParameter("?Remark", sm.Remark));

        //            MySqlHelper.ExecuteNonQuery(connectionString, CommandType.Text, commandText, parameters.ToArray());
        //        }

        //        public void Update()
        //        {
        //            string commandText = @"UPDATE material SET
        //                                        Name = ?Name,
        //                                        Address = ?Address,
        //                                        Remark = ?Remark
        //                                    WHERE
        //                                        Id = ?Id";

        //            List<MySqlParameter> parameters = new List<MySqlParameter>();
        //            parameters.Add(new MySqlParameter("?Id", sm.Id));
        //            parameters.Add(new MySqlParameter("?Name", sm.Name));
        //            parameters.Add(new MySqlParameter("?Address", sm.Address));
        //            parameters.Add(new MySqlParameter("?Remark", sm.Remark));

        //            MySqlHelper.ExecuteNonQuery(GlobalConfig.DbConn, CommandType.Text, commandText, parameters.ToArray());
        //        }

        //        public void Delete(SourceMaterial sm)
        //        {
        //            string commandText = @"Delete material WHERE Id = ?Id";
        //            List<MySqlParameter> parameters = new List<MySqlParameter>();
        //            parameters.Add(new MySqlParameter("?Id", sm.Id));

        //            MySqlHelper.ExecuteNonQuery(GlobalConfig.DbConn, CommandType.Text, commandText, parameters.ToArray());
        //        }


        //public void LoadImg(string kindId, string type)
        //{
        //    string result = string.Empty;
        //    try
        //    {
        //        if (Request.Files.Count > 0)
        //        {
        //            HttpPostedFileBase file = Request.Files[0];
        //            if (file == null)
        //            {
        //                throw new Exception("文件为空，无法上传");
        //            }
        //            string extension = Path.GetExtension(file.FileName).ToLower();
        //            var oldFileName = "u_logo_temp_" + type.ToLower().ToString() + kindId.ToLower().ToString() + extension;
        //            if (kindId == "-1")
        //            {
        //                oldFileName = "u_logo_temp_user_" + type.ToLower().ToString() + CurrentUserId.ToString().ToLower().ToString() + extension;
        //            }
        //            LoadFile(file, oldFileName, Server.MapPath(GlobalConfig.UploadFilePath), GlobalConfig.UploadAllowedFileTypes);
        //            return Content("<script>document.domain='" + domain + "'</script>" + GlobalConfig.UploadPath + oldFileName);
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        result = "Error_";
        //        throw new PlatformException("上传出错", ex);
        //    }
        //    return Content("<script>document.domain='" + domain + "'</script>");
        //}

        //private static void LoadFile(HttpPostedFileBase file, string fileName, string folderPath, string allowFileTypes)
        //{
        //    //目录若不存在先创建
        //    if (!Directory.Exists(folderPath))
        //        Directory.CreateDirectory(folderPath);

        //    string fileExtension = Path.GetExtension(file.FileName).ToLower();

        //    if (file.ContentLength == 0)
        //        throw new PlatformException("上传文件大小为0，无法上传");

        //    if (!allowFileTypes.Contains(fileExtension))
        //        throw new PlatformException("文件类型不符合");

        //    var filePath = folderPath + Path.GetFileName(fileName);

        //    file.SaveAs(filePath);
        //    MakeThumbnail(filePath, 0, 0);
        //}

        //private static void MakeThumbnail(string filePath, int width, int height)
        //{
        //    Image originalImage = Image.FromFile(filePath);
        //    int towidth = originalImage.Width;
        //    int toheight = originalImage.Height;
        //    if (width != 0 && height != 0)
        //    {
        //        towidth = width;
        //        toheight = height;
        //    }
        //    int x = 0;
        //    int y = 0;
        //    int ow = originalImage.Width;
        //    int oh = originalImage.Height;
        //    if (ow >= oh && ow > 302)
        //    {
        //        toheight = originalImage.Height * 302 / originalImage.Width;
        //        towidth = 302;
        //    }
        //    else if (oh >= ow && oh > 302)
        //    {
        //        towidth = originalImage.Width * 302 / originalImage.Height;
        //        toheight = 302;
        //    }
        //    //新建一个bmp图片
        //    Image bitmap = new Drawing.Bitmap(towidth, toheight);
        //    //新建一个画板
        //    Graphics g = Drawing.Graphics.FromImage(bitmap);
        //    //设置高质量插值法
        //    g.InterpolationMode = Drawing.Drawing2D.InterpolationMode.High;
        //    //设置高质量,低速度呈现平滑程度
        //    g.SmoothingMode = Drawing.Drawing2D.SmoothingMode.HighQuality;
        //    //清空画布并以透明背景色填充
        //    g.Clear(Color.Transparent);
        //    //在指定位置并且按指定大小绘制原图片的指定部分
        //    g.DrawImage(originalImage, new Rectangle(0, 0, towidth, toheight),
        //        new Rectangle(x, y, ow, oh),
        //        GraphicsUnit.Pixel);
        //    originalImage.Dispose();
        //    try
        //    {
        //        switch (Path.GetExtension(filePath).ToLower())
        //        {
        //            case ".jpg":
        //                bitmap.Save(filePath, Drawing.Imaging.ImageFormat.Jpeg);
        //                break;
        //            case ".png":
        //                bitmap.Save(filePath, Drawing.Imaging.ImageFormat.Png);
        //                break;
        //            case ".gif":
        //                bitmap.Save(filePath, Drawing.Imaging.ImageFormat.Gif);
        //                break;
        //        }
        //        bitmap.Dispose();
        //    }
        //    catch (Exception e)
        //    {
        //        throw e.InnerException;
        //    }
        //    finally
        //    {
        //        bitmap.Dispose();
        //        g.Dispose();
        //    }
        //}

        //[AjaxApi]
        //public object SaveImg(int width, int height, int starX, int starY, string kindId, string type, int sizeW, int sizeH, string extension)
        //{
        //    var oldFileName = "u_logo_temp_" + type.ToLower().ToString() + kindId.ToLower().ToString() + extension;
        //    var newFileName = "u_logo_" + type.ToLower().ToString() + kindId.ToLower().ToString() + extension;
        //    if (kindId == "-1")
        //    {
        //        oldFileName = "u_logo_temp_user_" + type.ToLower().ToString() + CurrentUserId.ToString().ToLower().ToString() + extension;
        //        newFileName = "u_logo_user_" + type.ToLower().ToString() + CurrentUserId.ToString().ToLower().ToString() + extension;
        //    }
        //    var filePath = Server.MapPath(GlobalConfig.UploadFilePath) + Path.GetFileName(newFileName);
        //    var oldFilePath = Server.MapPath(GlobalConfig.UploadFilePath) + Path.GetFileName(oldFileName);
        //    Image originalImage = Image.FromFile(oldFilePath);
        //    Image bitmap = new Bitmap(width, height);
        //    Graphics g = Drawing.Graphics.FromImage(bitmap);
        //    g.DrawImage(originalImage, new Rectangle(0, 0, width, height), new Rectangle(starX, starY, width, height), GraphicsUnit.Pixel);
        //    var fileType = Path.GetExtension(filePath).ToLower();
        //    originalImage.Dispose();
        //    try
        //    {
        //        switch (extension)
        //        {
        //            case ".jpg":
        //                bitmap.Save(filePath, System.Drawing.Imaging.ImageFormat.Jpeg);
        //                bitmap.Save(oldFilePath, Drawing.Imaging.ImageFormat.Jpeg);
        //                break;
        //            case ".png":
        //                bitmap.Save(filePath, Drawing.Imaging.ImageFormat.Png);
        //                bitmap.Save(oldFilePath, Drawing.Imaging.ImageFormat.Png);
        //                break;
        //            case ".gif":
        //                bitmap.Save(filePath, Drawing.Imaging.ImageFormat.Gif);
        //                bitmap.Save(oldFilePath, Drawing.Imaging.ImageFormat.Gif);
        //                break;
        //        }
        //        bitmap.Dispose();
        //    }
        //    catch (Exception e)
        //    {
        //        throw e.InnerException;
        //    }
        //    finally
        //    {
        //        originalImage.Dispose();
        //        bitmap.Dispose();
        //        g.Dispose();
        //    }
        //    MakeThumbnail(filePath, sizeW, sizeH);
        //    MakeThumbnail(oldFilePath, sizeW, sizeH);
        //    return new { link = GlobalConfig.UploadPath + newFileName, name = newFileName };
        //}

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}