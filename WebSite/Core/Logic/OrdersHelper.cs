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
                MySqlDataReader reader = MySqlHelper.ExecuteReader(Utility._gameDbConn, CommandType.Text, cmdText,
                    parameters.ToArray());
                while (reader.Read())
                {
                    Orders orders = new Orders();
                    orders.Id = reader.GetInt32(0);
                    orders.UserId = (int)reader["UserId"];
                    orders.Img = reader["Img"].ToString();
                    orders.Gid = (int)reader["Gid"];
                    orders.Price = (float)reader["Price"];
                    orders.Num = (int)reader["Num"];
                    orders.CreateTime = (DateTime)reader["CreateTime"];

                    list.Add(orders);
                }

                if (gettotal == 1)
                {
                    cmdText = string.Format("select count(*) from Orders ") + wheresql;
                    reader = MySqlHelper.ExecuteReader(Utility._gameDbConn, CommandType.Text, cmdText);
                    if (reader.HasRows)
                    {
                        if (reader.Read())
                        {
                            totalnum = reader.GetInt32(0);
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

        public static Orders GetOrders(int id)
        {
            var sql = string.Format("select * from Orders where Id={0} limit 1;", id);
            try
            {
                MySqlDataReader reader = MySqlHelper.ExecuteReader(Utility._gameDbConn, CommandType.Text, sql);
                if (reader.HasRows)
                {
                    if (reader.Read())
                    {
                        Orders orders = new Orders();
                        orders.Id = reader.GetInt32(0);
                        orders.UserId = (int)reader["UserId"];
                        orders.Img = reader["Img"].ToString();
                        orders.Gid = (int)reader["Gid"];
                        orders.Price = (float)reader["Price"];
                        orders.Num = (int)reader["Num"];
                        orders.CreateTime = (DateTime)reader["CreateTime"];
                        return orders;
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
        /// <returns></returns>
        public static bool SaveOrders(Orders orders)
        {
            var cmdText = string.Empty;
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            if (orders.Id > 0)
            {
                cmdText = @"UPDATE Orders SET
                                        UserId        = ?UserId,
                                        Gid          = ?Gid,
                                        Img            = ?Img,
                                        Num           = ?Num,
                                        Price            = ?Price,
                                        CreateTime           = ?CreateTime
                                    WHERE
                                        Id = ?Id";
                parameters.Add(new MySqlParameter("?Id",            orders.Id));
                parameters.Add(new MySqlParameter("?UserId",        orders.UserId));
                parameters.Add(new MySqlParameter("?Gid",           orders.Gid));
                parameters.Add(new MySqlParameter("?Img",           orders.Img));
                parameters.Add(new MySqlParameter("?Num",           orders.Num));
                parameters.Add(new MySqlParameter("?Price",         orders.Price));
                parameters.Add(new MySqlParameter("?CreateTime",    orders.CreateTime));
            }
            else
            {
                cmdText = @"insert into Orders
                                        (
                                        UserId      ,
                                        Gid        ,
                                        Img          ,
                                        Num         ,
                                        Price         ,
                                        CreateTime        
                                        ) 
                                        values
                                        (
                                        ?UserId      ,
                                        ?Gid        ,
                                        ?Img          ,
                                        ?Num         ,
                                        ?Price          ,
                                        ?CreateTime           
                                        )";
                parameters.Add(new MySqlParameter("?UserId", orders.UserId));
                parameters.Add(new MySqlParameter("?Gid", orders.Gid));
                parameters.Add(new MySqlParameter("?Img", orders.Img));
                parameters.Add(new MySqlParameter("?Num", orders.Num));
                parameters.Add(new MySqlParameter("?Price", orders.Price));
                parameters.Add(new MySqlParameter("?CreateTime", orders.CreateTime));
            }
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