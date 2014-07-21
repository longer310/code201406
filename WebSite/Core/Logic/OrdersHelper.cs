using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using Backstage.Core.Entity;
using MySql.Data.MySqlClient;

namespace Backstage.Core.Logic
{
    public static class OrdersHelper
    {
        public static List<Orders> GetOrdersList(out int totalnum, string wheresql = "",
            string ordersql = "", int start = 0, int limit = 0, int gettotal = 1)
        {
            totalnum = 0;
            List<Orders> list = new List<Orders>();
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

                        list.Add(orders);
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
                                totalnum = reader.GetInt32(0);
                            }
                        }
                    }
                }
            }
            catch (System.Exception ex)
            {
                throw;
            }
            return list;
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
                                        CreateTime                  = ?CreateTime    
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
                parameters.Add(new MySqlParameter("?Status", orders.Status));
                parameters.Add(new MySqlParameter("?CreateTime", orders.CreateTime));
                parameters.Add(new MySqlParameter("?SellerId", orders.SellerId));
                parameters.Add(new MySqlParameter("?Ccontent", orders.Ccontent));
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
                                        CreateTime    
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
                                        ?CreateTime 
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
                parameters.Add(new MySqlParameter("?Status", orders.Status));
                parameters.Add(new MySqlParameter("?CreateTime", orders.CreateTime));
                parameters.Add(new MySqlParameter("?SellerId", orders.SellerId));
                parameters.Add(new MySqlParameter("?Ccontent", orders.Ccontent));
            }
            try
            {
                var num = MySqlHelper.ExecuteNonQuery(Utility._gameDbConn, CommandType.Text, cmdText, parameters.ToArray());

                if (orders.Id == 0)
                {//插入 获得新id

                    using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                    {
                        cmdText = @"select @@identity";
                        var reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText);
                        if (reader.HasRows)
                        {
                            if (reader.Read())
                            {
                                num = reader.GetInt32(0);
                            }
                        }
                    }

                }
                return num;
            }
            catch (System.Exception ex)
            {
                throw;
            }
        }
    }
}