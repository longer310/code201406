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
    public class UserHandler : BaseHandler
    {
        public override void ProcessRequest(HttpContext context)
        {
            //FreeActions = ",saveGoodsList,";
            RoleType = RoleType.Merchant;//需商家管理权限 暂定权限管理
            base.ProcessRequest(HttpContext.Current);
            switch (Action)
            {
                #region 会员列表
                case "getUserList":
                    GetUserList(); break;
                #endregion
                default: break;
            }
        }

        #region 会员列表
        /// <summary>
        /// 获取订单列表
        /// </summary>
        public void GetUserList()
        {
            int start = GetInt("start");
            int limit = GetInt("limit");

            string wheresql = string.Format(" where SellerId = {0} and Status = 0", CurrentUser.Id);
            var result = AccountHelper.GetUserList(wheresql, "", start * limit, limit, 1);
            //var list = new List<OrdersItem>();
            //foreach (var item in result.Results)
            //{
            //    var i = new OrdersItem();
            //    i.Id = item.Id;
            //    i.UserId = item.UserId;
            //    i.Money = item.TotalPrice;
            //    i.CreateTime = item.CreateTime.ToString("yyyy-M-d HH:mm:ss");
            //    i.GoodsCount = item.NumList.Sum(o => o);
            //    i.Status = (int)item.GetReqStatus();
            //    i.Type = (int)item.OrderType;

            //    list.Add(i);
            //}

            var jt = new JsonTransfer();
            jt.Add("list", result.Results);
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
                ReturnErrorMsg("订单不存在");
                return;
            }
            if (orders.SellerId != CurrentUser.Id)
            {
                ReturnErrorMsg("无权访问订单");
                return;
            }
            if (orders.GidList.Count != orders.ImgList.Count || orders.ImgList.Count != orders.TitleList.Count || orders.TitleList.Count != orders.NumList.Count || orders.NumList.Count != orders.NowPriceList.Count)
            {
                ReturnErrorMsg("订单数据出错");
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

        /// <summary>
        /// 设置订单已发送
        /// </summary>
        public void SetOrdersDelivered()
        {
            var orderids = GetString("ids");
            var orderidList = Utility.GetListint(orderids);
            if (orderidList.Count == 0)
            {
                ReturnErrorMsg("需传订单id");
                return;
            }
            var wheresql = Utility.GetWhereSql(orderidList);
            var ordersList = OrdersHelper.GetOrdersList(wheresql);
            if (ordersList == null || orderidList.Count() != ordersList.Results.Count)
            {
                ReturnErrorMsg("订单不存在");
                return;
            }
            if (ordersList.Results.Any(o => o.OrderType == OrderType.Shop))
            {
                ReturnErrorMsg("订单为到店类型无需送餐");
                return;
            }
            if (ordersList.Results.Any(o => o.OrderType == OrderType.Deliveryed))
            {
                ReturnErrorMsg("订单状态原本即为已送餐");
                return;
            }
            if (ordersList.Results.Any(o => o.SellerId != CurrentUser.Id))
            {
                ReturnErrorMsg("无权操作该订单");
                return;
            }

            if (OrdersHelper.SetOrdersListDelivered(orderidList))
                ReturnCorrectMsg("设置成功");
            else
                ReturnErrorMsg("设置失败");
        }
        #endregion
    }
}
