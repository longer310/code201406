using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using Backstage.Core.Entity;
using MySql.Data.MySqlClient;

namespace Backstage.Core.Logic
{
    public static class GoodsHelper
    {
        public static List<Goods> GetGoodsList(int sellerId, out int totalnum, string wheresql = "", string ordersql = "", int start = 0, int limit = 0)
        {
            totalnum = 0;
            List<Goods> list = new List<Goods>();
            var sql = String.Format("select * from goods where SellerId={0} and ", sellerId);
            if (wheresql != "") sql += " " + wheresql;
            if (ordersql != "") sql += " " + ordersql;
            else sql += " order by CreateTime desc";
            if (limit != 0) sql += String.Format(" limit {0},{1};", start, limit);
            try
            {
                MySqlDataReader reader = MySqlHelper.ExecuteReader(Utility._gameDbConn, CommandType.Text, sql);
                var dset = MySqlHelper.ExecuteDataset(Utility._gameDbConn, CommandType.Text, sql);
                DataTable dt = dset.Tables[0];
                while (reader.Read())
                {
                    Goods goods = new Goods();
                    goods.Id = reader.GetInt32(0);
                    goods.SellerId = reader.GetInt32(1);
                    goods.Logo = reader.GetInt32(2);
                    goods.ImgIds = reader.GetString(3);
                    goods.Sales = reader.GetInt32(4);
                    goods.Title = reader.GetString(5);
                    goods.Cid = reader.GetInt32(6);
                    goods.Nowprice = reader.GetInt32(7);
                    goods.OriginalPrice = reader.GetInt32(8);
                    goods.Score = reader.GetInt32(9);
                    goods.CreateTime = reader.GetDateTime(10);
                    goods.FavCount = reader.GetInt32(11);
                    goods.ShareCount = reader.GetInt32(12);
                    goods.Tag = reader.GetString(13);
                    goods.Content = reader.GetString(14);

                    list.Add(goods);
                }

                sql = string.Format("select count(*) from goods where SellerId={0} ", sellerId);
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

        public static Goods GetGoods(int id)
        {
            var sql = string.Format("select * from Goods where Id={0} limit 1;", id);
            try
            {
                MySqlDataReader reader = MySqlHelper.ExecuteReader(Utility._gameDbConn, CommandType.Text, sql);
                if (reader.HasRows)
                {
                    if (reader.Read())
                    {
                        Goods goods = new Goods();
                        goods.Id = reader.GetInt32(0);
                        goods.SellerId = reader.GetInt32(1);
                        goods.Logo = reader.GetInt32(2);
                        goods.ImgIds = reader.GetString(3);
                        goods.Sales = reader.GetInt32(4);
                        goods.Title = reader.GetString(5);
                        goods.Cid = reader.GetInt32(6);
                        goods.Nowprice = reader.GetInt32(7);
                        goods.OriginalPrice = reader.GetInt32(8);
                        goods.Score = reader.GetInt32(9);
                        goods.CreateTime = reader.GetDateTime(10);
                        goods.FavCount = reader.GetInt32(11);
                        goods.ShareCount = reader.GetInt32(12);
                        goods.Tag = reader.GetString(13);
                        goods.Content = reader.GetString(14);
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
            var sql = string.Empty;
            if (goods.Id > 0)
                string.Format("update Goods set ImgIds='{0}', Sales={1},Title='{2}',Cid={3},NowPrice={4},OriginalPrice={5},Score={6},CreateTime='{7}',FavCount={8},ShareCount={9},Tag='{10}',Content='{11}' where Id={12}",goods.ImgIds,goods.Sales,goods.Title,goods.Cid,goods.Nowprice,goods.OriginalPrice,goods.Score,goods.CreateTime,goods.FavCount,goods.ShareCount,goods.Tag,goods.Content,goods.Id);
            else
            {
                string.Format("insert into Goods(ImgIds,Sales,Title,Cid,Nowprice,OriginalPrice,Score,CreateTime,FavCount,ShareCount,Tag,Content) values('{0}',{1},'{2}',{3},{4},{5},{6},'{7}',{8},{9},'{10}','{11}')", goods.ImgIds, goods.Sales, goods.Title, goods.Cid, goods.Nowprice, goods.OriginalPrice, goods.Score, goods.CreateTime, goods.FavCount, goods.ShareCount, goods.Tag, goods.Content);
            }
            try
            {
                var num = MySqlHelper.ExecuteNonQuery(Utility._gameDbConn, CommandType.Text, sql);
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