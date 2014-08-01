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
                case "getOrdersDetail":
                    GetOrdersDetail(); break;
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

        public class OrdersDetailData
        {
            public int Id { get; set; }
            public int Type { get; set; }
            public int Status { get; set; }
            public string CreateTime { get; set; }
            /// <summary>
            /// 送货地址
            /// </summary>
            public string Address { get; set; }
            /// <summary>
            /// 联系人
            /// </summary>
            public string LinkMan { get; set; }
            /// <summary>
            /// 联系方式
            /// </summary>
            public string Mobile { get; set; }
            /// <summary>
            /// 电子券优惠价格
            /// </summary>
            public float CtotalPrice { get; set; }
            /// <summary>
            /// 电子券描述
            /// </summary>
            public string Ccontent { get; set; }
            /// <summary>
            /// 备注
            /// </summary>
            public string Remark { get; set; }
            /// <summary>
            /// 最后总价
            /// </summary>
            public float TotalPrice { get; set; }
            /// <summary>
            /// 商品总价
            /// </summary>
            public float StotalPrice { get; set; }
            public float SendPrice { get; set; }

            public List<OrdersGoodsItem> list { get; set; }

            public OrdersDetailData()
            {
                list = new List<OrdersGoodsItem>();
            }
        }

        public class OrdersGoodsItem
        {
            public string ImgUrl { get; set; }
            public string Title { get; set; }
            public float NowPrice { get; set; }
            public int Num { get; set; }
            public float TotalPrice { get; set; }
        }
        /// <summary>
        /// 获取订单详情
        /// </summary>
        public void GetOrdersDetail()
        {
            var orderid = GetInt("orderid");
            var orders = OrdersHelper.GetOrders(orderid);
            if (orders == null)
            {
                ReturnCorrectMsg("订单不存在");
                return;
            }
            if (orders.SellerId != CurrentUser.Id)
            {
                ReturnCorrectMsg("无权访问订单");
                return;
            }
            if (orders.GidList.Count != orders.ImgList.Count || orders.ImgList.Count != orders.TitleList.Count || orders.TitleList.Count != orders.NumList.Count || orders.NumList.Count != orders.NowPriceList.Count)
            {
                ReturnCorrectMsg("订单数据出错");
                return;
            }
            var data = new OrdersDetailData();
            data.Id = orders.Id;
            data.CreateTime = orders.CreateTime.ToString("yyyy-M-d HH:mm:ss");
            data.Status = (int)orders.GetReqStatus();
            data.Type = (int)orders.OrderType;
            data.Address = orders.Address;
            data.LinkMan = orders.LinkMan;
            data.Mobile = orders.Mobile;
            data.CtotalPrice = orders.CtotalPrice;
            data.Ccontent = orders.Ccontent;
            data.Remark = orders.Remark;
            data.TotalPrice = orders.TotalPrice;
            data.StotalPrice = orders.StotalPrice;
            data.SendPrice = ParamHelper.MerchantCfgData.SendPrice;

            var i = 0;
            foreach (var url in orders.ImgList)
            {
                var item = new OrdersGoodsItem();
                item.ImgUrl = url;
                item.Title = orders.TitleList[i];
                item.NowPrice = orders.NowPriceList[i];
                item.Num = orders.NumList[i];
                item.TotalPrice = item.NowPrice * item.Num;

                data.list.Add(item);
            }

            var jt = new JsonTransfer();
            jt.Add("data", data);
            Response.Write(jt.ToJson());
            Response.End();
        }
        #endregion
    }
}