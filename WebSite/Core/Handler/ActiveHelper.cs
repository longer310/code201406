using Backstage.Core.Entity;
using Backstage.Model;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace Backstage.Core
{
    public class ActiveHelper
    {

        public static Active GetItem(int id)
        {
            var a = new Active();
            string commandText = @"select * from active where id = ?id";
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?id", id));
            try
            {
                MySqlDataReader reader = MySqlHelper.ExecuteReader(GlobalConfig.DbConn, CommandType.Text, commandText, parameters.ToArray());
                while (reader.Read())
                {
                    a.Id = reader.GetInt32(0);
                    a.SellerId = (int)reader["SellerId"];
                    a.CoverImgId = (int)reader["CoverImgId"];
                    a.Title = reader["Title"].ToString();
                    a.Summary = reader["Summary"].ToString();
                    a.CreateTime = (DateTime)reader["CreateTime"];
                }

            }
            catch (System.Exception ex)
            {
                throw;
            }
            return a;
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
        public static PagResults<Active> GetPagings(int sellerId, int index, int size, string order = "")
        {
            var results = new PagResults<Active>();
            results.Results = new List<Active>();
            string commandText = @"select * from active where sellerId = ?sellerId LIMIT ?index,?size " + order;

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?sellerId", sellerId));
            parameters.Add(new MySqlParameter("?index", index));
            parameters.Add(new MySqlParameter("?size", size));

            try
            {
                MySqlDataReader reader = MySqlHelper.ExecuteReader(GlobalConfig.DbConn, CommandType.Text, commandText, parameters.ToArray());
                while (reader.Read())
                {
                    Active a = new Active();
                    a.Id = (int)reader["Id"];
                    a.SellerId = (int)reader["SellerId"];
                    a.CoverImgId = (int)reader["CoverImgId"];
                    a.CoverImgUrl = reader["CoverImgUrl"].ToString();
                    a.Title = reader["Title"].ToString();
                    a.Summary = reader["Summary"].ToString();
                    a.CreateTime = (DateTime)reader["CreateTime"];
                    results.Results.Add(a);
                }

                commandText = "select count(*) from active where sellerId = ?sellerId";
                parameters.Clear();
                parameters.Add(new MySqlParameter("?sellerId", sellerId));
                reader = MySqlHelper.ExecuteReader(GlobalConfig.DbConn, CommandType.Text, commandText, parameters.ToArray());
                if (reader.HasRows)
                {
                    if (reader.Read())
                    {
                        results.TotalCount = reader.GetInt32(0);
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
        /// 活动列表
        /// </summary>
        /// <param name="start"></param>
        /// <param name="limit"></param>
        /// <param name="wheresql"></param>
        /// <param name="ordersql"></param>
        /// <returns></returns>
        public static IList<Active> GetList(int start, int limit, string wheresql = "", string ordersql = "")
        {
            var results = new List<Active>();
            string limitsql = limit == 0 ? string.Empty : " LIMIT ?start,?limit ";
            string commandText = @"select * from active " + wheresql + ordersql + limitsql;

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?start", start));
            parameters.Add(new MySqlParameter("?limit", limit));

            try
            {
                MySqlDataReader reader = MySqlHelper.ExecuteReader(GlobalConfig.DbConn, CommandType.Text, commandText, parameters.ToArray());
                while (reader.Read())
                {
                    Active a = new Active();
                    a.Id = (int)reader["Id"];
                    a.SellerId = (int)reader["SellerId"];
                    a.CoverImgId = (int)reader["CoverImgId"];
                    a.Title = reader["Title"].ToString();
                    a.Summary = reader["Summary"].ToString();
                    a.CreateTime = (DateTime)reader["CreateTime"];
                    results.Add(a);
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