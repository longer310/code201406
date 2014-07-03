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
        public static List<Goods> GetGoodsList(int sellerId, out int totalnum, string wsql = "", int limit = 0)
        {
            totalnum = 0;
            List<Goods> list = new List<Goods>();
            var sql = String.Format("select * from goods where SellerId={0} ", sellerId);
            if (wsql != "") sql += " " + wsql;
            if (limit != 0) sql += String.Format(" limit 0,{0}", limit);
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
    }
}