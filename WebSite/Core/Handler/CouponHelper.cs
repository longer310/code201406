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
                        c.GoodsIds = Utility.GetListint(reader["GoodsIds"].ToString());
                        c.Commentnum = (int)reader["Commentnum"];
                        c.Views = (int)reader["Views"];
                        c.SellerId = (int)reader["SellerId"];
                        c.DownloadTimes = (int)reader["DownloadTimes"];
                        c.UsedTimes = (int)reader["UsedTimes"];
                        c.Enabled = Convert.ToInt32(reader["Enabled"]);
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
            string limitsql = limit != 0 ? " LIMIT ?start,?limit" : string.Empty;
            if (order == "") order = " order by Expiry desc ";
            string commandText = @"select * from coupon where sellerId = ?sellerId " + order + limitsql;

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?sellerId", sellerId));
            if (limit != 0)
            {
                parameters.Add(new MySqlParameter("?start", start));
                parameters.Add(new MySqlParameter("?limit", limit));
            }


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
                        c.GoodsIds = Utility.GetListint(reader["GoodsIds"].ToString());
                        c.Commentnum = (int)reader["Commentnum"];
                        c.Views = (int)reader["Views"];
                        c.SellerId = (int)reader["SellerId"];
                        c.DownloadTimes = (int)reader["DownloadTimes"];
                        c.UsedTimes = (int)reader["UsedTimes"];
                        c.Enabled = Convert.ToInt32(reader["Enabled"]);
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

        public static PagResults<Coupon> GetPagings(int sellerId, int type, int start, int limit, string order = "")
        {
            var results = new PagResults<Coupon>();
            results.Results = new List<Coupon>();
            string limitsql = limit != 0 ? " LIMIT ?start,?limit" : string.Empty;
            if (order == "") order = " order by Expiry desc ";
            string typewhere = type != 0 ? string.Format(" and enabled={0}", type) : "";
            string commandText = @"select * from coupon where sellerId = ?sellerId " + typewhere + order + limitsql;

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
                        c.GoodsIds = Utility.GetListint(reader["GoodsIds"].ToString());
                        c.Commentnum = (int)reader["Commentnum"];
                        c.Views = (int)reader["Views"];
                        c.SellerId = (int)reader["SellerId"];
                        c.DownloadTimes = (int)reader["DownloadTimes"];
                        c.UsedTimes = (int)reader["UsedTimes"];
                        c.Enabled = Convert.ToInt32(reader["Enabled"]);
                        results.Results.Add(c);
                    }

                    //一个函数有两次连接数据库 先把连接断开 然后重连
                    conn.Close();
                    conn.Dispose();
                    conn.Open();

                    commandText = "select count(*) from coupon where sellerId = ?sellerId" + typewhere + order;
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
        /// 用户领取的优惠券列表
        /// </summary>
        /// <param name="start"></param>
        /// <param name="limit"></param>
        /// <param name="wheresql"></param>
        /// <param name="ordersql"></param>
        /// <returns></returns>
        public static IList<UserCoupon> GetUserCouponListForApi(int sellerId, int userId)
        {
            var results = new List<UserCoupon>();
            string commandText = @"select * from usercoupon where sellerId = ?sellerId and userId = ?userId";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?sellerId", sellerId));
            parameters.Add(new MySqlParameter("?userId", userId));

            try
            {
                using (var conn = new MySqlConnection(GlobalConfig.DbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, commandText, parameters.ToArray());
                    while (reader.Read())
                    {
                        UserCoupon item = new UserCoupon();
                        item.Id = reader.GetInt32(0);
                        item.UserId = (int)reader["UserId"];
                        item.CouponId = (int)reader["CouponId"];
                        item.SellerId = (int)reader["SellerId"];
                        item.CreateTime = (DateTime)reader["CreateTime"];
                        item.Status = (int)reader["Status"];
                        results.Add(item);
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
                                        SellerId = ?SellerId,
                                        ImgId = ?ImgId,
                                        ImgUrl = ?ImgUrl,
                                        Title = ?Title,
                                        Description = ?Description,
                                        Expiry = ?Expiry,
                                        Extcredit = ?Extcredit,
                                        FullMoney = ?FullMoney,
                                        DiscountMoney = ?DiscountMoney,
                                        GoodsIds = ?GoodsIds,
                                        Commentnum = ?Commentnum,
                                        Views = ?Views,
                                        DownloadTimes = ?DownloadTimes,
                                        UsedTimes = ?UsedTimes,
                                        Enabled = ?Enabled

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
            parameters.Add(new MySqlParameter("?GoodsIds", Utility.GetString(coupon.GoodsIds.ToList())));
            parameters.Add(new MySqlParameter("?Commentnum", coupon.Commentnum));
            parameters.Add(new MySqlParameter("?Views", coupon.Views));
            parameters.Add(new MySqlParameter("?DownloadTimes", coupon.DownloadTimes));
            parameters.Add(new MySqlParameter("?UsedTimes", coupon.UsedTimes));
            parameters.Add(new MySqlParameter("?Enabled", coupon.Enabled));
            parameters.Add(new MySqlParameter("?SellerId", coupon.SellerId));


            MySqlHelper.ExecuteNonQuery(GlobalConfig.DbConn, CommandType.Text, commandText, parameters.ToArray());

            //throw new NotImplementedException();
        }

        static IList<int> GetGoodsIds(string goodsIds)
        {
            var results = new List<int>();
            if (goodsIds == string.Empty)
            {
                return results;
            }
            string[] ids = goodsIds.Split(',');

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
                                                Status,
                                                SellerId
            	                                )
            	                                VALUES
            	                                ( 
            	                                ?UserId, 
            	                                ?CouponId, 
            	                                ?CreateTime,
            	                                ?Status,
            	                                ?SellerId
            	                                )";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?UserId", userCoupon.UserId));
            parameters.Add(new MySqlParameter("?CouponId", userCoupon.CouponId));
            parameters.Add(new MySqlParameter("?CreateTime", DateTime.Now));
            parameters.Add(new MySqlParameter("?SellerId", userCoupon.SellerId));
            parameters.Add(new MySqlParameter("?Status", userCoupon.Status));//刚领取 未使用

            MySqlHelper.ExecuteNonQuery(connectionString, CommandType.Text, commandText, parameters.ToArray());
        }

        internal static void CreateCoupon(Coupon coupon)
        {
            string connectionString = GlobalConfig.DbConn;
            string commandText = @"INSERT INTO coupon 
            	                                ( 
            	                                ImgId, 
            	                                ImgUrl,
            	                                Title,
                                                Description,
            	                                Expiry, 
            	                                Extcredit,
            	                                FullMoney,
                                                DiscountMoney,
            	                                GoodsIds, 
            	                                Commentnum,
            	                                Views,
            	                                DownloadTimes,
                                                UsedTimes,
                                                Enabled,
                                                SellerId
            	                                )
            	                                VALUES
            	                                ( 
            	                                ?ImgId, 
            	                                ?ImgUrl,
            	                                Title,
                                                ?Description,
            	                                ?Expiry, 
            	                                ?Extcredit,
            	                                ?FullMoney,
                                                ?DiscountMoney,
            	                                ?GoodsIds, 
            	                                ?Commentnum,
            	                                ?Views,
            	                                ?DownloadTimes,
                                                ?UsedTimes,
                                                ?Enabled,
                                                ?SellerId
            	                                )";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?Title", coupon.Title));
            parameters.Add(new MySqlParameter("?ImgId", coupon.ImgId));
            parameters.Add(new MySqlParameter("?ImgUrl", coupon.ImgUrl));
            parameters.Add(new MySqlParameter("?Description", coupon.Description));
            parameters.Add(new MySqlParameter("?Expiry", coupon.Expiry));
            parameters.Add(new MySqlParameter("?Extcredit", coupon.Extcredit));
            parameters.Add(new MySqlParameter("?FullMoney", coupon.FullMoney));
            parameters.Add(new MySqlParameter("?DiscountMoney", coupon.FullMoney));
            parameters.Add(new MySqlParameter("?GoodsIds", Utility.GetString(coupon.GoodsIds.ToList())));
            parameters.Add(new MySqlParameter("?Commentnum", coupon.Commentnum));
            parameters.Add(new MySqlParameter("?Views", coupon.Views));
            parameters.Add(new MySqlParameter("?DownloadTimes", coupon.DownloadTimes));
            parameters.Add(new MySqlParameter("?UsedTimes", coupon.UsedTimes));
            parameters.Add(new MySqlParameter("?Enabled", coupon.Enabled));
            parameters.Add(new MySqlParameter("?SellerId", coupon.SellerId));

            MySqlHelper.ExecuteNonQuery(connectionString, CommandType.Text, commandText, parameters.ToArray());
        }

        internal static UserCoupon GetUserCoupon(int userId, int couponId)
        {
            var item = new UserCoupon();
            string commandText = @"select * from usercoupon where userId = ?userId and couponId = ?couponId;";
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
                        item.SellerId = (int)reader["SellerId"];
                        item.CreateTime = (DateTime)reader["CreateTime"];
                        item.Status = (int)reader["Status"];
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
        /// <param name="status"></param>
        /// <param name="ifgetcount"></param>
        /// <returns></returns>
        public static PagResults<Coupon> GetUserCouponList(int userId, int sellerId, int start, int limit, int status = 0, int ifgetcount = 0)
        {
            var results = new PagResults<Coupon>();
            results.Results = new List<Coupon>();
            string limitsql = limit != 0 ? " LIMIT ?start,?limit" : string.Empty;
            string commandText = @"select a.*,b.Status as Status from coupon a left join usercoupon b on a.id=b.CouponId where b.userId = ?userId and a.SellerId=?sellerId and find_in_set(`Status`,?status) order by Expiry desc " + limitsql;

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?userId", userId));
            parameters.Add(new MySqlParameter("?sellerId", sellerId));
            if (limit != 0)
            {
                parameters.Add(new MySqlParameter("?start", start));
                parameters.Add(new MySqlParameter("?limit", limit));
            }

            parameters.Add(new MySqlParameter("?status", status > 1 ? "0,1" : status.ToString()));

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
                        c.GoodsIds = Utility.GetListint(reader["GoodsIds"].ToString());
                        c.Commentnum = (int)reader["Commentnum"];
                        c.Views = (int)reader["Views"];
                        c.SellerId = (int)reader["SellerId"];
                        c.Status = Convert.ToInt32(reader["Status"]);
                        c.Enabled = Convert.ToInt32(reader["Enabled"]);
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

        /// <summary>
        /// 获取订单可用的优惠券列表
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="sellerId"></param>
        /// <param name="gids"></param>
        /// <returns></returns>
        public static PagResults<Coupon> GetOrderCouponList(int userId, int sellerId)//, string gids
        {
            var results = new PagResults<Coupon>();
            results.Results = new List<Coupon>();
            string commandText = @"select a.*,b.Id as userCouponId from coupon a left join usercoupon b on a.id=b.CouponId where b.userId = ?userId and a.SellerId=?sellerId and b.Status = 0  order by Expiry desc ";//and a.GoodsIds not LIKE ?gids

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?userId", userId));
            parameters.Add(new MySqlParameter("?sellerId", sellerId));
            //parameters.Add(new MySqlParameter("?gids", gids + "%"));

            try
            {
                using (var conn = new MySqlConnection(GlobalConfig.DbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, commandText, parameters.ToArray());
                    while (reader.Read())
                    {
                        Coupon c = new Coupon();
                        c.Id = Convert.ToInt32(reader["userCouponId"]);
                        c.ImgId = (int)reader["ImgId"];
                        c.ImgUrl = reader["ImgUrl"].ToString();
                        c.Title = reader["Title"].ToString();
                        c.Description = reader["Description"].ToString();
                        c.Expiry = (DateTime)reader["Expiry"];
                        c.Extcredit = (int)reader["Extcredit"];
                        c.FullMoney = (int)reader["FullMoney"];
                        c.DiscountMoney = (int)reader["DiscountMoney"];
                        c.GoodsIds = Utility.GetListint(reader["GoodsIds"].ToString());
                        c.Commentnum = (int)reader["Commentnum"];
                        c.Views = (int)reader["Views"];
                        c.SellerId = (int)reader["SellerId"];
                        c.Enabled = (int)reader["Enabled"];
                        results.Results.Add(c);
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
        /// 根据玩家获取优惠券
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="sellerId"></param>
        /// <param name="couponId"></param>
        /// <returns></returns>
        public static Coupon GetCoupon(int couponId, int userId, int sellerId)
        {
            string commandText = @"select a.* from coupon a left join usercoupon b on a.id=b.CouponId where b.userId = ?userId and a.SellerId=?sellerId and b.Status = 0 and b.id=?id;";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?userId", userId));
            parameters.Add(new MySqlParameter("?sellerId", sellerId));
            parameters.Add(new MySqlParameter("?id", couponId));

            Coupon c = null;
            try
            {
                using (var conn = new MySqlConnection(GlobalConfig.DbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, commandText, parameters.ToArray());
                    while (reader.Read())
                    {
                        c = new Coupon();
                        c.Id = reader.GetInt32(0);
                        c.ImgId = (int)reader["ImgId"];
                        c.ImgUrl = reader["ImgUrl"].ToString();
                        c.Title = reader["Title"].ToString();
                        c.Description = reader["Description"].ToString();
                        c.Expiry = (DateTime)reader["Expiry"];
                        c.Extcredit = (int)reader["Extcredit"];
                        c.FullMoney = (int)reader["FullMoney"];
                        c.DiscountMoney = (int)reader["DiscountMoney"];
                        c.GoodsIds = Utility.GetListint(reader["GoodsIds"].ToString());
                        c.Commentnum = (int)reader["Commentnum"];
                        c.Views = (int)reader["Views"];
                        c.SellerId = (int)reader["SellerId"];
                        c.Enabled = (int)reader["Enabled"];
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
        /// 根据玩家获取优惠券
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="sellerId"></param>
        /// <param name="couponId"></param>
        /// <returns></returns>
        public static Coupon GetCouponIngronStatus(int couponId, int userId, int sellerId)
        {
            string commandText = @"select a.* from coupon a left join usercoupon b on a.id=b.CouponId where b.userId = ?userId and a.SellerId=?sellerId and b.id=?id;";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?userId", userId));
            parameters.Add(new MySqlParameter("?sellerId", sellerId));
            parameters.Add(new MySqlParameter("?id", couponId));

            Coupon c = null;
            try
            {
                using (var conn = new MySqlConnection(GlobalConfig.DbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, commandText, parameters.ToArray());
                    while (reader.Read())
                    {
                        c = new Coupon();
                        c.Id = reader.GetInt32(0);
                        c.ImgId = (int)reader["ImgId"];
                        c.ImgUrl = reader["ImgUrl"].ToString();
                        c.Title = reader["Title"].ToString();
                        c.Description = reader["Description"].ToString();
                        c.Expiry = (DateTime)reader["Expiry"];
                        c.Extcredit = (int)reader["Extcredit"];
                        c.FullMoney = (int)reader["FullMoney"];
                        c.DiscountMoney = (int)reader["DiscountMoney"];
                        c.GoodsIds = Utility.GetListint(reader["GoodsIds"].ToString());
                        c.Commentnum = (int)reader["Commentnum"];
                        c.Views = (int)reader["Views"];
                        c.SellerId = (int)reader["SellerId"];
                    }
                }
            }
            catch (System.Exception ex)
            {
                throw;
            }
            return c;
        }


        public static bool UpdateUserCouponStatus(int id, int status)
        {
            if (id == 0) return false;
            string commandText = @"UPDATE usercoupon SET
                                        Status = ?Status
                                    WHERE
                                        Id = ?Id";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?Status", status));
            parameters.Add(new MySqlParameter("?Id", id));

            return
                MySqlHelper.ExecuteNonQuery(GlobalConfig.DbConn, CommandType.Text, commandText, parameters.ToArray()) >
                0;
        }

        internal static void Delete(int id)
        {
            string commandText = @"delete from coupon where id=?id";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?id", id));
            MySqlHelper.ExecuteNonQuery(GlobalConfig.DbConn, CommandType.Text, commandText, parameters.ToArray());
        }

        /// <summary>
        /// 获取用户未领取的优惠券
        /// </summary>
        /// <param name="sellerId"></param>
        /// <param name="ids"></param>
        /// <param name="p"></param>
        /// <param name="size"></param>
        /// <returns></returns>
        internal static PagResults<Coupon> GetPagingUnGetCoupon(int userId, int sellerId, int index, int size)
        {
            var results = new PagResults<Coupon>();
            results.Results = new List<Coupon>();
            string limitsql = size == 0 ? " limit ?index,?size" : string.Empty;
            string commandText = @"select * from coupon where id not in (select couponid from usercoupon where sellerId = ?sellerId and userId = ?userId) and sellerId=?sellerId and Enabled=1 order by Expiry desc" + limitsql;//and a.GoodsIds not LIKE ?gids

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?userId", userId));
            parameters.Add(new MySqlParameter("?sellerId", sellerId));
            if (size == 0)
            {
                parameters.Add(new MySqlParameter("?index", index));
                parameters.Add(new MySqlParameter("?size", size));
            }

            //parameters.Add(new MySqlParameter("?gids", gids + "%"));

            try
            {
                using (var conn = new MySqlConnection(GlobalConfig.DbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, commandText, parameters.ToArray());
                    while (reader.Read())
                    {
                        var c = new Coupon();
                        c.Id = reader.GetInt32(0);
                        c.ImgId = (int)reader["ImgId"];
                        c.ImgUrl = reader["ImgUrl"].ToString();
                        c.Title = reader["Title"].ToString();
                        c.Description = reader["Description"].ToString();
                        c.Expiry = (DateTime)reader["Expiry"];
                        c.Extcredit = (int)reader["Extcredit"];
                        c.FullMoney = (int)reader["FullMoney"];
                        c.DiscountMoney = (int)reader["DiscountMoney"];
                        c.GoodsIds = Utility.GetListint(reader["GoodsIds"].ToString());
                        c.Commentnum = (int)reader["Commentnum"];
                        c.Views = (int)reader["Views"];
                        c.SellerId = (int)reader["SellerId"];
                        c.Enabled = (int)reader["Enabled"];
                        results.Results.Add(c);
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