using Backstage.Core.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Handler
{
    public class PositionHandler : BaseApiHandler
    {
        public override void ProcessRequest(HttpContext context)
        {
            base.SetApiName("PositionHandler");
            base.ProcessRequest(HttpContext.Current);
            switch (Action)
            {
                case "getlist":
                    GetList(); break;
                case "getitem":
                    GetItem(); break;
                case "schedule":
                    Schedule(); break;
                case "updatestatus":
                    UpdateStatus(); break;
                default: break;
            }
        }

        private void GetList()
        {
            int index = GetInt("start");
            int size = GetInt("limit");
            int sid = GetInt("sellerid");

            var results = PositionHelper.GetList(sid, index, size);
            var data = new List<object>();
            foreach (var r in results)
            {
                var d = new
                {
                    sid = r.Id,
                    img = r.ImgUrl,
                    title = r.Title,
                    price = r.Price,
                    des = r.Description,
                    tel = r.Phone,
                    status = r.Status
                };
                data.Add(d);
            }

            JsonTransfer jt = new JsonTransfer();
            jt.AddSuccessParam();
            jt.Add("data", data);
            Response.Write(DesEncrypt(jt).ToLower());
            Response.End();
        }

        private void GetItem()
        {
            int sid = GetInt("sid");

            var item = PositionHelper.GetItem(sid);
            var data = new
            {
                sid = item.Id,
                img = item.ImgUrl,
                title = item.Title,
                price = item.Price,
                des = item.Description,
                tel = item.Phone,
                status = item.Status
            };


            JsonTransfer jt = new JsonTransfer();
            jt.AddSuccessParam();
            jt.Add("data", data);
            Response.Write(DesEncrypt(jt).ToLower());
            Response.End();
        }

        private void Schedule()
        {
            JsonTransfer jt = new JsonTransfer();
            try
            {
                var userPosition = new UserPosition();
                userPosition.PositionId = GetInt("sid");
                userPosition.UserId = GetInt("uid");
                userPosition.NickName = GetString("nickname");
                userPosition.PayId = GetInt("pid");
                userPosition.Message = GetString("message");
                userPosition.Phone = GetInt("mobile");
                userPosition.SellerId = GetInt("sellerid");
                userPosition.CreateTime = new DateTime(GetInt("dateline"), DateTimeKind.Utc);
                var old = PositionHelper.GetUserPosition(userPosition.UserId, userPosition.PositionId);
                var position = PositionHelper.GetItem(userPosition.PositionId);
                if (position.Status == 1)
                {
                    jt.Add("status", 0);
                    jt.Add("message", "该位置已经被预定了");
                    Response.Write(DesEncrypt(jt).ToLower());
                    Response.End();
                    return;
                }
                if (old.Id != 0)
                {
                    jt.Add("status", 0);
                    jt.Add("message", "该用户已经预定过该位置");
                    Response.Write(DesEncrypt(jt).ToLower());
                    Response.End();
                    return;
                }
                PositionHelper.CreateUserPositon(userPosition);
                userPosition = PositionHelper.GetUserPosition(userPosition.UserId, userPosition.PositionId);
                var data = new { orderId = userPosition.Id };
                jt.Add("data", data);

            }
            catch
            {
                jt.Add("status", 0);
                jt.Add("message", "订位失败");
                Response.Write(DesEncrypt(jt).ToLower());
                Response.End();
            }


            jt.AddSuccessParam();
            Response.Write(DesEncrypt(jt).ToLower());
            Response.End();
        }

        private void UpdateStatus()
        {
            int orderid = GetInt("orderid");
            int userId = GetInt("uid");
            int status = GetInt("status");
            var order = PositionHelper.GetUserPosition(orderid);
            if (order.Id != 0)
            {
                order.Status = 1;
                PositionHelper.UpdateUserPosition(order);
            }
            JsonTransfer jt = new JsonTransfer();
            jt.AddSuccessParam();
            Response.Write(DesEncrypt(jt).ToLower());
            Response.End();
        }





    }
}