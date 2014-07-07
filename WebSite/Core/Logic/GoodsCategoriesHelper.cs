using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using Backstage.Core.Entity;
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
        public static List<GoodsCategories> GetList(int sellerId, out int totalnum, string wheresql = "",
            string ordersql = "", int start = 0, int limit = 0)
        {
            totalnum = 0;
            List<GoodsCategories> list = new List<GoodsCategories>();
            if (ordersql == "") ordersql = " order by Index";
            string limitsql = limit != 0 ? " LIMIT ?start,?limit" : string.Empty;
            var cmdText = @"select * from GoodsCategories where SellerId=?SellerId " + wheresql + ordersql + limitsql;

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?start", start));
            parameters.Add(new MySqlParameter("?limit", limit));
            parameters.Add(new MySqlParameter("?SellerId", sellerId));
            try
            {
                MySqlDataReader reader = MySqlHelper.ExecuteReader(Utility._gameDbConn, CommandType.Text, cmdText,
                    parameters.ToArray());
                while (reader.Read())
                {
                    GoodsCategories goodsCategories = new GoodsCategories();
                    goodsCategories.Id = reader.GetInt32(0);
                    goodsCategories.Index = (int)reader["Index"];
                    goodsCategories.Name = reader["Name"].ToString();
                    goodsCategories.SellerId = (int)reader["SellerId"];

                    list.Add(goodsCategories);
                }

                cmdText = @"select count(*) from GoodsCategories where SellerId=?SellerId " + wheresql;
                parameters = new List<MySqlParameter>();
                parameters.Add(new MySqlParameter("?SellerId", sellerId));
                reader = MySqlHelper.ExecuteReader(Utility._gameDbConn, CommandType.Text, cmdText, parameters.ToArray());
                if (reader.HasRows)
                {
                    if (reader.Read())
                    {
                        totalnum = reader.GetInt32(0);
                    }
                }
            }
            catch (System.Exception ex)
            {
                throw;
            }
            return list;
        }
        /// <summary>
        /// 获取分类项
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static GoodsCategories GetGoodsCategories(int id)
        {
            var cmdText = string.Format("select * from Favorite where Id={0} limit 1;", id);
            try
            {
                MySqlDataReader reader = MySqlHelper.ExecuteReader(Utility._gameDbConn, CommandType.Text, cmdText);
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
            catch (System.Exception ex)
            {
                throw;
            }
            return null;
        }
    }
}