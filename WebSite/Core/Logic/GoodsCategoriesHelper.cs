using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using Backstage.Core.Entity;
using Backstage.Model;
using MySql.Data.MySqlClient;

namespace Backstage.Core.Logic
{
    public static class GoodsCategoriesHelper
    {
        /// <summary>
        /// 获取分类列表
        /// </summary>
        /// <param name="sellerId"></param>
        /// <param name="totalnum"></param>
        /// <param name="wheresql"></param>
        /// <param name="ordersql"></param>
        /// <param name="start"></param>
        /// <param name="limit"></param>
        /// <returns></returns>
        public static PagResults<GoodsCategories> GetList(int sellerId, string wheresql = "",
            string ordersql = "", int start = 0, int limit = 0, int isgettotal = 0)
        {
            var result = new PagResults<GoodsCategories>();
            result.Results = new List<GoodsCategories>();
            if (ordersql == "") ordersql = " order by `Index` ";
            string limitsql = limit != 0 ? " LIMIT ?start,?limit" : string.Empty;
            var cmdText = @"select * from GoodsCategories where SellerId=?SellerId " + wheresql + ordersql + limitsql;

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            if (!string.IsNullOrEmpty(limitsql))
            {
                parameters.Add(new MySqlParameter("?start", start));
                parameters.Add(new MySqlParameter("?limit", limit));
            }
            parameters.Add(new MySqlParameter("?SellerId", sellerId));
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText,
                        parameters.ToArray());
                    while (reader.Read())
                    {
                        GoodsCategories goodsCategories = new GoodsCategories();
                        goodsCategories.Id = reader.GetInt32(0);
                        goodsCategories.Index = (int)reader["Index"];
                        goodsCategories.Name = reader["Name"].ToString();
                        goodsCategories.SellerId = (int)reader["SellerId"];

                        result.Results.Add(goodsCategories);
                    }

                    if (isgettotal > 0)
                    {
                        //一个函数有两次连接数据库 先把连接断开 然后重连
                        conn.Close();
                        conn.Dispose();
                        conn.Open();

                        cmdText = @"select count(*) from GoodsCategories where SellerId=?SellerId " + wheresql;
                        parameters = new List<MySqlParameter>();
                        parameters.Add(new MySqlParameter("?SellerId", sellerId));
                        reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText,
                            parameters.ToArray());
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
        /// <summary>
        /// 获取分类项
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static GoodsCategories GetGoodsCategories(int id)
        {
            var cmdText = string.Format("select * from GoodsCategories where Id={0} limit 1;", id);
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText);
                    if (reader.HasRows)
                    {
                        if (reader.Read())
                        {
                            GoodsCategories goodsCategories = new GoodsCategories();
                            goodsCategories.Id = reader.GetInt32(0);
                            goodsCategories.Name = reader["Name"].ToString();
                            return goodsCategories;
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
        /// 保存分类
        /// </summary>
        /// <param name="goodsCategories"></param>
        /// <returns></returns>
        public static bool SaveGoodsCategories(GoodsCategories goodsCategories)
        {
            var cmdText = string.Empty;
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            if (goodsCategories.Id > 0)
            {
                cmdText = @"update GoodsCategories set 
                                                   Index=?Index,
                                                   Name =?Name,
                                                   where 
                                                   Id=?Id";
                parameters.Add(new MySqlParameter("?Id", goodsCategories.Id));
                parameters.Add(new MySqlParameter("?Index", goodsCategories.Index));
                parameters.Add(new MySqlParameter("?Name", goodsCategories.Name));
            }
            else
            {
                cmdText = @"insert into GoodsCategories
                                                   (
                                                   Index,
                                                   Name,
                                                   SellerId
                                                   ) 
                                                   values 
                                                   (
                                                   ?Index,
                                                   ?Name,
                                                   ?SellerId
                                                   )";
                parameters.Add(new MySqlParameter("?Index", goodsCategories.Index));
                parameters.Add(new MySqlParameter("?Name", goodsCategories.Name));
                parameters.Add(new MySqlParameter("?SellerId", goodsCategories.SellerId));
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


        /// <summary>
        /// 删除分类
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static bool DeleteGoodsCategories(int id)
        {
            var cmdText = String.Format("delete from GoodsCategories where Id={0} limit 1;", id);
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