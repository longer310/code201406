using Backstage.Core.Entity;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace Backstage.Core.Handler
{
    public class GeneralHelper
    {
        internal static void GenerateWifi(UserWifi user_wifi)
        {
            string connectionString = GlobalConfig.DbConn;

            string commandText = @"INSERT INTO userwifi 
	                                ( 
	                                SellerId, 
	                                Pwd,
	                                UserId,
                                    Expiry
	                                )
	                                VALUES
	                                ( 
	                                ?SellerId, 
	                                ?Pwd,
	                                ?UserId,
                                    ?Expiry
	                                )";


            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?SellerId", user_wifi.SellerId));
            parameters.Add(new MySqlParameter("?Pwd", user_wifi.Pwd));
            parameters.Add(new MySqlParameter("?UserId", user_wifi.UserId));
            parameters.Add(new MySqlParameter("?Expiry", user_wifi.Expiry));


            MySqlHelper.ExecuteNonQuery(connectionString, CommandType.Text, commandText, parameters.ToArray());
        }

        internal static void UpdateWifi(UserWifi user_wifi)
        {
            string commandText = @"UPDATE userwifi SET
                                        SellerId = ?SellerId,
                                        Pwd = ?Pwd,
                                        UserId = ?UserId,
                                        Expiry = ?Expiry
                                    WHERE
                                        Id = ?Id";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?Id", user_wifi.Id));
            parameters.Add(new MySqlParameter("?SellerId", user_wifi.SellerId));
            parameters.Add(new MySqlParameter("?Pwd", user_wifi.Pwd));
            parameters.Add(new MySqlParameter("?UserId", user_wifi.UserId));
            parameters.Add(new MySqlParameter("?Expiry", user_wifi.Expiry));

            MySqlHelper.ExecuteNonQuery(GlobalConfig.DbConn, CommandType.Text, commandText, parameters.ToArray());
        }


        public static UserWifi GetUserWifiItem(string pwd, int sellerId)
        {
            UserWifi uw = null;
            string commandText = @"select * from userwifi where pwd = ?pwd and sellerId = ?sellerId";
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?pwd", pwd));
            parameters.Add(new MySqlParameter("?sellerId", sellerId));
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    //MySqlDataReader reader = MySqlHelper.ExecuteReader(GlobalConfig.DbConn, CommandType.Text, commandText, parameters.ToArray());
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, commandText, parameters.ToArray());
                    while (reader.Read())
                    {
                        uw = new UserWifi();
                        uw.Id = reader.GetInt32(0);
                        uw.SellerId = (int)reader["SellerId"];
                        uw.Pwd = reader["Pwd"].ToString();
                        uw.UserId = (int)reader["UserId"];
                        uw.Expiry = (DateTime)reader["Expiry"];
                    }
                }

            }
            catch (System.Exception ex)
            {
                throw;
            }
            return uw;
        }

        public static UserWifi GetUserWifiItem(int userId, int sellerId)
        {
            UserWifi uw = null;
            string commandText = @"select * from userwifi where userId = ?userId and sellerId = ?sellerId";
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?userId", userId));
            parameters.Add(new MySqlParameter("?sellerId", sellerId));
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    //MySqlDataReader reader = MySqlHelper.ExecuteReader(GlobalConfig.DbConn, CommandType.Text, commandText, parameters.ToArray());
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, commandText, parameters.ToArray());
                    while (reader.Read())
                    {
                        uw = new UserWifi();
                        uw.Id = reader.GetInt32(0);
                        uw.SellerId = (int)reader["SellerId"];
                        uw.Pwd = reader["Pwd"].ToString();
                        uw.UserId = (int)reader["UserId"];
                        uw.Expiry = (DateTime)reader["Expiry"];
                    }
                }

            }
            catch (System.Exception ex)
            {
                throw;
            }
            return uw;
        }

        internal static WeixinToken GetWeixinToken(string access_token, int sellerId)
        {
            var wt = new WeixinToken();
            string commandText = @"select * from weixintoken where access_token = ?access_token and sellerId = ?sellerId";
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?access_token", access_token));
            parameters.Add(new MySqlParameter("?sellerId", sellerId));
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    //MySqlDataReader reader = MySqlHelper.ExecuteReader(GlobalConfig.DbConn, CommandType.Text, commandText, parameters.ToArray());
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, commandText, parameters.ToArray());
                    while (reader.Read())
                    {
                        wt.Id = reader.GetInt32(0);
                        wt.SellerId = (int)reader["SellerId"];
                        wt.Access_token = reader["Access_token"].ToString();
                        wt.Token_Expire = (DateTime)reader["UserId"];
                    }
                }

            }
            catch (System.Exception ex)
            {
                throw;
            }
            return wt;
        }

        internal static void CreateWeixinToken(WeixinToken item)
        {
            string connectionString = GlobalConfig.DbConn;

            string commandText = @"INSERT INTO weixintoken 
	                                ( 
	                                Access_token, 
	                                SellerId,
	                                Token_Expire
	                                )
	                                VALUES
	                                ( 
	                                ?Access_token, 
	                                ?SellerId,
	                                ?Token_Expire
	                                )";


            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?Access_token", item.Access_token));
            parameters.Add(new MySqlParameter("?SellerId", item.SellerId));
            parameters.Add(new MySqlParameter("?Token_Expire", item.Token_Expire));


            MySqlHelper.ExecuteNonQuery(connectionString, CommandType.Text, commandText, parameters.ToArray());
        }

        internal static void UpdateWeixinToken(WeixinToken item)
        {
            string commandText = @"UPDATE weixintoken SET
                                        SellerId = ?SellerId,
                                        Access_token = ?Access_token,
                                        Token_Expire = ?Token_Expire
                                    WHERE
                                        Id = ?Id";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?Id", item.Id));
            parameters.Add(new MySqlParameter("?SellerId", item.SellerId));
            parameters.Add(new MySqlParameter("?Access_token", item.Access_token));
            parameters.Add(new MySqlParameter("?Token_Expire", item.Token_Expire));

            MySqlHelper.ExecuteNonQuery(GlobalConfig.DbConn, CommandType.Text, commandText, parameters.ToArray());
        }
    }
}