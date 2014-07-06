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
        public static List<GoodsCategories> GetList(int sellerId, out int totalnum, string wheresql = "", string ordersql = "", int start = 0, int limit = 0)
        {
            totalnum = 0;
            List<GoodsCategories> list = new List<GoodsCategories>();
            var sql = String.Format("select * from GoodsCategories where SellerId={0} and ", sellerId);
            if (wheresql != "") sql += " " + wheresql;
            if (ordersql != "") sql += " " + ordersql;
            else sql += " order by Index";
            if (limit != 0) sql += String.Format(" limit {0},{1};", start, limit);
            try
            {
                MySqlDataReader reader = MySqlHelper.ExecuteReader(Utility._gameDbConn, CommandType.Text, sql);
                var dset = MySqlHelper.ExecuteDataset(Utility._gameDbConn, CommandType.Text, sql);
                DataTable dt = dset.Tables[0];
                while (reader.Read())
                {
                    GoodsCategories goodsCategories = new GoodsCategories();
                    goodsCategories.Id = reader.GetInt32(0);
                    goodsCategories.Index = reader.GetInt32(1);
                    goodsCategories.Name = reader.GetString(2);
                    goodsCategories.SellerId = reader.GetInt32(3);

                    list.Add(goodsCategories);
                }

                sql = string.Format("select count(*) from GoodsCategories where SellerId={0} ", sellerId);
                reader = MySqlHelper.ExecuteReader(Utility._gameDbConn, CommandType.Text, sql);
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
            var sql = string.Format("select * from Favorite where Id={0} limit 1;", id);
            try
            {
                MySqlDataReader reader = MySqlHelper.ExecuteReader(Utility._gameDbConn, CommandType.Text, sql);
                if (reader.HasRows)
                {
                    if (reader.Read())
                    {
                        GoodsCategories goodsCategories = new GoodsCategories();
                        goodsCategories.Id = reader.GetInt32(0);
                        goodsCategories.Name = reader.GetString(1);
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