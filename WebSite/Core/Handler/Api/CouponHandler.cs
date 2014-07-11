using Backstage.Core.Entity;
using Backstage.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Handler.Api
{
    public class CouponHandler : BaseApiHandler
    {
        public override void ProcessRequest(HttpContext context)
        {
            base.SetApiName("CouponHandle");
            base.ProcessRequest(HttpContext.Current);
            switch (Action)
            {
                case "getlist":
                    GetList(); break;
                case "getitem":
                    GetItem(); break;
                case "couponcomment":
                    CouponComment(); break;
                case "couponcommentlist":
                    Couponcommentlist(); break;
                //case "updatedata":
                //    UpdateData(); break;
                //case "deldata":
                //    DelData(); break;
                default: break;
            }
        }

        private void Couponcommentlist()
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
                    Sex = user.Sex,
                    Dateline = cm.CreateTime,
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

        private void CouponComment()
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

            var results = CouponHelper.GetPagings(sid, index, size);
            var data = new List<object>();
            foreach (var r in results.Results)
            {
                var d = new
                {
                    //newid = r.Id,
                    //title = r.Title,
                    //img = r.CoverImgUrl,
                    //summary = r.Summary
                };
                data.Add(d);
            }

            JsonTransfer jt = new JsonTransfer();
            jt.AddSuccessParam();
            jt.Add("data", data);
            Response.Write(DesEncrypt(jt).ToLower());
            Response.End();
        }
    }
}