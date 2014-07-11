using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Security.Cryptography;
using System.Security.Principal;
using System.Text;
using System.Web;
using System.Web.Security;
using Backstage.Core.Entity;
using MySql.Data.MySqlClient;

namespace Backstage.Core
{
    public static class AccountHelper
    {
        public static List<Account> GetUserList(out int totalnum, string wheresql = "", string ordersql = ""
            , int start = 0, int limit = 0)
        {
            totalnum = 0;
            List<Account> list = new List<Account>();
            if (ordersql == "") ordersql = " order by CreateTime desc";
            string limitsql = limit != 0 ? " LIMIT ?start,?limit" : string.Empty;
            var cmdText = @"select * from account " + wheresql + ordersql + limitsql;

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            if (!string.IsNullOrEmpty(limitsql))
            {
                parameters.Add(new MySqlParameter("?start", start));
                parameters.Add(new MySqlParameter("?limit", limit));
            }

            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText,
                        parameters.ToArray());
                    while (reader.Read())
                    {
                        Account user = new Account();
                        user.Id = reader.GetInt32(0);
                        user.UserName = reader["UserName"].ToString();
                        user.Pwd = reader["Pwd"].ToString();
                        user.RoleType = (RoleType) reader["RoleType"];
                        user.Avatar = reader["Avatar"].ToString();
                        user.Sex = (int) reader["Sex"];
                        user.CreateTime = (DateTime) reader["CreateTime"];

                        list.Add(user);
                    }

                    //一个函数有两次连接数据库 先把连接断开 然后重连
                    conn.Close();
                    conn.Dispose();
                    conn.Open();

                    cmdText = @"select count(*) from account " + wheresql;
                    reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText);
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

        public static IList<Account> GetUserList(IList<int> uids)
        {
            IList<Account> list = new List<Account>();

            string ids_string = "(";
            foreach (var uid in uids)
            {
                ids_string += (uid + ",");
            }
            ids_string = ids_string.TrimEnd(',') + ")";
            string cmdText = string.Format(@"select * from account where id in {0}", ids_string);
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText);
                    while (reader.Read())
                    {
                        Account user = new Account();
                        user.Id = reader.GetInt32(0);
                        user.UserName = reader["UserName"].ToString();
                        user.Pwd = reader["Pwd"].ToString();
                        user.RoleType = (RoleType) reader["RoleType"];
                        user.Avatar = reader["Avatar"].ToString();
                        user.Sex = Convert.ToInt32(reader["Sex"]);
                        user.CreateTime = (DateTime) reader["CreateTime"];

                        list.Add(user);
                    }
                }
            }
            catch (System.Exception ex)
            {
                throw;
            }
            return list;
        }

        public static int UpdateUser(Account account)
        {
            var cmdText = string.Empty;
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            if (account.Id > 0)
            {
                cmdText = @"UPDATE account SET
                                        UserName        = ?UserName,
                                        Pwd             = ?Pwd,
                                        RoleType        = ?RoleType,
                                        Avatar          = ?Avatar,
                                        Sex             = ?Sex,
                                        CreateTime      = ?CreateTime
                                    WHERE
                                        Id = ?Id";
                parameters.Add(new MySqlParameter("?Id", account.Id));
                parameters.Add(new MySqlParameter("?UserName", account.UserName));
                parameters.Add(new MySqlParameter("?Pwd", account.Pwd));
                parameters.Add(new MySqlParameter("?RoleType", account.RoleType));
                parameters.Add(new MySqlParameter("?Avatar", account.Avatar));
                parameters.Add(new MySqlParameter("?Sex", account.Sex));
                parameters.Add(new MySqlParameter("?CreateTime", account.CreateTime));
            }
            else
            {
                cmdText = @"insert into account
                                        (
                                        UserName   ,
                                        Pwd        ,
                                        RoleType   ,
                                        Avatar     ,
                                        Sex        ,
                                        CreateTime 
                                        ) 
                                        values
                                        (
                                        ?UserName  ,
                                        ?Pwd       ,
                                        ?RoleType  ,
                                        ?Avatar    ,
                                        ?Sex       ,
                                        ?CreateTime
                                        )";
                parameters.Add(new MySqlParameter("?UserName", account.UserName));
                parameters.Add(new MySqlParameter("?Pwd", account.Pwd));
                parameters.Add(new MySqlParameter("?RoleType", account.RoleType));
                parameters.Add(new MySqlParameter("?Avatar", account.Avatar));
                parameters.Add(new MySqlParameter("?Sex", account.Sex));
                parameters.Add(new MySqlParameter("?CreateTime", account.CreateTime));
            }

            try
            {
                return MySqlHelper.ExecuteNonQuery(Utility._gameDbConn, CommandType.Text, cmdText, parameters.ToArray());
            }
            catch (System.Exception ex)
            {
                return 0;
            }
        }

        public static int DelUser(int id)
        {
            var cmdText = string.Format("delete from account where Id={0}", id);

            try
            {
                return MySqlHelper.ExecuteNonQuery(Utility._gameDbConn, CommandType.Text, cmdText);
            }
            catch (System.Exception ex)
            {
                return 0;
            }
        }
    }
}