using Backstage.Core.Entity;
using Backstage.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Handler.Backstage
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
                case "usercoupon":
                    UserCoupon(); break;
                //case "deldata":
                //    DelData(); break;
                default: break;
            }
        }

        private void UserCoupon()
        {
            int cid = GetInt("couponid");
            int userId = GetInt("uid");
            int index = GetInt("start");
            int size = GetInt("limit");
            JsonTransfer jt = new JsonTransfer();
            try
            {
                var userCoupon = new UserCoupon()
                {
                    CouponId = cid,
                    UserId = userId
                    //CreateTime = DateTime.Now
                };
                var old = CouponHelper.GetUserCoupon(userId, cid);
                if (old != null && old.Id != 0)
                {
                    jt.Add("status", 0);
                    jt.Add("message", "用户已经使用过该优惠券");
                    Response.Write(DesEncrypt(jt).ToLower());
                    Response.End();
                    return;
                }
                CouponHelper.CreateUserCoupon(userCoupon);
            }
            catch
            {
                throw;
            }

            jt.AddSuccessParam();
            Response.Write(DesEncrypt(jt).ToLower());
            Response.End();
        }

        private void Couponcommentlist()
        {
            int cid = GetInt("couponid");
            int index = GetInt("start");
            int size = GetInt("limit");
            var coupon = CouponHelper.GetItem(cid);
            var cms = CommentHelper.GetPagings(coupon.SellerId, CommentType.Coupons, cid, index, size);
            var data = new CommentsForApis();
            data.Commentnum = cms.TotalCount;
            if (cms.TotalCount == 0)
            {
                JsonTransfer jt = new JsonTransfer();
                jt.AddSuccessParam();
                jt.Add("data", data);
                Response.Write(DesEncrypt(jt).ToLower());
                Response.End();
            }
            else
            {
                var users = AccountHelper.GetUserList(cms.Results.Select(c => c.UserId).ToList());
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

                JsonTransfer jt = new JsonTransfer();
                jt.AddSuccessParam();
                jt.Add("data", data);
                Response.Write(DesEncrypt(jt).ToLower());
                Response.End();
            }
        }

        private void CouponComment()
        {
            int cid = GetInt("couponid");
            int uid = GetInt("uid");
            string msg = GetString("message");
            var coupon = CouponHelper.GetItem(cid);
            Comment c = new Comment();
            c.SellerId = coupon.SellerId;
            c.TypeId = coupon.Id;
            c.UserId = uid;
            c.Content = msg;
            c.Type = CommentType.Coupons;
            //冗余两个字段
            c.Img = coupon.ImgUrl;
            c.Title = coupon.Title;

            try
            {
                CommentHelper.Create(c);
                coupon.Commentnum += 1;
                CouponHelper.Update(coupon);
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
            int cid = GetInt("couponid");
            var item = CouponHelper.GetItem(cid);
            var data = new
            {
                couponid = item.Id,
                title = item.Title,
                img = item.ImgUrl,
                extcredit = item.Extcredit,
                expiry = item.Expiry.GetUnixTime(),
                description = item.Description

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

            var results = CouponHelper.GetPagings(sid, index * size, size);
            var data = new PagResults<object>();
            data.TotalCount = results.TotalCount;
            foreach (var item in results.Results)
            {
                var o = new
                {
                    Id = item.Id,
                    ImgId = item.ImgId,
                    ImgUrl = item.ImgUrl,
                    SellerId = item.SellerId,
                    Status = item.Status,
                    Summary = item.Summary,
                    Title = item.Title,
                    Commentnum = item.Commentnum,
                    Description = item.Description,
                    DiscountMoney = item.DiscountMoney,
                    Expiry = item.Expiry.ToString("yyyy-MM-dd HH:mm:ss"),
                    Extcredit = item.Extcredit,
                    FullMoney = item.FullMoney
                };
                data.Results.Add(o);
            }

            JsonTransfer jt = new JsonTransfer();
            jt.AddSuccessParam();
            jt.Add("data", data);
            Response.Write(DesEncrypt(jt));
            Response.End();
        }
    }
}