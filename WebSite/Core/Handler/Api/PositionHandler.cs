﻿using Backstage.Core.Entity;
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

            var categories = PositionHelper.GetListBoxTypes(sid, index * size, size);
            var data = new List<object>();

            foreach (var r in categories)
            {
                var items = PositionHelper.GetListByBoxTypeId(r.Id);

                var d = new
                {
                    title = r.Title,
                    cid = r.Id,
                    list = new List<object>()
                };

                foreach (var item in items)
                {
                    d.list.Add(new
                    {
                        sid = item.Id,
                        hold = r.HoldNum,
                        price = item.Price,
                        cid = r.Id,
                        lowest = r.Lowest,
                        status = item.Status
                    });
                }

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