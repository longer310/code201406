using Backstage.Core.Entity;
using Backstage.Core.Logic;
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
                case "negateshelf":
                    NegateShelf(); break;
                case "getgoods":
                    GetGoods(); break;
                case "delete":
                    Delete(); break;
                case "create":
                    Create(); break;
                case "update":
                    Update(); break;
                default: break;
            }
        }

        private void Update()
        {
            int id = GetInt("id");
            var item = CouponHelper.GetItem(id);
            item.Title = GetString("title");
            var expiry = GetString("expire_date");
            item.Expiry = expiry != "-1" ? GetTime("expire_date") : DateTime.Now.AddDays(1);
            item.ImgUrl = GetString("thumbnail");
            item.Extcredit = GetInt("score");
            item.FullMoney = GetInt("total");
            item.DiscountMoney = GetInt("discount");
            item.Enabled = 1;
            item.GoodsIds = Utility.GetListint(GetString("goods_selected"));
            item.Description = GetString("content");
            item.Summary = item.Description.Substring(0, 20);

            CouponHelper.CreateCoupon(item);
        }

        private void Create()
        {
            var item = new Coupon();
            item.Title = GetString("title");
            var expiry = GetString("expire_date");
            item.SellerId = GetInt("sellerid");
            item.Expiry = expiry != "-1" ? GetTime("expire_date") : DateTime.Now.AddDays(1);
            item.ImgUrl = GetString("thumbnail");
            item.Extcredit = GetInt("score");
            item.FullMoney = GetInt("total");
            item.DiscountMoney = GetInt("discount");
            item.Enabled = 1;
            item.GoodsIds = Utility.GetListint(GetString("goods_selected"));
            item.Description = GetString("content");
            item.Summary = item.Description.Length > 20 ? item.Description.Substring(0, 20) : item.Description;

            CouponHelper.CreateCoupon(item);
        }

        private void GetGoods()
        {
            var sellerid = GetInt("sellerid");
            var start = GetInt("start");
            var limit = GetInt("limit");
            var goods = GoodsHelper.GetGoodsList(sellerid, "", "", start * limit, limit);
            var data = new PagResults<object>();
            data.TotalCount = goods.TotalCount;
            foreach (var item in goods.Results)
            {
                var o = new
                {
                    id = item.Id,
                    title = item.Title
                };
                data.Results.Add(o);
            }
            JsonTransfer jt = new JsonTransfer();
            jt.Add("data", data);
            Response.Write(DesEncrypt(jt).ToLower());
            Response.End();

        }

        private void NegateShelf()
        {
            var ids = Utility.GetListint("ids");
            foreach (var id in ids)
            {
                var item = CouponHelper.GetItem(id);
                item.Enabled = item.Enabled == 1 ? -1 : 1;
                CouponHelper.Update(item);
            }
        }

        private void Delete()
        {
            var ids = Utility.GetListint("ids");
            foreach (var id in ids)
            {
                CouponHelper.Delete(id);
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
            int type = GetInt("type");

            var results = CouponHelper.GetPagings(sid, type, index * size, size);
            var data = new PagResults<object>();
            data.TotalCount = results.TotalCount;
            foreach (var item in results.Results)
            {
                var o = new
                {
                    Id = item.Id,
                    ImgId = item.ImgId,
                    ImgUrl = item.ImgUrl == "" ? "http://placehold.it/180x90" : item.ImgUrl,
                    SellerId = item.SellerId,
                    Status = item.Enabled,
                    Summary = item.Summary,
                    Title = item.Title,
                    Commentnum = item.Commentnum,
                    Description = item.Description,
                    DiscountMoney = item.DiscountMoney,
                    Expiry = item.Expiry.ToString("yyyy-MM-dd HH:mm:ss"),
                    Extcredit = item.Extcredit,
                    FullMoney = item.FullMoney,
                    DownloadTimes = item.DownloadTimes,
                    UserTimes = item.UsedTimes
                };
                data.Results.Add(o);
            }

            JsonTransfer jt = new JsonTransfer();
            jt.AddSuccessParam();
            jt.Add("data", data);
            Response.Write(DesEncrypt(jt).ToLower());
            Response.End();
        }
    }
}