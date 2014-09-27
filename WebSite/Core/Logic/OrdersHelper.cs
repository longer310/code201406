using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using Backstage.Core.Entity;
using Backstage.Model;
using log4net;
using log4net.Repository.Hierarchy;
using MySql.Data.MySqlClient;

namespace Backstage.Core.Logic
{
    public static class OrdersHelper
    {
        private static ILog logger = LogManager.GetLogger("OrdersHelper");
        public static PagResults<Orders> GetOrdersList(string wheresql = "",
            string ordersql = "", int start = 0, int limit = 0, int gettotal = 1)
        {
            var result = new PagResults<Orders>();
            result.Results = new List<Orders>();
            if (ordersql == "") ordersql = " order by CreateTime desc ";
            string limitsql = limit != 0 ? " LIMIT ?start,?limit" : string.Empty;
            var cmdText = @"select * from Orders " + wheresql + ordersql + limitsql;

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            if (!string.IsNullOrEmpty(limitsql))
            {
                parameters.Add(new MySqlParameter("?start", start));
                parameters.Add(new MySqlParameter("?limit", limit));
            }
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText,
                        parameters.ToArray());
                    while (reader.Read())
                    {
                        Orders orders = new Orders();
                        orders.Id = reader.GetInt32(0);
                        orders.UserId = (int)reader["UserId"];
                        orders.GidList = Utility.GetListint(reader["Gids"].ToString());
                        orders.NumList = Utility.GetListint(reader["Nums"].ToString());
                        orders.ImgList = Utility.GetListstring(reader["Imgs"].ToString());
                        orders.TitleList = Utility.GetListstring(reader["Titles"].ToString());
                        orders.ContentList = Utility.GetListstring(reader["Contents"].ToString());
                        orders.NowPriceList = Utility.GetListfloat(reader["NowPrices"].ToString());
                        orders.OriginalPriceList = Utility.GetListfloat(reader["OriginalPrices"].ToString());
                        orders.TotalPrice = (float)reader["TotalPrice"];
                        orders.StotalPrice = (float)reader["StotalPrice"];
                        orders.Pid = (int)reader["Pid"];
                        orders.OrderTime = (DateTime)reader["OrderTime"];
                        orders.OrderType = (OrderType)reader["OrderType"];
                        orders.OrderPeople = (int)reader["OrderPeople"];
                        orders.CouponId = (int)reader["CouponId"];
                        orders.CtotalPrice = (float)reader["CtotalPrice"];
                        orders.Address = reader["Address"].ToString();
                        orders.LinkMan = reader["LinkMan"].ToString();
                        orders.Mobile = reader["Mobile"].ToString();
                        orders.Remark = reader["Remark"].ToString();
                        orders.CreateTime = (DateTime)reader["CreateTime"];
                        orders.Status = (OrderStatus)reader["Status"];
                        orders.SellerId = (int)reader["SellerId"];
                        orders.Ccontent = reader["Ccontent"].ToString();
                        orders.Boxno = reader["Boxno"].ToString();
                        orders.CouponTitle = reader["CouponTitle"].ToString();

                        result.Results.Add(orders);
                    }

                    //一个函数有两次连接数据库 先把连接断开 然后重连
                    conn.Close();
                    conn.Dispose();
                    conn.Open();

                    if (gettotal == 1)
                    {
                        cmdText = string.Format("select count(*) from Orders ") + wheresql;
                        reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText);
                        if (reader.HasRows)
                        {
                            if (reader.Read())
                            {
                                result.TotalCount = reader.GetInt32(0);
                            }
                        }
                    }
                }
            }
            catch (System.Exception ex)
            {
                throw;
            }
            return result;
        }

        public static Orders GetOrders(int id, int uid = 0)
        {
            var sql = string.Format("select * from Orders where Id={0} {1} limit 1;", id,
                uid == 0 ? string.Empty : string.Format(" and UserId={0} ", uid));
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, sql);
                    if (reader.HasRows)
                    {
                        if (reader.Read())
                        {
                            Orders orders = new Orders();
                            orders.Id = reader.GetInt32(0);
                            orders.UserId = (int)reader["UserId"];
                            orders.GidList = Utility.GetListint(reader["Gids"].ToString());
                            orders.NumList = Utility.GetListint(reader["Nums"].ToString());
                            orders.ImgList = Utility.GetListstring(reader["Imgs"].ToString());
                            orders.TitleList = Utility.GetListstring(reader["Titles"].ToString());
                            orders.ContentList = Utility.GetListstring(reader["Contents"].ToString());
                            orders.NowPriceList = Utility.GetListfloat(reader["NowPrices"].ToString());
                            orders.OriginalPriceList = Utility.GetListfloat(reader["OriginalPrices"].ToString());
                            orders.TotalPrice = (float)reader["TotalPrice"];
                            orders.StotalPrice = (float)reader["StotalPrice"];
                            orders.Pid = (int)reader["Pid"];
                            orders.OrderTime = (DateTime)reader["OrderTime"];
                            orders.OrderType = (OrderType)reader["OrderType"];
                            orders.OrderPeople = (int)reader["OrderPeople"];
                            orders.CouponId = (int)reader["CouponId"];
                            orders.CtotalPrice = (float)reader["CtotalPrice"];
                            orders.Address = reader["Address"].ToString();
                            orders.LinkMan = reader["LinkMan"].ToString();
                            orders.Mobile = reader["Mobile"].ToString();
                            orders.CreateTime = (DateTime)reader["CreateTime"];
                            orders.Remark = reader["Remark"].ToString();
                            orders.Status = (OrderStatus)reader["Status"];
                            orders.SellerId = (int)reader["SellerId"];
                            orders.Ccontent = reader["Ccontent"].ToString();
                            orders.Boxno = reader["Boxno"].ToString();
                            orders.CouponTitle = reader["CouponTitle"].ToString();
                            return orders;
                        }
                    }
                }

            }
            catch (System.Exception ex)
            {
                throw;
            }
            return null;
        }

        /// <summary>
        /// 保存商品 如果id为0 则添加新纪录
        /// </summary>
        /// <param name="orders"></param>
        /// <returns>返回新插入的id，或者是否插入成功</returns>
        public static int SaveOrders(Orders orders)
        {
            var cmdText = string.Empty;
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            if (orders.Id > 0)
            {
                cmdText = @"UPDATE Orders SET
                                        UserId                      = ?UserId        ,
                                        Gids                        = ?Gids          ,
                                        Imgs                        = ?Imgs          ,
                                        Nums                        = ?Nums          ,
                                        Titles                      = ?Titles        ,
                                        Contents                      = ?Contents        ,
                                        NowPrices                   = ?NowPrices     ,
                                        OriginalPrices              = ?OriginalPrices,
                                        TotalPrice                  = ?TotalPrice    ,
                                        StotalPrice                 = ?StotalPrice   ,
                                        Pid                         = ?Pid           ,
                                        OrderTime                   = ?OrderTime     ,
                                        OrderType                   = ?OrderType     ,
                                        OrderPeople                 = ?OrderPeople   ,
                                        CouponId                    = ?CouponId      ,
                                        CtotalPrice                 = ?CtotalPrice   ,
                                        Address                     = ?Address       ,
                                        LinkMan                     = ?LinkMan       ,
                                        Mobile                      = ?Mobile        ,
                                        Remark                      = ?Remark        ,
                                        Status                      = ?Status        ,
                                        SellerId                      = ?SellerId        ,
                                        Ccontent                      = ?Ccontent        ,
                                        CreateTime                  = ?CreateTime    ,
                                        Boxno                  = ?Boxno    ,
                                        CouponTitle                  = ?CouponTitle    
                                    WHERE
                                        Id = ?Id";
                parameters.Add(new MySqlParameter("?Id", orders.Id));
                parameters.Add(new MySqlParameter("?UserId", orders.UserId));
                parameters.Add(new MySqlParameter("?Gids", Utility.GetString(orders.GidList)));
                parameters.Add(new MySqlParameter("?Imgs", Utility.GetString(orders.ImgList)));
                parameters.Add(new MySqlParameter("?Nums", Utility.GetString(orders.NumList)));
                parameters.Add(new MySqlParameter("?Titles", Utility.GetString(orders.TitleList)));
                parameters.Add(new MySqlParameter("?Contents", Utility.GetString(orders.ContentList)));
                parameters.Add(new MySqlParameter("?NowPrices", Utility.GetString(orders.NowPriceList)));
                parameters.Add(new MySqlParameter("?OriginalPrices", Utility.GetString(orders.OriginalPriceList)));
                parameters.Add(new MySqlParameter("?TotalPrice", orders.TotalPrice));
                parameters.Add(new MySqlParameter("?StotalPrice", orders.StotalPrice));
                parameters.Add(new MySqlParameter("?Pid", orders.Pid));
                parameters.Add(new MySqlParameter("?OrderTime", orders.OrderTime));
                parameters.Add(new MySqlParameter("?OrderType", orders.OrderType));
                parameters.Add(new MySqlParameter("?OrderPeople", orders.OrderPeople));
                parameters.Add(new MySqlParameter("?CouponId", orders.CouponId));
                parameters.Add(new MySqlParameter("?CtotalPrice", orders.CtotalPrice));
                parameters.Add(new MySqlParameter("?Address", orders.Address));
                parameters.Add(new MySqlParameter("?LinkMan", orders.LinkMan));
                parameters.Add(new MySqlParameter("?Mobile", orders.Mobile));
                parameters.Add(new MySqlParameter("?Remark", orders.Remark));
                parameters.Add(new MySqlParameter("?Status", (int)orders.Status));
                parameters.Add(new MySqlParameter("?CreateTime", orders.CreateTime));
                parameters.Add(new MySqlParameter("?SellerId", orders.SellerId));
                parameters.Add(new MySqlParameter("?Ccontent", orders.Ccontent));
                parameters.Add(new MySqlParameter("?Boxno", orders.Boxno));
                parameters.Add(new MySqlParameter("?CouponTitle", orders.CouponTitle));

                if (orders.Status == OrderStatus.Pay)
                {
                    var merchant = MerchantHelper.GetMerchant(orders.SellerId);
                    if (merchant.HasPrint == 1)
                    {
                        //云打印
                        Utility.SendOrdersMsgToPrint(orders);
                    }
                    if (Utility._msg_opensend == "1")
                    {
                        if (merchant != null)
                        {
                            //订单付款  通知商户 有两个地方有
                            SendMsgClass3 jsobject = new SendMsgClass3();
                            jsobject.param1 = merchant.Name;
                            jsobject.param2 = orders.Id.ToString();
                            jsobject.param3 = Utility._domainurl + "/view/dev/Index.aspx";

                            if (Utility.SendMsg(merchant.Phone, MsgTempleId.OrdersRemindMerchant, jsobject) != "发送成功")
                            {
                                logger.InfoFormat("短信模板：{0},Phone:{3},发送失败OrdersId：{1},SellerId:{2}",
                                    (int)MsgTempleId.OrdersRemindMerchant, orders.Id, orders.SellerId, merchant.Phone);
                            }

                            //通知会员
                            var user = AccountHelper.GetUser(orders.UserId);
                            if (user != null)
                            {
                                SendMsgClass4 jsobject2 = new SendMsgClass4();
                                jsobject2.param1 = string.IsNullOrEmpty(user.UserName) ? user.Phone : user.UserName;
                                jsobject2.param2 = orders.Id.ToString();
                                jsobject2.param3 = orders.TotalPrice.ToString();
                                jsobject2.param4 = merchant.Name;

                                if (Utility.SendMsg(user.Phone, MsgTempleId.OrdersFinish, jsobject2) != "发送成功")
                                {
                                    logger.InfoFormat("短信模板：{0},Phone:{3},发送失败OrdersId：{1},SellerId:{2}",
                                        (int)MsgTempleId.OrdersFinish, orders.Id, orders.SellerId, user.Phone);
                                }
                            }
                            else
                            {
                                logger.InfoFormat("订单查找用户失败OrdersId：{0},UserId:{1}", orders.Id, orders.UserId);
                            }
                        }
                        else
                        {
                            logger.InfoFormat("订单查找商户失败OrdersId：{0},SellerId:{1}", orders.Id, orders.SellerId);
                        }
                    }

                }
            }
            else
            {
                cmdText = @"insert into Orders
                                        (
                                        UserId        ,
                                        Gids          ,
                                        Imgs          ,
                                        Nums          ,
                                        Titles        ,
                                        Contents        ,
                                        NowPrices     ,
                                        OriginalPrices,
                                        TotalPrice    ,
                                        StotalPrice   ,
                                        Pid           ,
                                        OrderTime     ,
                                        OrderType     ,
                                        OrderPeople   ,
                                        CouponId      ,
                                        CtotalPrice   ,
                                        Address       ,
                                        LinkMan       ,
                                        Mobile        ,
                                        Remark        ,
                                        Status         ,
                                        SellerId       ,
                                        Ccontent       ,
                                        CreateTime    ,
                                        CouponTitle    
                                        ) 
                                        values
                                        (
                                        ?UserId        ,
                                        ?Gids          ,
                                        ?Imgs          ,
                                        ?Nums          ,
                                        ?Titles        ,
                                        ?Contents        ,
                                        ?NowPrices     ,
                                        ?OriginalPrices,
                                        ?TotalPrice    ,
                                        ?StotalPrice   ,
                                        ?Pid           ,
                                        ?OrderTime     ,
                                        ?OrderType     ,
                                        ?OrderPeople   ,
                                        ?CouponId      ,
                                        ?CtotalPrice   ,
                                        ?Address       ,
                                        ?LinkMan       ,
                                        ?Mobile        ,
                                        ?Remark        ,
                                        ?Status        ,
                                        ?SellerId      ,
                                        ?Ccontent      ,
                                        ?CreateTime ,
                                        ?CouponTitle 
                                        )";
                parameters.Add(new MySqlParameter("?UserId", orders.UserId));
                parameters.Add(new MySqlParameter("?Gids", Utility.GetString(orders.GidList)));
                parameters.Add(new MySqlParameter("?Imgs", Utility.GetString(orders.ImgList)));
                parameters.Add(new MySqlParameter("?Nums", Utility.GetString(orders.NumList)));
                parameters.Add(new MySqlParameter("?Titles", Utility.GetString(orders.TitleList)));
                parameters.Add(new MySqlParameter("?Contents", Utility.GetString(orders.ContentList)));
                parameters.Add(new MySqlParameter("?NowPrices", Utility.GetString(orders.NowPriceList)));
                parameters.Add(new MySqlParameter("?OriginalPrices", Utility.GetString(orders.OriginalPriceList)));
                parameters.Add(new MySqlParameter("?TotalPrice", orders.TotalPrice));
                parameters.Add(new MySqlParameter("?StotalPrice", orders.StotalPrice));
                parameters.Add(new MySqlParameter("?Pid", orders.Pid));
                parameters.Add(new MySqlParameter("?OrderTime", orders.OrderTime));
                parameters.Add(new MySqlParameter("?OrderType", orders.OrderType));
                parameters.Add(new MySqlParameter("?OrderPeople", orders.OrderPeople));
                parameters.Add(new MySqlParameter("?CouponId", orders.CouponId));
                parameters.Add(new MySqlParameter("?CtotalPrice", orders.CtotalPrice));
                parameters.Add(new MySqlParameter("?Address", orders.Address));
                parameters.Add(new MySqlParameter("?LinkMan", orders.LinkMan));
                parameters.Add(new MySqlParameter("?Mobile", orders.Mobile));
                parameters.Add(new MySqlParameter("?Remark", orders.Remark));
                parameters.Add(new MySqlParameter("?Status", (int)orders.Status));
                parameters.Add(new MySqlParameter("?CreateTime", orders.CreateTime));
                parameters.Add(new MySqlParameter("?SellerId", orders.SellerId));
                parameters.Add(new MySqlParameter("?Ccontent", orders.Ccontent));
                parameters.Add(new MySqlParameter("?CouponTitle", orders.CouponTitle));
            }
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    var num = MySqlHelper.ExecuteNonQuery(conn, CommandType.Text, cmdText, parameters.ToArray());

                    if (orders.Id == 0)
                    {//插入 获得新id
                        //LAST_INSERT_ID是基于Connection的，只要每个线程都使用独立的Connection对象，LAST_INSERT_ID函数将
                        //返回该Connection对AUTO_INCREMENT列最新的insert or update*作生成的第一个record的ID。这个值不能
                        //被其它客户端（Connection）影响，保证了你能够找回自己的 ID 而不用担心其它客户端的活动，而且不需
                        //要加锁。
                        cmdText = @"select LAST_INSERT_ID();";
                        var reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText);
                        if (reader.HasRows)
                        {
                            if (reader.Read())
                            {
                                num = reader.GetInt32(0);
                            }
                        }
                    }
                    return num;
                }
            }
            catch (System.Exception ex)
            {
                throw;
            }
        }

        /// <summary>
        /// 设置订单为已送餐
        /// </summary>
        /// <param name="ordersidList"></param>
        /// <returns></returns>
        public static bool SetOrdersListDelivered(List<int> ordersidList)
        {
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            var cmdText = "begin;";
            foreach (var id in ordersidList)
            {
                var tempcmdText = @"UPDATE Orders SET
                                        OrderType        = ?OrderType
                                    WHERE
                                        Id = ?Id;";
                string newStr = string.Format("?{0}", id);
                tempcmdText = tempcmdText.Replace("?", newStr);
                cmdText += tempcmdText;
                parameters.Add(new MySqlParameter(newStr + "OrderType", (int)OrderType.Deliveryed));
                parameters.Add(new MySqlParameter(newStr + "Id", id));
            }
            cmdText += "commit;";
            try
            {
                var num = MySqlHelper.ExecuteNonQuery(Utility._gameDbConn, CommandType.Text, cmdText, parameters.ToArray());
                return num > 0;

            }
            catch (System.Exception ex)
            {
                throw;
            }
            return false;
        }
    }
}