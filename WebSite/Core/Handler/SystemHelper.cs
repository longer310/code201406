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
    public static class SystemHelper
    {
        public static IList<UserLevel> GetUserLevels(int sellerId)
        {
            var results = new List<UserLevel>();
            string commandText = @"select * from userlevel where sellerId = ?sellerId";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?sellerId", sellerId));

            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, commandText, parameters.ToArray());
                    while (reader.Read())
                    {
                        UserLevel ul = new UserLevel();
                        ul.Id = reader.GetInt32(0);

                        ul.SellerId = (int)reader["SellerId"];
                        ul.CreateTime = (DateTime)reader["CreateTime"];
                        ul.Discount = (int)reader["Discount"];
                        ul.NeedMoney = (int)reader["NeedMoney"];
                        ul.Title = reader["Title"].ToString();

                        results.Add(ul);
                    }
                }

            }
            catch (System.Exception ex)
            {
                throw;
            }
            return results;
        }


        public static void CreateUserLevel(UserLevel userLevel)
        {
            string connectionString = GlobalConfig.DbConn;
            string commandText = @"INSERT INTO userLevel 
        	                                ( 
        	                                Title, 
        	                                Discount,
        	                                NeedMoney, 
        	                                SellerId,
        	                                CreateTime
        	                                )
        	                                VALUES
        	                                ( 
        	                                ?Title, 
        	                                ?Discount,
        	                                ?NeedMoney, 
        	                                ?SellerId,
        	                                ?CreateTime
        	                                )";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?Title", userLevel.Title));
            parameters.Add(new MySqlParameter("?Discount", userLevel.Discount));
            parameters.Add(new MySqlParameter("?NeedMoney", userLevel.NeedMoney));
            parameters.Add(new MySqlParameter("?SellerId", userLevel.SellerId));
            parameters.Add(new MySqlParameter("?CreateTime", userLevel.CreateTime));
            MySqlHelper.ExecuteNonQuery(connectionString, CommandType.Text, commandText, parameters.ToArray());
        }

        public static void UpdateUserLevel(UserLevel userLevel)
        {
            string commandText = @"UPDATE userLevel SET
                                        Title = ?Title,
                                        Discount = ?Discount,
                                        NeedMoney = ?NeedMoney,
                                        SellerId = ?SellerId,
                                        CreateTime = ?CreateTime
                                    WHERE
                                        Id = ?Id";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?Id", userLevel.Id));
            parameters.Add(new MySqlParameter("?Title", userLevel.Title));
            parameters.Add(new MySqlParameter("?Discount", userLevel.Discount));
            parameters.Add(new MySqlParameter("?NeedMoney", userLevel.NeedMoney));
            parameters.Add(new MySqlParameter("?SellerId", userLevel.SellerId));
            parameters.Add(new MySqlParameter("?CreateTime", userLevel.CreateTime));

            MySqlHelper.ExecuteNonQuery(GlobalConfig.DbConn, CommandType.Text, commandText, parameters.ToArray());
        }

        private static void DeleteUserLevel(int id)
        {
            string cmd = @"delete from userlevel where id = ?id";
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?Id", id));
            MySqlHelper.ExecuteNonQuery(GlobalConfig.DbConn, CommandType.Text, cmd, parameters.ToArray());
        }

        internal static void UpdateUserLevels(IList<UserLevel> userlevels)
        {
            foreach (var ul in userlevels)
            {
                if (ul.Id != 0)
                    UpdateUserLevel(ul);
                else
                    CreateUserLevel(ul);
            }
        }

        public static MerchantStat GetMerchantStat(int sellerId)
        {
            MerchantStat m = new MerchantStat();
            string[] statString = new string[] { "account", "active", "goods", "material", "orders" };
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            foreach (var stat in statString)
            {
                string commandText = string.Format(@"select count(*) from {0} where sellerId = ?sellerId", stat);
                parameters.Clear();
                parameters.Add(new MySqlParameter("?sellerId", sellerId));

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
                                    m.UserCount = reader.GetInt32(0); break;
                                case "active":
                                    m.ActiveCount = reader.GetInt32(0); break;
                                case "goods":
                                    m.GoodsCount = reader.GetInt32(0); break;
                                case "material":
                                    m.ImgCount = reader.GetInt32(0); break;
                                case "orders":
                                    m.OrderNumber = reader.GetInt32(0); break;
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
            string moneyCmd = @"select count(totalprice) from orders where sellerid=?sellerId and status = 2";
            parameters.Clear();
            parameters.Add(new MySqlParameter("?sellerId", sellerId));
            try
            {

                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, moneyCmd, parameters.ToArray());
                    while (reader.Read())
                    {
                        m.MoneyCount = reader.GetInt32(0);
                    }
                }

            }
            catch (System.Exception ex)
            {
                throw;
            }
            return m;


        }

        public static void CreatePush(Push push)
        {
            string connectionString = GlobalConfig.DbConn;
            string commandText = @"INSERT INTO push 
        	                                (
         	                                SellerId, 
        	                                Title, 
        	                                PushType,
        	                                Content, 
        	                                TypeId,
        	                                CreateTime
        	                                )
        	                                VALUES
        	                                ( 
      	                                    ?SellerId,
        	                                ?Title, 
        	                                ?PushType,
        	                                ?Content, 
        	                                ?TypeId,
        	                                ?CreateTime
        	                                )";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?Title", push.Title));
            parameters.Add(new MySqlParameter("?SellerId", push.Title));
            parameters.Add(new MySqlParameter("?PushType", push.PushType));
            parameters.Add(new MySqlParameter("?Content", push.Content));
            parameters.Add(new MySqlParameter("?TypeId", push.TypeId));
            parameters.Add(new MySqlParameter("?CreateTime", push.CreateTime));
            MySqlHelper.ExecuteNonQuery(connectionString, CommandType.Text, commandText, parameters.ToArray());
        }

        public static void UpdatePush(Push push)
        {
            string commandText = @"UPDATE push SET
                                        SellerId = ?SellerId,
                                        Title = ?Title,
                                        PushType = ?PushType,
                                        Content = ?Content,
                                        TypeId = ?TypeId,
                                        CreateTime = ?CreateTime
                                    WHERE
                                        Id = ?Id";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?Id", push.Id));
            parameters.Add(new MySqlParameter("?Title", push.Title));
            parameters.Add(new MySqlParameter("?PushType", push.PushType));
            parameters.Add(new MySqlParameter("?Content", push.Content));
            parameters.Add(new MySqlParameter("?TypeId", push.TypeId));
            parameters.Add(new MySqlParameter("?CreateTime", push.CreateTime));
            parameters.Add(new MySqlParameter("?SellerId", push.SellerId));


            MySqlHelper.ExecuteNonQuery(GlobalConfig.DbConn, CommandType.Text, commandText, parameters.ToArray());
        }

        public static PagResults<Push> GetPagPushs(int sellerId, int start, int limit)
        {
            var results = new PagResults<Push>();
            string commandText = @"select * from push where sellerId = ?sellerId order by CreateTime desc limit ?index,?size";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?sellerId", sellerId));
            parameters.Add(new MySqlParameter("?index", start));
            parameters.Add(new MySqlParameter("?size", limit));
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, commandText, parameters.ToArray());
                    while (reader.Read())
                    {
                        Push p = new Push();
                        p.Id = reader.GetInt32(0);

                        p.SellerId = (int)reader["SellerId"];
                        p.CreateTime = (DateTime)reader["CreateTime"];
                        p.TypeId = (int)reader["Discount"];
                        p.PushType = (PushType)reader["PushType"];
                        p.Title = reader["Title"].ToString();
                        p.Content = reader["Content"].ToString();
                        p.CreateTime = (DateTime)reader["CreateTime"];

                        results.Results.Add(p);
                    }
                    //一个函数有两次连接数据库 先把连接断开 然后重连
                    conn.Close();
                    conn.Dispose();
                    conn.Open();

                    commandText = @"select count(*) from push";
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

        
    }
}