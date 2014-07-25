using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using Backstage.Core.Dapper;
using Backstage.Core.Entity;
using Backstage.Model;
using MySql.Data.MySqlClient;

namespace Backstage.Core.Logic
{
    public static class GoodsHelper
    {
        /// <summary>
        /// 根据条件获取产品列表
        /// </summary>
        /// <param name="sellerId"></param>
        /// <param name="wheresql"></param>
        /// <param name="ordersql"></param>
        /// <param name="start"></param>
        /// <param name="limit"></param>
        /// <param name="gettotal"></param>
        /// <returns></returns>
        public static PagResults<Goods> GetGoodsList(int sellerId, string wheresql = "",
            string ordersql = "", int start = 0, int limit = 0, int gettotal = 0)
        {
            var result = new PagResults<Goods>();
            result.Results = new List<Goods>();
            if (ordersql == "") ordersql = " order by CreateTime desc ";
            string limitsql = limit != 0 ? " LIMIT ?start,?limit" : string.Empty;
            var cmdText = @"select a.*,m.Url from Goods as a left join material m on a.Logo=m.Id where a.SellerId=?SellerId " + wheresql + ordersql + limitsql;

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
                        Goods goods = new Goods();
                        goods.Id = reader.GetInt32(0);
                        goods.SellerId = (int)reader["SellerId"];
                        goods.Logo = (int)reader["Logo"];
                        goods.ImgIdList = Utility.GetListint(reader["ImgIds"].ToString());
                        goods.Sales = (int)reader["Sales"];
                        goods.Title = reader["Title"].ToString();
                        goods.Cid = (int)reader["Cid"];
                        goods.Nowprice = (float)reader["Nowprice"];
                        goods.OriginalPrice = (float)reader["OriginalPrice"];
                        goods.Score = (float)reader["Score"];
                        goods.CreateTime = (DateTime)reader["CreateTime"];
                        goods.FavCount = (int)reader["FavCount"];
                        goods.ShareCount = (int)reader["ShareCount"];
                        goods.Tag = reader["Tag"].ToString();
                        goods.Content = reader["Content"].ToString();
                        goods.LogoUrl = reader["Url"].ToString();
                        goods.CommentCount = (int)reader["CommentCount"];
                        goods.BrowseCount = (int)reader["BrowseCount"];
                        goods.IsHot = (int)reader["IsHot"];
                        goods.IsRecommend = (int)reader["IsRecommend"];

                        result.Results.Add(goods);
                    }

                    if (gettotal > 0)
                    {
                        //一个函数有两次连接数据库 先把连接断开 然后重连
                        conn.Close();
                        conn.Dispose();
                        conn.Open();

                        cmdText = string.Format("select count(*) from goods where SellerId={0} ", sellerId) +
                                  wheresql;
                        reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText);
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
        /// 获得单个商品
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static Goods GetGoods(int id)
        {
            var sql = string.Format("select a.*,m.Url from Goods as a left join material m on a.Logo=m.Id where a.Id={0} limit 1;", id);
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, sql);
                    if (reader.HasRows)
                    {
                        if (reader.Read())
                        {
                            Goods goods = new Goods();
                            goods.Id = reader.GetInt32(0);
                            goods.SellerId = (int)reader["SellerId"];
                            goods.Logo = (int)reader["Logo"];
                            goods.ImgIdList = Utility.GetListint(reader["ImgIds"].ToString());
                            goods.Sales = (int)reader["Sales"];
                            goods.Title = reader["Title"].ToString();
                            goods.Cid = (int)reader["Cid"];
                            goods.Nowprice = (float)reader["Nowprice"];
                            goods.OriginalPrice = (float)reader["OriginalPrice"];
                            goods.Score = (float)reader["Score"];
                            goods.CreateTime = (DateTime)reader["CreateTime"];
                            goods.FavCount = (int)reader["FavCount"];
                            goods.ShareCount = (int)reader["ShareCount"];
                            goods.Tag = reader["Tag"].ToString();
                            goods.Content = reader["Content"].ToString();
                            goods.LogoUrl = reader["Url"].ToString();
                            goods.CommentCount = (int)reader["CommentCount"];
                            goods.BrowseCount = (int)reader["BrowseCount"];
                            goods.IsHot = (int)reader["IsHot"];
                            goods.IsRecommend = (int)reader["IsRecommend"];
                            return goods;
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
        /// <param name="goods"></param>
        /// <returns></returns>
        public static bool SaveGoods(Goods goods)
        {
            var cmdText = string.Empty;
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            if (goods.Id > 0)
            {
                cmdText = @"UPDATE Goods SET
                                        SellerId        = ?SellerId,
                                        ImgIds          = ?ImgIds,
                                        Logo            = ?Logo,
                                        Sales           = ?Sales,
                                        Title           = ?Title,
                                        Cid             = ?Cid,
                                        Nowprice        = ?Nowprice,
                                        OriginalPrice   = ?OriginalPrice,
                                        Score           = ?Score,
                                        CreateTime      = ?CreateTime,
                                        FavCount        = ?FavCount,
                                        ShareCount      = ?ShareCount,
                                        Tag             = ?Tag,
                                        Content         = ?Content,
                                        CommentCount         = ?CommentCount,
                                        BrowseCount         = ?BrowseCount,
                                        IsRecommend         = ?IsRecommend,
                                        IsHot           = ?IsHot
                                    WHERE
                                        Id = ?Id";
                parameters.Add(new MySqlParameter("?Id", goods.Id));
                parameters.Add(new MySqlParameter("?SellerId", goods.SellerId));
                parameters.Add(new MySqlParameter("?ImgIds", Utility.GetString(goods.ImgIdList)));
                parameters.Add(new MySqlParameter("?Logo", goods.Logo));
                parameters.Add(new MySqlParameter("?Sales", goods.Sales));
                parameters.Add(new MySqlParameter("?Title", goods.Title));
                parameters.Add(new MySqlParameter("?Cid", goods.Cid));
                parameters.Add(new MySqlParameter("?Nowprice", goods.Nowprice));
                parameters.Add(new MySqlParameter("?OriginalPrice", goods.OriginalPrice));
                parameters.Add(new MySqlParameter("?Score", goods.Score));
                parameters.Add(new MySqlParameter("?CreateTime", goods.CreateTime));
                parameters.Add(new MySqlParameter("?FavCount", goods.FavCount));
                parameters.Add(new MySqlParameter("?ShareCount", goods.ShareCount));
                parameters.Add(new MySqlParameter("?Tag", goods.Tag));
                parameters.Add(new MySqlParameter("?Content", goods.Content));
                parameters.Add(new MySqlParameter("?IsRecommend", goods.IsRecommend));
                parameters.Add(new MySqlParameter("?IsHot", goods.IsHot));
                parameters.Add(new MySqlParameter("?CommentCount", goods.CommentCount));
                parameters.Add(new MySqlParameter("?BrowseCount", goods.BrowseCount));
            }
            else
            {
                cmdText = @"insert into Goods
                                        (
                                        SellerId      ,
                                        ImgIds        ,
                                        Logo          ,
                                        Sales         ,
                                        Title         ,
                                        Cid           ,
                                        Nowprice      ,
                                        OriginalPrice ,
                                        Score         ,
                                        CreateTime    ,
                                        FavCount      ,
                                        ShareCount    ,
                                        Tag           ,
                                        Content       ,
                                        CommentCount       ,
                                        BrowseCount       ,
                                        IsRecommend       ,
                                        IsHot         
                                        ) 
                                        values
                                        (
                                        ?SellerId      ,
                                        ?ImgIds        ,
                                        ?Logo          ,
                                        ?Sales         ,
                                        ?Title         ,
                                        ?Cid           ,
                                        ?Nowprice      ,
                                        ?OriginalPrice ,
                                        ?Score         ,
                                        ?CreateTime    ,
                                        ?FavCount      ,
                                        ?ShareCount    ,
                                        ?Tag           ,
                                        ?Content       ,
                                        ?CommentCount       ,
                                        ?BrowseCount       ,
                                        ?IsRecommend       ,
                                        ?IsHot         
                                        )";
                parameters.Add(new MySqlParameter("?SellerId", goods.SellerId));
                parameters.Add(new MySqlParameter("?ImgIds", Utility.GetString(goods.ImgIdList)));
                parameters.Add(new MySqlParameter("?Logo", goods.Logo));
                parameters.Add(new MySqlParameter("?Sales", goods.Sales));
                parameters.Add(new MySqlParameter("?Title", goods.Title));
                parameters.Add(new MySqlParameter("?Cid", goods.Cid));
                parameters.Add(new MySqlParameter("?Nowprice", goods.Nowprice));
                parameters.Add(new MySqlParameter("?OriginalPrice", goods.OriginalPrice));
                parameters.Add(new MySqlParameter("?Score", goods.Score));
                parameters.Add(new MySqlParameter("?CreateTime", goods.CreateTime));
                parameters.Add(new MySqlParameter("?FavCount", goods.FavCount));
                parameters.Add(new MySqlParameter("?ShareCount", goods.ShareCount));
                parameters.Add(new MySqlParameter("?Tag", goods.Tag));
                parameters.Add(new MySqlParameter("?Content", goods.Content));
                parameters.Add(new MySqlParameter("?IsHot", goods.IsHot));
                parameters.Add(new MySqlParameter("?IsRecommend", goods.IsRecommend));
                parameters.Add(new MySqlParameter("?CommentCount", goods.CommentCount));
                parameters.Add(new MySqlParameter("?BrowseCount", goods.BrowseCount));
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
        /// 保存商品 如果id为0 则添加新纪录
        /// </summary>
        /// <param name="goods"></param>
        /// <returns></returns>
        public static bool SaveGoodsList(List<Goods> goodsList)
        {
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            var cmdText = "begin;";
            foreach (var goods in goodsList)
            {
                var tempcmdText = @"UPDATE Goods SET
                                        SellerId        = ?SellerId,
                                        ImgIds          = ?ImgIds,
                                        Logo            = ?Logo,
                                        Sales           = ?Sales,
                                        Title           = ?Title,
                                        Cid             = ?Cid,
                                        Nowprice        = ?Nowprice,
                                        OriginalPrice   = ?OriginalPrice,
                                        Score           = ?Score,
                                        CreateTime      = ?CreateTime,
                                        FavCount        = ?FavCount,
                                        ShareCount      = ?ShareCount,
                                        Tag             = ?Tag,
                                        Content         = ?Content,
                                        CommentCount         = ?CommentCount,
                                        BrowseCount         = ?BrowseCount,
                                        IsRecommend         = ?IsRecommend,
                                        IsHot           = ?IsHot
                                    WHERE
                                        Id = ?Id;";
                string newStr = string.Format("?{0}", goods.Id);
                tempcmdText = tempcmdText.Replace("?", newStr);
                cmdText += tempcmdText;
                parameters.Add(new MySqlParameter(newStr + "Id", goods.Id));
                parameters.Add(new MySqlParameter(newStr + "SellerId", goods.SellerId));
                parameters.Add(new MySqlParameter(newStr + "ImgIds", Utility.GetString(goods.ImgIdList)));
                parameters.Add(new MySqlParameter(newStr + "Logo", goods.Logo));
                parameters.Add(new MySqlParameter(newStr + "Sales", goods.Sales));
                parameters.Add(new MySqlParameter(newStr + "Title", goods.Title));
                parameters.Add(new MySqlParameter(newStr + "Cid", goods.Cid));
                parameters.Add(new MySqlParameter(newStr + "Nowprice", goods.Nowprice));
                parameters.Add(new MySqlParameter(newStr + "OriginalPrice", goods.OriginalPrice));
                parameters.Add(new MySqlParameter(newStr + "Score", goods.Score));
                parameters.Add(new MySqlParameter(newStr + "CreateTime", goods.CreateTime));
                parameters.Add(new MySqlParameter(newStr + "FavCount", goods.FavCount));
                parameters.Add(new MySqlParameter(newStr + "ShareCount", goods.ShareCount));
                parameters.Add(new MySqlParameter(newStr + "Tag", goods.Tag));
                parameters.Add(new MySqlParameter(newStr + "Content", goods.Content));
                parameters.Add(new MySqlParameter(newStr + "IsRecommend", goods.IsRecommend));
                parameters.Add(new MySqlParameter(newStr + "IsHot", goods.IsHot));
                parameters.Add(new MySqlParameter(newStr + "CommentCount", goods.CommentCount));
                parameters.Add(new MySqlParameter(newStr + "BrowseCount", goods.BrowseCount));
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
        /// 更新产品销量
        /// </summary>
        /// <param name="goodsIds"></param>
        /// <param name="goodsNums"></param>
        /// <returns></returns>
        public static bool UpdateGoodsSales(List<int> goodsIds, List<int> goodsNums)
        {
            if (goodsIds.Count == 0 || goodsNums.Count == 0 || goodsIds.Count != goodsNums.Count) return false;
            var cmdText = "begin;";
            int index = 0;
            foreach (var goodsId in goodsIds)
            {
                cmdText += string.Format("Update Goods Set Sales=Sales+{0} Where Id={1}", goodsNums[index], goodsId);
                index++;
            }
            cmdText += "commit;";
            try
            {
                var num = MySqlHelper.ExecuteNonQuery(Utility._gameDbConn, CommandType.Text, cmdText);
                return num > 0;
            }
            catch (System.Exception ex)
            {
                throw;
            }
            return false;
        }

        /// <summary>
        /// 删除产品列表
        /// </summary>
        /// <param name="sellerId"></param>
        /// <param name="gids"></param>
        /// <returns></returns>
        public static bool DelGoodsList(int sellerId, string gids)
        {
            var cmdText = @"delete from Goods where SellerId=?SellerId and find_in_set(`Id`,?Id)";
            var parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?SellerId", sellerId));
            parameters.Add(new MySqlParameter("?Id", gids));
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