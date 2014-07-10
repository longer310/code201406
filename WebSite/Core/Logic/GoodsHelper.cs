using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using Backstage.Core.Dapper;
using Backstage.Core.Entity;
using MySql.Data.MySqlClient;

namespace Backstage.Core.Logic
{
    public static class GoodsHelper
    {
        public static List<Goods> GetGoodsList(int sellerId, out int totalnum, string wheresql = "",
            string ordersql = "", int start = 0, int limit = 0,int gettotal = 1)
        {
            totalnum = 0;
            List<Goods> list = new List<Goods>();
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
                MySqlDataReader reader = MySqlHelper.ExecuteReader(Utility._gameDbConn, CommandType.Text, cmdText,
                    parameters.ToArray());
                while (reader.Read())
                {
                    Goods goods = new Goods();
                    goods.Id = reader.GetInt32(0);
                    goods.SellerId = (int)reader["SellerId"];
                    goods.Logo = (int)reader["Logo"];
                    goods.ImgIds = reader["ImgIds"].ToString();
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

                    list.Add(goods);
                }

                if (gettotal == 1)
                {
                    cmdText = string.Format("select count(*) from goods where SellerId={0} ", sellerId) + wheresql;
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

        public static Goods GetGoods(int id)
        {
            var sql = string.Format("select a.*,m.Url from Goods as a left join material m on a.Logo=m.Id where a.Id={0} limit 1;", id);
            try
            {
                MySqlDataReader reader = MySqlHelper.ExecuteReader(Utility._gameDbConn, CommandType.Text, sql);
                if (reader.HasRows)
                {
                    if (reader.Read())
                    {
                        Goods goods = new Goods();
                        goods.Id = reader.GetInt32(0);
                        goods.SellerId = (int)reader["SellerId"];
                        goods.Logo = (int)reader["Logo"];
                        goods.ImgIds = reader["ImgIds"].ToString();
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
                        return goods;
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
                                        IsHot           = ?IsHot
                                    WHERE
                                        Id = ?Id";
                parameters.Add(new MySqlParameter("?Id", goods.Id));
                parameters.Add(new MySqlParameter("?SellerId", goods.SellerId));
                parameters.Add(new MySqlParameter("?ImgIds", goods.ImgIds));
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
                                        ?IsHot         
                                        )";
                parameters.Add(new MySqlParameter("?SellerId", goods.SellerId));
                parameters.Add(new MySqlParameter("?ImgIds", goods.ImgIds));
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