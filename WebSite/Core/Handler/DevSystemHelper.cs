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
    public static class DevSystemHelper
    {
        public static Fastlinks GetFastlinksItem(int id)
        {
            var f = new Fastlinks();
            string commandText = @"select * from fastlinks where id = ?id";
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?id", id));
            try
            {
                using (var conn = new MySqlConnection(GlobalConfig.DbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, commandText, parameters.ToArray());
                    while (reader.Read())
                    {
                        f.Id = reader.GetInt32(0);
                        f.Title = reader["Title"].ToString();
                        f.ImgUrl = reader["ImgUrl"].ToString();
                        f.Url = reader["Url"].ToString();
                        f.CreateTime = (DateTime)reader["CreateTime"];
                    }
                }
            }
            catch (System.Exception ex)
            {
                throw;
            }
            return f;
        }

        public static PagResults<Fastlinks> GetPagFastlinks(int start, int limit)
        {
            var results = new PagResults<Fastlinks>();
            string commandText; List<MySqlParameter> parameters = new List<MySqlParameter>();
            if (limit == 0)
            {
                commandText = @"select * from fastlinks order by CreateTime desc";
            }
            else
            {
                commandText = @"select * from fastlinks order by CreateTime desc limit ?index,?size";
                parameters.Add(new MySqlParameter("?index", start));
                parameters.Add(new MySqlParameter("?size", limit));
            }

            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, commandText, parameters.ToArray());
                    while (reader.Read())
                    {
                        Fastlinks f = new Fastlinks();
                        f.Id = reader.GetInt32(0);
                        f.Title = reader["Title"].ToString();
                        f.ImgUrl = reader["ImgUrl"].ToString();
                        f.Url = reader["Url"].ToString();
                        f.CreateTime = (DateTime)reader["CreateTime"];

                        results.Results.Add(f);
                    }
                    //一个函数有两次连接数据库 先把连接断开 然后重连
                    conn.Close();
                    conn.Dispose();
                    conn.Open();

                    commandText = @"select count(*) from fastlinks";
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

        public static void CreateFastlinks(Fastlinks fastlinks)
        {
            string connectionString = GlobalConfig.DbConn;
            string commandText = @"INSERT INTO fastlinks 
        	                                (
        	                                Title, 
        	                                ImgUrl,
        	                                Url, 
        	                                CreateTime
        	                                )
        	                                VALUES
        	                                ( 
        	                                ?Title, 
        	                                ?ImgUrl,
        	                                ?Url, 
        	                                ?CreateTime
        	                                )";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?Title", fastlinks.Title));
            parameters.Add(new MySqlParameter("?ImgUrl", fastlinks.ImgUrl));
            parameters.Add(new MySqlParameter("?Url", fastlinks.Url));
            parameters.Add(new MySqlParameter("?CreateTime", fastlinks.CreateTime));
            MySqlHelper.ExecuteNonQuery(connectionString, CommandType.Text, commandText, parameters.ToArray());
        }

        public static void UpdateFasklinks(Fastlinks fastlinks)
        {
            string commandText = @"UPDATE fastlinks SET
                                        Title = ?Title,
                                        ImgUrl = ?ImgUrl,
                                        Url = ?Url,
                                        CreateTime = ?CreateTime
                                    WHERE
                                        Id = ?Id";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?Id", fastlinks.Id));
            parameters.Add(new MySqlParameter("?Title", fastlinks.Title));
            parameters.Add(new MySqlParameter("?ImgUrl", fastlinks.ImgUrl));
            parameters.Add(new MySqlParameter("?CreateTime", fastlinks.CreateTime));
            parameters.Add(new MySqlParameter("?Url", fastlinks.Url));

            MySqlHelper.ExecuteNonQuery(GlobalConfig.DbConn, CommandType.Text, commandText, parameters.ToArray());
        }

        internal static void DeleteFastlinks(int id)
        {
            string commandText = @"DELETE FROM fastlinks WHERE Id = ?Id";
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?Id", id));

            MySqlHelper.ExecuteNonQuery(GlobalConfig.DbConn, CommandType.Text, commandText, parameters.ToArray());
        }

        internal static SystemStat GetSystemStat()
        {
            SystemStat s = new SystemStat();
            string[] statString = new string[] { "account", "active", "goods", "material", "orders","money","merchant" };
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            foreach (var stat in statString)
            {
                string commandText = string.Format(@"select count(*) from {0}", stat);
                if (stat == "money")
                    commandText = string.Format(@"select count(TotalPrice) from orders where Status=2");

                try
                {
                    using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                    {
                        MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, commandText, parameters.ToArray());
                        while (reader.Read())
                        {
                            switch (stat)
                            {
                                case "account":
                                    s.UserCount = reader.GetInt32(0); break;
                                case "active":
                                    s.ActiveCount = reader.GetInt32(0); break;
                                case "goods":
                                    s.GoodsCount = reader.GetInt32(0); break;
                                case "material":
                                    s.ImgCount = reader.GetInt32(0); break;
                                case "orders":
                                    s.OrderNumber = reader.GetInt32(0); break;
                                case "money":
                                    s.MoneyCount = reader.GetFloat(0);break;
                                case "merchant":
                                    s.MerchantCount = reader.GetInt32(0);break;
                                default:
                                    break;
                            }
                        }
                    }

                }
                catch (System.Exception ex)
                {
                    throw;
                }
            }
            return s;
            //string moneyCmd = @"select count(totalprice) from orders where sellerid=?sellerId and status = 2";
            //parameters.Clear();
            //parameters.Add(new MySqlParameter("?sellerId", sellerId));
            //try
            //{

            //    using (var conn = Utility.ObtainConn(Utility._gameDbConn))
            //    {
            //        MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, moneyCmd, parameters.ToArray());
            //        while (reader.Read())
            //        {
            //            m.MoneyCount = reader.GetInt32(0);
            //        }
            //    }

            //}
            //catch (System.Exception ex)
            //{
            //    throw;
            //}
            //return m;
        }
    }
}