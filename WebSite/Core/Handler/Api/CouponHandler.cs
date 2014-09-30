using Backstage.Core.Entity;
using Backstage.Core.Logic;
using Backstage.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Handler
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
                    GetList(context); break;
                case "getitem":
                    GetItem(context); break;
                case "usercoupon":
                    UserCoupon(); break;
                case "couponcommentlist":
                    Couponcommentlist(context); break;
                case "couponcomment":
                    CouponComment(); break;
                case "add":
                    Add(); break;
                case "update":
                    Update(); break;
                case "delete":
                    Delete(); break;
                //case "deldata":
                //    DelData(); break;
                default: break;
            }
        }

        private void Delete()
        {
            var id = GetInt("id");

            throw new NotImplementedException();
        }

        private void Update()
        {

            throw new NotImplementedException();
        }

        private void Add()
        {


            throw new NotImplementedException();
        }

        private void UserCoupon()
        {
            int couponid = GetInt("couponid");
            int userId = GetInt("uid");

            try
            {
                var coupon = CouponHelper.GetItem(couponid);
                if (coupon == null)
                    ReturnCorrectMsg(string.Format("优惠券不存在couponid:{0}", couponid));
                var user = AccountHelper.GetUser(userId);

                var userCoupon = new UserCoupon()
                {
                    CouponId = couponid,
                    UserId = userId,
                    Status = 0,
                    SellerId = coupon.SellerId
                };
                var old = CouponHelper.GetUserCoupon(userId, couponid);
                if (old != null && old.Id != 0)
                {
                    ReturnErrorMsg("已领取过该优惠券");
                    return;
                }
                if (coupon.Extcredit > user.Integral)
                {
                    ReturnErrorMsg("积分不足");
                    return;
                }

                user.Integral -= coupon.Extcredit;
                AccountHelper.SaveAccount(user);
                CouponHelper.CreateUserCoupon(userCoupon);
                coupon.DownloadTimes++;
                CouponHelper.Update(coupon);
            }
            catch
            {
                throw;
            }

            ReturnCorrectMsg("领取优惠券成功");
        }

        private void Couponcommentlist(HttpContext context)
        {
            int cid = GetInt("couponid");
            int index = GetInt("start");
            int size = GetInt("limit");
            var coupon = CouponHelper.GetItem(cid);
            var cms = CommentHelper.GetPagings(coupon.SellerId, CommentType.Coupons, cid, index * size, size);
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
                        Avatar = Utility.GetSizePicUrl(user.Avatar, 100, 100, context),
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
            var user = AccountHelper.GetUser(uid);
            ExtcreditLog log = new ExtcreditLog();
            if (!ExtcreditLogHelper.JudgeExtcreditGet(ExtcreditSourceType.CommentCoupon, cid, uid))
            {
                //积分获得
                log.UserId = uid;
                log.SellerId = user.SellerId;
                log.SourceId = cid;
                log.Extcredit = ParamHelper.ExtcreditCfgData.Comment;
                log.Type = ExtcreditSourceType.CommentCoupon;
                log.CreateTime = DateTime.Now;

                ExtcreditLogHelper.AddExtcreditLog(log);

                user.Integral += log.Extcredit;
                AccountHelper.SaveAccount(user);
            }

            //ReturnCorrectMsg("评论成功");
            JsonTransfer jt = new JsonTransfer();
            jt.Add("data", new IntegralData(log.Extcredit));
            jt.AddSuccessParam();
            Response.Write(DesEncrypt(jt).ToLower());
            Response.End();
        }

        private void GetItem(HttpContext context)
        {
            int cid = GetInt("couponid");
            var item = CouponHelper.GetItem(cid);
            if (item == null)
            {
                ReturnErrorMsg("电子券不存在id:" + cid);
                return;
            }
            var data = new
            {
                couponid = item.Id,
                title = item.Title,
                img = Utility.GetSizePicUrl(item.ImgUrl, 540, 400, context),
                extcredit = item.Extcredit,
                expiry = item.Expiry.GetUnixTime(),
                description = item.Description,
                Views = item.Views,
                Commentnum = item.Commentnum
            };
            JsonTransfer jt = new JsonTransfer();
            jt.AddSuccessParam();
            jt.Add("data", data);
            Response.Write(DesEncrypt(jt).ToLower());
            Response.End();
        }

        public void GetList(HttpContext context)
        {
            int index = GetInt("start");
            int size = GetInt("limit");
            int sid = GetInt("sellerid");
            int type = GetInt("type");

            var results = CouponHelper.GetPagings(sid, index * size, size);
            var data = new List<object>();
            foreach (var r in results.Results)
            {
                var d = new
                {
                    couponid = r.Id,
                    title = r.Title,
                    img = Utility.GetSizePicUrl(r.ImgUrl, 180, 143, context),
                    extcredit = r.Extcredit,
                    expiry = r.Expiry.GetUnixTime(),
                    description = r.Description,
                    Views = r.Views,
                    Commentnum = r.Commentnum
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