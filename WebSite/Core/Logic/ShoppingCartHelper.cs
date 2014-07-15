using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using Backstage.Core.Entity;
using MySql.Data.MySqlClient;

namespace Backstage.Core.Logic
{
    public static class ShoppingCartHelper
    {
        public static List<ShoppingCart> GetShoppingCartList(out int totalnum, string wheresql = "",
            string ordersql = "", int gettotal = 1, int start = 0, int limit = 0)
        {
            totalnum = 0;
            List<ShoppingCart> list = new List<ShoppingCart>();
            if (ordersql == "") ordersql = " order by CreateTime desc ";
            string limitsql = limit != 0 ? " LIMIT ?start,?limit" : String.Empty;
            var cmdText = @"select * from ShoppingCart " + wheresql + ordersql + limitsql;

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            if (!String.IsNullOrEmpty(limitsql))
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
                        ShoppingCart shoppingcart = new ShoppingCart();
                        shoppingcart.Id = reader.GetInt32(0);
                        shoppingcart.UserId = (int)reader["UserId"];
                        shoppingcart.Gid = (int)reader["Gid"];
                        //shoppingcart.Img = reader["Img"].ToString();
                        //shoppingcart.Nowprice = (float)reader["Nowprice"];
                        //shoppingcart.OriginalPrice = (float)reader["OriginalPrice"];
                        //shoppingcart.Title = reader["Title"].ToString();
                        //shoppingcart.Description = reader["Description"].ToString();
                        shoppingcart.Num = (int)reader["Num"];
                        shoppingcart.CreateTime = (DateTime)reader["CreateTime"];

                        list.Add(shoppingcart);
                    }

                    //一个函数有两次连接数据库 先把连接断开 然后重连
                    conn.Close();
                    conn.Dispose();
                    conn.Open();

                    if (gettotal == 1)
                    {
                        cmdText = String.Format("select count(*) from ShoppingCart ") + wheresql;
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
            catch (Exception ex)
            {
                throw;
            }
            return list;
        }
        /// <summary>
        /// 根据id查找购物车
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static ShoppingCart GetShoppingCart(int id)
        {
            var sql = String.Format("select * from ShoppingCart where Id={0} limit 1;", id);
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, sql);
                    if (reader.HasRows)
                    {
                        if (reader.Read())
                        {
                            ShoppingCart shoppingcart = new ShoppingCart();
                            shoppingcart.Id = reader.GetInt32(0);
                            shoppingcart.UserId = (int)reader["UserId"];
                            shoppingcart.Gid = (int)reader["Gid"];
                            //shoppingcart.Img = reader["Img"].ToString();
                            //shoppingcart.Nowprice = (float)reader["Nowprice"];
                            //shoppingcart.OriginalPrice = (float)reader["OriginalPrice"];
                            //shoppingcart.Title = reader["Title"].ToString();
                            //shoppingcart.Description = reader["Description"].ToString();
                            shoppingcart.Num = (int)reader["Num"];
                            shoppingcart.CreateTime = (DateTime)reader["CreateTime"];
                            return shoppingcart;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw;
            }
            return null;
        }

        /// <summary>
        /// 通过用户和产品查找购物车
        /// </summary>
        /// <param name="uid"></param>
        /// <param name="gid"></param>
        /// <returns></returns>
        public static ShoppingCart GetShoppingCartByGid(int uid, int gid)
        {
            var sql = String.Format("select * from ShoppingCart where UserId={0} and Gid={1} limit 1;", uid, gid);
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, sql);
                    if (reader.HasRows)
                    {
                        if (reader.Read())
                        {
                            ShoppingCart shoppingcart = new ShoppingCart();
                            shoppingcart.Id = reader.GetInt32(0);
                            shoppingcart.UserId = (int)reader["UserId"];
                            shoppingcart.Gid = (int)reader["Gid"];
                            //shoppingcart.Img = reader["Img"].ToString();
                            //shoppingcart.Nowprice = (float)reader["Nowprice"];
                            //shoppingcart.OriginalPrice = (float)reader["OriginalPrice"];
                            //shoppingcart.Title = reader["Title"].ToString();
                            //shoppingcart.Description = reader["Description"].ToString();
                            shoppingcart.Num = (int)reader["Num"];
                            shoppingcart.CreateTime = (DateTime)reader["CreateTime"];
                            return shoppingcart;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw;
            }
            return null;
        }
        /// <summary>
        /// 保存商品 如果id为0 则添加新纪录
        /// </summary>
        /// <param name="shoppingcart"></param>
        /// <returns></returns>
        public static bool SaveShoppingCart(ShoppingCart shoppingcart)
        {
            var cmdText = String.Empty;
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            if (shoppingcart.Id > 0)
            {
                cmdText = @"UPDATE ShoppingCart SET
                                        UserId        = ?UserId,
                                        Gid          = ?Gid,
                                        Num           = ?Num,
                                        CreateTime           = ?CreateTime
                                    WHERE
                                        Id = ?Id";
                                        //Img            = ?Img,
                                        //Nowprice            = ?Nowprice,
                                        //OriginalPrice            = ?OriginalPrice,
                                        //Title            = ?Title,
                                        //Description            = ?Description,
                parameters.Add(new MySqlParameter("?Id", shoppingcart.Id));
                parameters.Add(new MySqlParameter("?UserId", shoppingcart.UserId));
                parameters.Add(new MySqlParameter("?Gid", shoppingcart.Gid));
                parameters.Add(new MySqlParameter("?Num", shoppingcart.Num));
                //parameters.Add(new MySqlParameter("?Img", shoppingcart.Img));
                //parameters.Add(new MySqlParameter("?Nowprice", shoppingcart.Nowprice));
                //parameters.Add(new MySqlParameter("?OriginalPrice", shoppingcart.OriginalPrice));
                //parameters.Add(new MySqlParameter("?Title", shoppingcart.Title));
                //parameters.Add(new MySqlParameter("?Description", shoppingcart.Description));
                parameters.Add(new MySqlParameter("?CreateTime", shoppingcart.CreateTime));
            }
            else
            {
                cmdText = @"insert into ShoppingCart
                                        (
                                        UserId      ,
                                        Gid        ,
                                        Num         ,
                                        CreateTime        
                                        ) 
                                        values
                                        (
                                        ?UserId      ,
                                        ?Gid        ,
                                        ?Num         ,
                                        ?CreateTime           
                                        )";
                                        //Img          ,
                                        //NowPrice         ,
                                        //OriginalPrice         ,
                                        //Title         ,
                                        //Description         ,
                                        //?Img          ,
                                        //?NowPrice         ,
                                        //?OriginalPrice         ,
                                        //?Title         ,
                                        //?Description         ,
                parameters.Add(new MySqlParameter("?UserId", shoppingcart.UserId));
                parameters.Add(new MySqlParameter("?Gid", shoppingcart.Gid));
                parameters.Add(new MySqlParameter("?Num", shoppingcart.Num));
                //parameters.Add(new MySqlParameter("?Img", shoppingcart.Img));
                //parameters.Add(new MySqlParameter("?Nowprice", shoppingcart.Nowprice));
                //parameters.Add(new MySqlParameter("?Title", shoppingcart.Title));
                //parameters.Add(new MySqlParameter("?OriginalPrice", shoppingcart.OriginalPrice));
                //parameters.Add(new MySqlParameter("?Description", shoppingcart.Description));
                parameters.Add(new MySqlParameter("?CreateTime", shoppingcart.CreateTime));
            }
            try
            {
                var num = MySqlHelper.ExecuteNonQuery(Utility._gameDbConn, CommandType.Text, cmdText, parameters.ToArray());
                return num > 0;
            }
            catch (Exception ex)
            {
                throw;
            }
            return false;
        }

        /// <summary>
        /// 获取支付方式项
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static bool DeleteShoppingCart(int id)
        {
            var cmdText = String.Format("delete from ShoppingCart where Id={0} limit 1;", id);
            try
            {
                return MySqlHelper.ExecuteNonQuery(Utility._gameDbConn, CommandType.Text, cmdText) > 0;
            }
            catch (System.Exception ex)
            {
                throw;
            }
        }

        /// <summary>
        /// 按照产品id列表删除产品列表
        /// </summary>
        /// <param name="gids"></param>
        /// <returns></returns>
        public static bool DeleteShoppingCartByGid(string gids)
        {
            //var wheresql = Utility.GetWhereSql(gids, "Gid");
            var cmdText = string.Format("delete from ShoppingCart where Gid in({0})", gids);
            try
            {
                return MySqlHelper.ExecuteNonQuery(Utility._gameDbConn, CommandType.Text, cmdText) > 0;
            }
            catch (System.Exception ex)
            {
                throw;
            }
        }
    }
}