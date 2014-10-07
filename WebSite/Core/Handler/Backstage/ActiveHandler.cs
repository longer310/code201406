using System.Data;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebSite;

using Backstage.Core.Entity;
using Backstage.Model;

namespace Backstage.Core.Handler.Backstage
{
    /// <summary>
    /// Active 的摘要说明
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
                case "update":
                    UpdateData(); break;
                case "delete":
                    Delete(); break;
                case "create":
                    Create(); break;
                default: break;
            }
        }

        private void Create()
        {
            var active = new Active();
            
            active.SellerId = GetInt("SellerId");
            active.CouponId = GetInt("ticket_id");
            active.Title = GetString("Title");
            active.CoverImgUrl = GetString("thumbnail");
            active.Description = GetString("content");
            var text = GetString("text");
            active.Summary = text.Length > 20 ? text.Substring(0, 20) : text;
            //active.Summary = active.Description.Length > 20 ? active.Description.Substring(0, 20) : active.Description;
            active.CreateTime = DateTime.Now;
            ActiveHelper.Create(active);
        }

        private void Delete()
        {
            var ids = Utility.GetListint(GetString("ids"));
            foreach (var id in ids)
            {
                ActiveHelper.Delete(id);
            }
        }

        private void UpdateData()
        {
            var id = GetInt("id");

            var active = ActiveHelper.GetItem(id);
            active.CouponId = GetInt("ticket_id");
            active.Title = GetString("Title");
            active.CoverImgUrl = GetString("thumbnail");
            active.Description = GetString("content");
            var text = GetString("text");
            active.Summary = text.Length > 20 ? text.Substring(0, 20) : text;
            //active.Summary = active.Description.Length > 20 ? active.Description.Substring(0, 20) : active.Description;

            ActiveHelper.Update(active);
        }


        private void GetItem()
        {
            int aid = GetInt("id");
            var item = ActiveHelper.GetItem(aid);
            if (item == null)
            {
                ReturnErrorMsg("资讯不存在：id" + aid);
                return;
            }
            var coupon = CouponHelper.GetItem(item.CouponId);
            var data = new
            {
                Id = item.Id,
                SellerId = item.SellerId,
                CouponId = item.CouponId,
                CouponTitle = coupon.Title,
                Summary = item.Summary,
                Title = item.Title,
                Views = item.Views,
                Commentnum = item.Commentnum,
                ImgId = item.CoverImgId,
                ImgUrl = item.CoverImgUrl == "" ? "http://placehold.it/128x128" : item.CoverImgUrl,
                CreateTime = item.CreateTime.ToString("yyyy-MM-dd HH:mm:ss"),
                Description = item.Description
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

            var data = ActiveHelper.GetPagings(sid, index * size, size);
            var result = new PagResults<object>();
            result.TotalCount = data.TotalCount;
            foreach (var item in data.Results)
            {
                var o = new
                {
                    Id = item.Id,
                    SellerId = item.SellerId,
                    Summary = item.Summary,
                    Title = item.Title,
                    Views = item.Views,
                    Commentnum = item.Commentnum,
                    ImgId = item.CoverImgId,
                    ImgUrl = item.CoverImgUrl == "" ? "http://placehold.it/128x128" : item.CoverImgUrl,
                    CreateTime = item.CreateTime.ToString("yyyy-MM-dd HH:mm:ss"),
                    Description = item.Description
                };
                result.Results.Add(o);
            }

            JsonTransfer jt = new JsonTransfer();
            jt.AddSuccessParam();
            jt.Add("data", result);
            Response.Write(DesEncrypt(jt).ToLower());
            Response.End();
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}