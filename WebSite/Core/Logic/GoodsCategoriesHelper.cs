using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using Backstage.Core.Entity;
using Backstage.Handler;
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
                        goodsCategories.Count = (int)reader["Count"];
                        goodsCategories.ImageUrl = reader["ImageUrl"].ToString();
                        goodsCategories.Color = reader["Color"].ToString();

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
                            goodsCategories.SellerId = (int)reader["SellerId"];
                            goodsCategories.Count = (int)reader["Count"];
                            goodsCategories.ImageUrl = reader["ImageUrl"].ToString();
                            goodsCategories.Color = reader["Color"].ToString();
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
        /// 获取分类最大排序
        /// </summary>
        /// <param name="sellerId"></param>
        /// <returns></returns>
        public static int GetMaxIndex(int sellerId)
        {
            int index = 0;
            var cmdText = string.Format("select max(`index`) from GoodsCategories where sellerId={0}", sellerId);
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText);
                    if (reader.HasRows)
                    {
                        if (reader.Read())
                        {
                            index = reader.GetInt32(0);
                        }
                    }
                }
            }
            catch (System.Exception ex)
            {
                throw;
            }
            return index;
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
                                                   Name =?Name ,
                                                   Count =?Count ,
                                                   ImageUrl =?ImageUrl ,
                                                   Color =?Color
                                                   where 
                                                   Id=?Id";
                parameters.Add(new MySqlParameter("?Id", goodsCategories.Id));
                parameters.Add(new MySqlParameter("?Index", goodsCategories.Index));
                parameters.Add(new MySqlParameter("?Name", goodsCategories.Name));
                parameters.Add(new MySqlParameter("?Count", goodsCategories.Count));
                parameters.Add(new MySqlParameter("?ImageUrl", goodsCategories.ImageUrl));
                parameters.Add(new MySqlParameter("?Color", goodsCategories.Color));
            }
            else
            {
                cmdText = @"insert into GoodsCategories
                                                   (
                                                   `Index`,
                                                   Name,
                                                   SellerId,
                                                   Count,
                                                   ImageUrl
                                                   ) 
                                                   values 
                                                   (
                                                   ?Index,
                                                   ?Name,
                                                   ?SellerId,
                                                   ?Count,
                                                   ?ImageUrl
                                                   )";
                parameters.Add(new MySqlParameter("?Index", goodsCategories.Index));
                parameters.Add(new MySqlParameter("?Name", goodsCategories.Name));
                parameters.Add(new MySqlParameter("?SellerId", goodsCategories.SellerId));
                parameters.Add(new MySqlParameter("?Count", goodsCategories.Count));
                parameters.Add(new MySqlParameter("?ImageUrl", goodsCategories.ImageUrl));
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
        /// 保存分类列表——事物处理
        /// </summary>
        /// <param name="goodsCategoriesList"></param>
        /// <returns></returns>
        public static bool SaveGoodsCategoriesList(List<GoodsCategories> goodsCategoriesList)
        {
            var cmdText = string.Empty;
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            cmdText = "begin;";
            foreach (var goodsCategories in goodsCategoriesList)
            {
                var tempcmdText = @"UPDATE goodscategories SET
                                        `Index`        = ?Index,
                                        ImageUrl          = ?ImageUrl,
                                        Name            = ?Name,
                                        Color            = ?Color
                                    WHERE
                                        Id = ?Id;";
                string newStr = string.Format("?{0}", goodsCategories.Id);
                tempcmdText = tempcmdText.Replace("?", newStr);
                cmdText += tempcmdText;
                parameters.Add(new MySqlParameter(newStr + "Id", goodsCategories.Id));
                parameters.Add(new MySqlParameter(newStr + "Index", goodsCategories.Index));
                parameters.Add(new MySqlParameter(newStr + "ImageUrl", goodsCategories.ImageUrl));
                parameters.Add(new MySqlParameter(newStr + "Name", goodsCategories.Name));
                parameters.Add(new MySqlParameter(newStr + "Color", goodsCategories.Color));
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

        /// <summary>
        /// 更改分类产品个数——事物处理
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        public static bool UpdateGoodsCategoriesCount(List<GoodsHandler.ChangeCountItem> data)
        {
            var cmdText = string.Empty;
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            cmdText = "begin;";
            foreach (var changeitem in data)
            {
                var tempcmdText = @"UPDATE goodscategories SET
                                        `Count`        = `Count` + (?Count)
                                    WHERE
                                        Id = ?Id;";
                string newStr = string.Format("?{0}", changeitem.Id);
                tempcmdText = tempcmdText.Replace("?", newStr);
                cmdText += tempcmdText;
                parameters.Add(new MySqlParameter(newStr + "Id", changeitem.Id));
                parameters.Add(new MySqlParameter(newStr + "Count", changeitem.Change));
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

        /// <summary>
        /// 删除分类列表
        /// </summary>
        /// <param name="sellerId"></param>
        /// <param name="ids"></param>
        /// <returns></returns>
        public static bool DeleteGoodsCategoriesList(int sellerId, string ids)
        {
            var cmdText = @"delete from GoodsCategories where SellerId=?SellerId and Id in (?Id)";
            var parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?SellerId", sellerId));
            parameters.Add(new MySqlParameter("?Id", ids));
            try
            {
                return
                    MySqlHelper.ExecuteNonQuery(Utility._gameDbConn, CommandType.Text, cmdText, parameters.ToArray()) >
                    0;
            }
            catch (System.Exception ex)
            {
                throw;
            }
        }
    }
}