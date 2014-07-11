using Backstage.Core.Entity;
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
                        c.Description = reader["Summary"].ToString();
                        c.Dxpiry = (DateTime)reader["Dxpiry"];
                        c.Extcredit = (int)reader["Extcredit"];
                        c.FullMoney = (int)reader["FullMoney"];
                        c.DiscountMoney = (int)reader["DiscountMoney"];
                        c.GoodsIds = GetGoodsIds(reader["GoodsIds"].ToString());
                    }
                }
            }
            catch (System.Exception ex)
            {
                throw;
            }
            return c;
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

        /// <summary>
        /// 
        /// </summary>
        /// <param name="sellId"></param>
        /// <param name="type"></param>
        /// <param name="index"></param>
        /// <param name="size"></param>
        /// <param name="order">排序sql</param>
        /// <returns></returns>
        public static PagResults<Coupon> GetPagings(int sellerId, int index, int size, string order = "")
        {
            var results = new PagResults<Coupon>();
            results.Results = new List<Coupon>();
            string commandText = @"select * from coupon where sellerId = ?sellerId LIMIT ?index,?size " + order;

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?sellerId", sellerId));
            parameters.Add(new MySqlParameter("?index", index));
            parameters.Add(new MySqlParameter("?size", size));

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
                        c.Description = reader["Summary"].ToString();
                        c.Dxpiry = (DateTime)reader["Dxpiry"];
                        c.Extcredit = (int)reader["Extcredit"];
                        c.FullMoney = (int)reader["FullMoney"];
                        c.DiscountMoney = (int)reader["DiscountMoney"];
                        c.GoodsIds = GetGoodsIds(reader["GoodsIds"].ToString());
                        results.Results.Add(c);
                    }

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
                        c.Description = reader["Summary"].ToString();
                        c.Dxpiry = (DateTime)reader["Dxpiry"];
                        c.Extcredit = (int)reader["Extcredit"];
                        c.FullMoney = (int)reader["FullMoney"];
                        c.DiscountMoney = (int)reader["DiscountMoney"];
                        c.GoodsIds = GetGoodsIds(reader["GoodsIds"].ToString());
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



        internal static void Update(Active active)
        {
            //throw new NotImplementedException();
        }
    }
}