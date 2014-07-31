using System;
using System.Collections.Generic;
using System.EnterpriseServices;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Xml.Serialization;
using Backstage.Core;
using Backstage.Core.Entity;
using Backstage.Core.Logic;

namespace Backstage.Handler
{
    public class OrdersHandler : BaseHandler
    {
        public override void ProcessRequest(HttpContext context)
        {
            //FreeActions = ",saveGoodsList,";
            RoleType = RoleType.ThirdUser;//需商家管理权限 暂定权限管理
            base.ProcessRequest(HttpContext.Current);
            switch (Action)
            {
                #region 订单列表
                case "getOrdersList":
                    GetOrdersList(); break;
                #endregion

                default: break;
            }
        }

        #region 订单列表
        public class ResOrdersList
        {
            public List<OrdersItem> list { get; set; }

            public ResOrdersList()
            {
                list = new List<OrdersItem>();
            }
        }

        public class OrdersItem
        {
            public int Id { get; set; }
            public int UserId { get; set; }
            public int GoodsCount { get; set; }
            public float Money { get; set; }
            public string CreateTime { get; set; }
            public int Status { get; set; }
            public int Type { get; set; }
        }
        /// <summary>
        /// 获取订单列表
        /// </summary>
        public void GetOrdersList()
        {
            int start = GetInt("start");
            int limit = GetInt("limit");
            var type = (ReqOrderStatus)(GetInt("type") + 1);

            var wheresql = "";//string.Format(" where Status={0} ", (int)OrderStatus.Pay)
            switch (type)
            {
                case ReqOrderStatus.Pay:
                    wheresql = string.Format(" where Status={0} ", (int)OrderStatus.Pay);
                    break;
                case ReqOrderStatus.WaitDeliverGoods:
                    wheresql = string.Format(" where OrderType={0} and Status={1} ", (int)OrderType.WaitDelivery, (int)OrderStatus.Pay);
                    break;
                case ReqOrderStatus.DeliverGoodsed:
                    wheresql = string.Format(" where OrderType={0} and Status={1} ", (int)OrderType.Deliveryed, (int)OrderStatus.Pay);
                    break;
                case ReqOrderStatus.End:
                    wheresql = string.Format(" where Status={0} ", (int)OrderStatus.End);
                    break;
                default: break;
            }

            var result = OrdersHelper.GetOrdersList(wheresql, "", start * limit, limit, 1);
            var list = new List<OrdersItem>();
            foreach (var item in result.Results)
            {
                var i = new OrdersItem();
                i.Id = item.Id;
                i.UserId = item.UserId;
                i.Money = item.TotalPrice;
                i.CreateTime = item.CreateTime.ToString("yyyy-M-d HH:mm:ss");
                i.GoodsCount = item.NumList.Sum(o => o);
                i.Status = (int)item.GetReqStatus();
                i.Type = (int)item.OrderType;

                list.Add(i);
            }

            var jt = new JsonTransfer();
            jt.Add("list", list);
            jt.Add("count", result.TotalCount);
            Response.Write(jt.ToJson());
            Response.End();
        }

        #endregion
    }
}