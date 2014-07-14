using System.Data;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebSite;

using Backstage.Core.Entity;
using Backstage.Model;

namespace Backstage.Core.Handler
{
    /// <summary>
    /// SourceMaterial 的摘要说明
    /// </summary>
    public class ActiveHandler : BaseApiHandler
    {
        public override void ProcessRequest(HttpContext context)
        {
            base.SetApiName("ActiveHandler");
            base.ProcessRequest(HttpContext.Current);
            switch (Action)
            {
                case "getlist":
                    GetList(); break;
                case "getitem":
                    GetItem(); break;
                case "activecomment":
                    ActiveComment(); break;
                case "activecommentlist":
                    ActiveCommentList(); break;
                //case "updatedata":
                //    UpdateData(); break;
                //case "deldata":
                //    DelData(); break;
                default: break;
            }
        }

        private void ActiveCommentList()
        {
            int aid = GetInt("newid");
            int index = GetInt("start");
            int size = GetInt("limit");
            var active = ActiveHelper.GetItem(aid);
            var cms = CommentHelper.GetPagings(active.SellerId, CommentType.Avtive, aid, index, size);
            var users = AccountHelper.GetUserList(cms.Results.Select(c => c.UserId).ToList());
            var data = new CommentsForApis();
            foreach (var cm in cms.Results)
            {
                var user = users.FirstOrDefault(u => u.Id == cm.UserId);
                if (user == null)
                    throw new ArgumentNullException(string.Format("userId:{0}", cm.UserId));
                var result = new ComentsForApi
                {
                    Avatar = user.Avatar,
                    UserName = user.UserName,
                    Sex = (int)user.Sex,
                    Dateline = cm.CreateTime.GetUnixTime(),
                    Message = cm.Content
                };
                data.Comments.Add(result);
            }
            data.Commentnum = cms.TotalCount;
            JsonTransfer jt = new JsonTransfer();
            jt.AddSuccessParam();
            jt.Add("data", data);
            Response.Write(DesEncrypt(jt).ToLower());
            Response.End();
        }

        private void ActiveComment()
        {
            int aid = GetInt("newid");
            int uid = GetInt("uid");
            string msg = GetString("message");
            var active = ActiveHelper.GetItem(aid);
            Comment c = new Comment();
            c.SellerId = active.SellerId;
            c.TypeId = active.Id;
            c.UserId = uid;
            c.Content = msg;
            c.Type = CommentType.Avtive;

            try
            {
                CommentHelper.Create(c);
                active.Commentnum += 1;
                ActiveHelper.Update(active);
            }
            catch
            {
                ReturnErrorMsg("fail");
                throw;
            }
            JsonTransfer jt = new JsonTransfer();
            jt.AddSuccessParam();
            Response.Write(DesEncrypt(jt).ToLower());
            Response.End();
        }

        private void GetItem()
        {
            int aid = GetInt("newid");
            var item = ActiveHelper.GetItem(aid);
            var data = new
            {
                newid = item.Id,
                title = item.Title,
                img = item.CoverImgUrl,
                summary = item.Summary

            };
            JsonTransfer jt = new JsonTransfer();
            jt.AddSuccessParam();
            jt.Add("data", data);
            Response.Write(DesEncrypt(jt).ToLower());
            Response.End();
        }

        public void GetList()
        {
            int index = GetInt("start");
            int size = GetInt("limit");
            int sid = GetInt("sellerid");

            var results = ActiveHelper.GetPagings(sid, index, size);
            var data = new List<object>();
            foreach (var r in results.Results)
            {
                var d = new
                {
                    newid = r.Id,
                    title = r.Title,
                    img = r.CoverImgUrl,
                    dateline = r.CreateTime.GetUnixTime(),
                    summary = r.Summary
                };
                data.Add(d);
            }

            JsonTransfer jt = new JsonTransfer();
            jt.AddSuccessParam();
            jt.Add("data", data);
            Response.Write(DesEncrypt(jt).ToLower());
            Response.End();
        }

        public static void Create(Active sm)
        {
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
            throw new NotImplementedException();
        }

        public void Update(SourceMaterial sm)
        {
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
            throw new NotImplementedException();
        }

        public void Delete(SourceMaterial sm)
        {
            //string commandText = @"Delete material WHERE Id = ?Id";
            //List<MySqlParameter> parameters = new List<MySqlParameter>();
            //parameters.Add(new MySqlParameter("?Id", sm.Id));

            //MySqlHelper.ExecuteNonQuery(GlobalConfig.DbConn, CommandType.Text, commandText, parameters.ToArray());
            throw new NotImplementedException();
        }


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