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
            int status = GetInt("status");
            int cid = GetInt("cid");

            var cs = PositionHelper.GetListBoxTypes(sid, 0, 0);
            var ps = PositionHelper.GetList(sid, index * size, size, cid, status);

            var data = new
            {
                categories = new List<object>(),
                lists = new List<object>()
            };

            foreach (var c in cs)
            {
                var d = new
                {
                    title = c.Title,
                    cid = c.Id,
                };
                data.categories.Add(d);
            }
            foreach (var item in ps)
            {
                var r = cs.FirstOrDefault(c => c.Id == item.BoxTypeId);
                if (r == null)
                    throw new ArgumentNullException(String.Format("包厢分类Id:{0}不存在", item.BoxTypeId));

                var p = new
                {
                    sid = item.Id,
                    hold = r.HoldNum,
                    price = item.Price,
                    cid = r.Id,
                    name = item.Title,
                    lowest = r.Lowest,
                    status = item.Status
                };
                data.lists.Add(p);
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
            var boxType = PositionHelper.GetBoxType(item.BoxTypeId);
            IList<Timeline> timeslot = PositionHelper.GetTimeLines(sid);
            var times = new List<object>();
            foreach (var t in timeslot)
            {
                var time_item = new
                {
                    name = t.Title,
                    time = t.BeginTime.ToString("yyyy-MM-dd HH:mm:ss") + "至" + t.EndTime.ToString("yyyy-MM-dd HH:mm:ss"),
                    status = t.Status,
                    tid = t.Id
                };
                times.Add(time_item);
            }
            var data = new
            {
                sid = item.Id,
                imgs = Utility.GetListstring(item.ImgUrls),
                cid = item.BoxTypeId,
                ctitle = boxType.Title,
                name = item.Title,
                price = item.Price,
                des = item.Description,
                lowest = boxType.Lowest,
                status = item.Status,
                timelost = times
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
                userPosition.TimeId = GetInt("tid");
                userPosition.Phone = GetString("mobile");
                userPosition.SellerId = GetInt("sellerid");
                //userPosition.CreateTime = new DateTime(GetInt("dateline"), DateTimeKind.Utc);
                //var account = AccountHelper.GetUserByPhone(userPosition.Phone, userPosition.SellerId);
                //userPosition.UserId = account.Id;
                //userPosition.NickName = account.NickName;

                var position = PositionHelper.GetItem(userPosition.PositionId);
                var timeline = PositionHelper.GetTimeLine(userPosition.TimeId);
                if (timeline.Status == 1)
                {
                    jt.Add("status", 0);
                    jt.Add("message", "该位置已经被预定了");
                    Response.Write(DesEncrypt(jt).ToLower());
                    //Response.End();
                    return;
                }
                PositionHelper.CreateUserPositon(userPosition);
                //userPosition = PositionHelper.GetUserPosition(userPosition.UserId, userPosition.PositionId);
                timeline.Status = 1;
                PositionHelper.UpdateTimeline(timeline);
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