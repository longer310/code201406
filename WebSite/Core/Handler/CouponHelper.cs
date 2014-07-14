﻿using Backstage.Core.Entity;
using Backstage.Model;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace Backstage.Core.Handler
{
    public class CouponHelper
    {

        public static Coupon GetItem(int id)
        {
            var c = new Coupon();
            string commandText = @"select * from coupon where id = ?id";
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?id", id));
            try
            {
                using (var conn = new MySqlConnection(GlobalConfig.DbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, commandText, parameters.ToArray());
                    while (reader.Read())
                    {
                        c.Id = reader.GetInt32(0);
                        c.ImgId = (int)reader["ImgId"];
                        c.ImgUrl = reader["ImgUrl"].ToString();
                        c.Title = reader["Title"].ToString();
                        c.Description = reader["Description"].ToString();
                        c.Expiry = (DateTime)reader["Expiry"];
                        c.Extcredit = (int)reader["Extcredit"];
                        c.FullMoney = (int)reader["FullMoney"];
                        c.DiscountMoney = (int)reader["DiscountMoney"];
                        c.GoodsIds = GetGoodsIds(reader["GoodsIds"].ToString());
                        c.Commentnum = (int)reader["Commentnum"];
                    }
                }
            }
            catch (System.Exception ex)
            {
                throw;
            }
            return c;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="sellId"></param>
        /// <param name="type"></param>
        /// <param name="index"></param>
        /// <param name="size"></param>
        /// <param name="order">排序sql</param>
        /// <returns></returns>
        public static PagResults<Coupon> GetPagings(int sellerId, int start, int limit, string order = "")
        {
            var results = new PagResults<Coupon>();
            results.Results = new List<Coupon>();
            string limitsql = start != 0 ? " LIMIT ?start,?limit" : string.Empty;
            if (order == "") order = " order by Expiry desc ";
            string commandText = @"select * from coupon where sellerId = ?sellerId " + order + limitsql;

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?sellerId", sellerId));
            parameters.Add(new MySqlParameter("?start", start));
            parameters.Add(new MySqlParameter("?limit", limit));

            try
            {
                using (var conn = new MySqlConnection(GlobalConfig.DbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, commandText, parameters.ToArray());
                    while (reader.Read())
                    {
                        Coupon c = new Coupon();
                        c.Id = reader.GetInt32(0);
                        c.ImgId = (int)reader["ImgId"];
                        c.ImgUrl = reader["ImgUrl"].ToString();
                        c.Title = reader["Title"].ToString();
                        c.Description = reader["Description"].ToString();
                        c.Expiry = (DateTime)reader["Expiry"];
                        c.Extcredit = (int)reader["Extcredit"];
                        c.FullMoney = (int)reader["FullMoney"];
                        c.DiscountMoney = (int)reader["DiscountMoney"];
                        c.GoodsIds = GetGoodsIds(reader["GoodsIds"].ToString());
                        c.Commentnum = (int)reader["Commentnum"];
                        results.Results.Add(c);
                    }

                    //一个函数有两次连接数据库 先把连接断开 然后重连
                    conn.Close();
                    conn.Dispose();
                    conn.Open();

                    commandText = "select count(*) from coupon where sellerId = ?sellerId";
                    parameters.Clear();
                    parameters.Add(new MySqlParameter("?sellerId", sellerId));
                    reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, commandText, parameters.ToArray());
                    if (reader.HasRows)
                    {
                        if (reader.Read())
                        {
                            results.TotalCount = reader.GetInt32(0);
                        }
                    }
                }
            }
            catch (System.Exception ex)
            {
                throw;
            }
            return results;
        }

        /// <summary>
        /// 优惠券列表
        /// </summary>
        /// <param name="start"></param>
        /// <param name="limit"></param>
        /// <param name="wheresql"></param>
        /// <param name="ordersql"></param>
        /// <returns></returns>
        public static IList<Coupon> GetList(int start, int limit, string wheresql = "", string ordersql = "")
        {
            var results = new List<Coupon>();
            string limitsql = limit == 0 ? string.Empty : " LIMIT ?start,?limit ";
            string commandText = @"select * from coupon " + wheresql + ordersql + limitsql;

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?start", start));
            parameters.Add(new MySqlParameter("?limit", limit));

            try
            {
                using (var conn = new MySqlConnection(GlobalConfig.DbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, commandText, parameters.ToArray());
                    while (reader.Read())
                    {
                        Coupon c = new Coupon();
                        c.Id = reader.GetInt32(0);
                        c.ImgId = (int)reader["ImgId"];
                        c.ImgUrl = reader["ImgUrl"].ToString();
                        c.Title = reader["Title"].ToString();
                        c.Description = reader["Description"].ToString();
                        c.Expiry = (DateTime)reader["Expiry"];
                        c.Extcredit = (int)reader["Extcredit"];
                        c.FullMoney = (int)reader["FullMoney"];
                        c.DiscountMoney = (int)reader["DiscountMoney"];
                        c.GoodsIds = GetGoodsIds(reader["GoodsIds"].ToString());
                        c.Commentnum = (int)reader["Commentnum"];
                        results.Add(c);
                    }
                }
            }
            catch (System.Exception ex)
            {
                throw;
            }
            return results;
        }



        internal static void Update(Coupon coupon)
        {
            string commandText = @"UPDATE coupon SET
                                        ImgId = ?ImgId,
                                        ImgUrl = ?ImgUrl,
                                        Title = ?Title,
                                        Description = ?Description,
                                        Expiry = ?Expiry,
                                        Extcredit = ?Extcredit,
                                        FullMoney = ?FullMoney,
                                        DiscountMoney = ?DiscountMoney,
                                        GoodsIds = ?GoodsIds,
                                        Commentnum = ?Commentnum
                                    WHERE
                                        Id = ?Id";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?Id", coupon.Id));
            parameters.Add(new MySqlParameter("?Title", coupon.Title));
            parameters.Add(new MySqlParameter("?ImgId", coupon.ImgId));
            parameters.Add(new MySqlParameter("?ImgUrl", coupon.ImgUrl));
            parameters.Add(new MySqlParameter("?Description", coupon.Description));
            parameters.Add(new MySqlParameter("?Expiry", coupon.Expiry));
            parameters.Add(new MySqlParameter("?Extcredit", coupon.Extcredit));
            parameters.Add(new MySqlParameter("?FullMoney", coupon.FullMoney));
            parameters.Add(new MySqlParameter("?DiscountMoney", coupon.FullMoney));
            parameters.Add(new MySqlParameter("?GoodsIds", GetGoodsIdsString(coupon.GoodsIds)));

            MySqlHelper.ExecuteNonQuery(GlobalConfig.DbConn, CommandType.Text, commandText, parameters.ToArray());

            //throw new NotImplementedException();
        }

        static IList<int> GetGoodsIds(string goodsIds)
        {
            string[] ids = goodsIds.Split(',');
            var results = new List<int>();
            foreach (var id in ids)
            {
                results.Add(Convert.ToInt32(id));
            }
            return results;
        }

        static string GetGoodsIdsString(IList<int> goodsIds)
        {
            string ids = "";
            foreach (var id in goodsIds)
            {
                ids += id;
                ids += ",";
            }
            if (goodsIds != null && goodsIds.Count > 0)
            {
                ids.Substring(0, ids.Length - 1);
            }
            return ids;
        }

        internal static void CreateUserCoupon(UserCoupon userCoupon)
        {
            string connectionString = GlobalConfig.DbConn;
            string commandText = @"INSERT INTO usercoupon 
            	                                ( 
            	                                UserId, 
            	                                CouponId,
            	                                CreateTime,
            	                                )
            	                                VALUES
            	                                ( 
            	                                ?UserId, 
            	                                ?CouponId, 
            	                                ?CreateTime
            	                                )";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?UserId", userCoupon.UserId));
            parameters.Add(new MySqlParameter("?CouponId", userCoupon.CouponId));
            parameters.Add(new MySqlParameter("?CreateTime", DateTime.Now));

            MySqlHelper.ExecuteNonQuery(connectionString, CommandType.Text, commandText, parameters.ToArray());
        }

        internal static UserCoupon GetUserCoupon(int userId, int couponId)
        {
            var item = new UserCoupon();
            string commandText = @"select * from usercoupon where userId = ?userId and couponId = ?couponId";
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?userId", userId));
            parameters.Add(new MySqlParameter("?couponId", couponId));
            try
            {
                using (var conn = new MySqlConnection(GlobalConfig.DbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, commandText, parameters.ToArray());
                    while (reader.Read())
                    {
                        item.Id = reader.GetInt32(0);
                        item.UserId = (int)reader["UserId"];
                        item.CouponId = (int)reader["CouponId"];
                        item.CreateTime = (DateTime)reader["CreateTime"];
                    }
                }
            }
            catch (System.Exception ex)
            {
                throw;
            }
            return item;
        }

        /// <summary>
        /// 获取用户优惠券列表
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="sellerId"></param>
        /// <param name="start"></param>
        /// <param name="limit"></param>
        /// <param name="ifgetcount"></param>
        /// <returns></returns>
        public static PagResults<Coupon> GetUserCouponList(int userId, int sellerId, int start, int limit, int ifgetcount = 0)
        {
            var results = new PagResults<Coupon>();
            results.Results = new List<Coupon>();
            string limitsql = start != 0 ? " LIMIT ?start,?limit" : string.Empty;
            string commandText = @"select a.* from coupon a left join usercoupon b on a.id=b.CouponId where b.userId = ?userId and a.SellerId=?sellerId order by Expiry desc " + limitsql;

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?userId", userId));
            parameters.Add(new MySqlParameter("?sellerId", sellerId));
            parameters.Add(new MySqlParameter("?start", start));
            parameters.Add(new MySqlParameter("?limit", limit));

            try
            {
                using (var conn = new MySqlConnection(GlobalConfig.DbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, commandText, parameters.ToArray());
                    while (reader.Read())
                    {
                        Coupon c = new Coupon();
                        c.Id = reader.GetInt32(0);
                        c.ImgId = (int)reader["ImgId"];
                        c.ImgUrl = reader["ImgUrl"].ToString();
                        c.Title = reader["Title"].ToString();
                        c.Description = reader["Description"].ToString();
                        c.Expiry = (DateTime)reader["Expiry"];
                        c.Extcredit = (int)reader["Extcredit"];
                        c.FullMoney = (int)reader["FullMoney"];
                        c.DiscountMoney = (int)reader["DiscountMoney"];
                        c.GoodsIds = GetGoodsIds(reader["GoodsIds"].ToString());
                        c.Commentnum = (int)reader["Commentnum"];
                        results.Results.Add(c);
                    }

                    if (ifgetcount > 0)
                    {
                        //一个函数有两次连接数据库 先把连接断开 然后重连
                        conn.Close();
                        conn.Dispose();
                        conn.Open();

                        commandText = "select count(*) from coupon where sellerId = ?sellerId";
                        parameters.Clear();
                        parameters.Add(new MySqlParameter("?sellerId", sellerId));
                        reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, commandText, parameters.ToArray());
                        if (reader.HasRows)
                        {
                            if (reader.Read())
                            {
                                results.TotalCount = reader.GetInt32(0);
                            }
                        }
                    }
                }
            }
            catch (System.Exception ex)
            {
                throw;
            }
            return results;
        }

    }
}