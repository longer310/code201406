﻿using System;
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
            string limitsql = limit != 0 ? " LIMIT ?start,?limit" : String.Empty;
            var cmdText = @"select * from account " + wheresql + ordersql + limitsql;

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            if (!String.IsNullOrEmpty(limitsql))
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
                        user.RoleType = (RoleType)reader["RoleType"];
                        user.Avatar = reader["Avatar"].ToString();
                        user.Sex = (SexType)reader["Sex"];
                        user.Phone = reader["Phone"].ToString();
                        user.Address = reader["Address"].ToString();
                        user.Money = (float)reader["Money"];
                        user.SellerId = (int)reader["SellerId"];
                        user.CreateTime = (DateTime)reader["CreateTime"];
                        user.Extcredit = (int)reader["Extcredit"];
                        user.LinkMan = reader["LinkMan"].ToString();

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
            catch (Exception ex)
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
            string cmdText = String.Format(@"select * from account where id in {0}", ids_string);
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
                        user.RoleType = (RoleType)reader["RoleType"];
                        user.Avatar = reader["Avatar"].ToString();
                        user.Sex = (SexType)reader["Sex"];
                        user.Phone = reader["Phone"].ToString();
                        user.Address = reader["Address"].ToString();
                        user.Money = (float)reader["Money"];
                        user.SellerId = (int)reader["SellerId"]; 
                        user.CreateTime = (DateTime)reader["CreateTime"];
                        user.Extcredit = (int)reader["Extcredit"];
                        user.LinkMan = reader["LinkMan"].ToString();

                        list.Add(user);
                    }
                }
            }
            catch (Exception ex)
            {
                throw;
            }
            return list;
        }

        /// <summary>
        /// 插入或更新用户
        /// </summary>
        /// <param name="account"></param>
        /// <returns></returns>
        public static int UpdateUser(Account account)
        {
            var cmdText = String.Empty;
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            if (account.Id > 0)
            {
                cmdText = @"UPDATE account SET
                                        UserName        = ?UserName,
                                        Pwd             = ?Pwd,
                                        RoleType        = ?RoleType,
                                        Avatar          = ?Avatar,
                                        Sex             = ?Sex,
                                        Phone             = ?Phone,
                                        Address        = ?Address,
                                        SellerId          = ?SellerId,
                                        Money             = ?Money,
                                        Extcredit             = ?Extcredit,
                                        LinkMan             = ?LinkMan,
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
                parameters.Add(new MySqlParameter("?Phone", account.Phone));
                parameters.Add(new MySqlParameter("?Address", account.Address));
                parameters.Add(new MySqlParameter("?Money", account.Money));
                parameters.Add(new MySqlParameter("?Extcredit", account.Extcredit));
                parameters.Add(new MySqlParameter("?LinkMan", account.LinkMan));
                parameters.Add(new MySqlParameter("?SellerId", account.SellerId));
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
                                        Phone        ,
                                        Address   ,
                                        SellerId     ,
                                        Money        ,
                                        Extcredit        ,
                                        LinkMan        ,
                                        CreateTime 
                                        ) 
                                        values
                                        (
                                        ?UserName  ,
                                        ?Pwd       ,
                                        ?RoleType  ,
                                        ?Avatar    ,
                                        ?Sex       ,
                                        ?Phone       ,
                                        ?Address  ,
                                        ?SellerId    ,
                                        ?Money       ,
                                        ?Extcredit       ,
                                        ?LinkMan       ,
                                        ?CreateTime
                                        )";
                parameters.Add(new MySqlParameter("?UserName", account.UserName));
                parameters.Add(new MySqlParameter("?Pwd", account.Pwd));
                parameters.Add(new MySqlParameter("?RoleType", account.RoleType));
                parameters.Add(new MySqlParameter("?Avatar", account.Avatar));
                parameters.Add(new MySqlParameter("?Sex", account.Sex));
                parameters.Add(new MySqlParameter("?CreateTime", account.CreateTime));
                parameters.Add(new MySqlParameter("?Phone", account.Phone));
                parameters.Add(new MySqlParameter("?Address", account.Address));
                parameters.Add(new MySqlParameter("?Money", account.Money));
                parameters.Add(new MySqlParameter("?SellerId", account.SellerId));
                parameters.Add(new MySqlParameter("?Extcredit", account.Extcredit));
            }

            try
            {
                var num = MySqlHelper.ExecuteNonQuery(Utility._gameDbConn, CommandType.Text, cmdText, parameters.ToArray());
                if (account.Id == 0)
                {
                    using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                    {
                        cmdText = @"select @@identity";
                        var reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText);
                        if (reader.HasRows)
                        {
                            if (reader.Read())
                            {
                                num = reader.GetInt32(0);
                            }
                        }
                    }
                }
                return num;
            }
            catch (Exception ex)
            {
                return 0;
            }
        }

        public static int DelUser(int id)
        {
            var cmdText = String.Format("delete from account where Id={0}", id);

            try
            {
                return MySqlHelper.ExecuteNonQuery(Utility._gameDbConn, CommandType.Text, cmdText);
            }
            catch (Exception ex)
            {
                return 0;
            }
        }

        public static Account FindUserByPhone(string phone)
        {
            var sql = String.Format("select * from account where Phone='{0}' limit 1;", phone);
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, sql);
                    if (reader.HasRows)
                    {
                        if (reader.Read())
                        {
                            Account user = new Account();
                            user.Id = reader.GetInt32(0);
                            user.UserName = reader["UserName"].ToString();
                            user.Pwd = reader["Pwd"].ToString();
                            user.RoleType = (RoleType)reader["RoleType"];
                            user.Avatar = reader["Avatar"].ToString();
                            user.Sex = (SexType)reader["Sex"];
                            user.Phone = reader["Phone"].ToString();
                            user.Address = reader["Address"].ToString();
                            user.Money = (float)reader["Money"];
                            user.SellerId = (int)reader["SellerId"];
                            user.CreateTime = (DateTime)reader["CreateTime"];
                            user.Extcredit = (int)reader["Extcredit"];
                            user.LinkMan = reader["LinkMan"].ToString();
                            return user;
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

        public static Account GetUser(int id)
        {
            var sql = String.Format("select * from account where Id={0} limit 1;", id);
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, sql);
                    if (reader.HasRows)
                    {
                        if (reader.Read())
                        {
                            Account user = new Account();
                            user.Id = reader.GetInt32(0);
                            user.UserName = reader["UserName"].ToString();
                            user.Pwd = reader["Pwd"].ToString();
                            user.RoleType = (RoleType)reader["RoleType"];
                            user.Avatar = reader["Avatar"].ToString();
                            user.Sex = (SexType)reader["Sex"];
                            user.Phone = reader["Phone"].ToString();
                            user.Address = reader["Address"].ToString();
                            user.Money = (float)reader["Money"];
                            user.SellerId = (int)reader["SellerId"]; ;
                            user.CreateTime = (DateTime)reader["CreateTime"];
                            user.Extcredit = (int)reader["Extcredit"];
                            user.LinkMan = reader["LinkMan"].ToString();
                            return user;
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

        public static Account FindUser(string userName)
        {
            var sql = @"select * from account where username=?username and roletype <>?roletype limit 1;";
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?username", userName));
            parameters.Add(new MySqlParameter("?roletype", (int)RoleType.ThirdUser));//第三方账号可能用户名会重复！
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, sql);
                    if (reader.HasRows)
                    {
                        if (reader.Read())
                        {
                            Account user = new Account();
                            user.Id = reader.GetInt32(0);
                            user.UserName = reader["UserName"].ToString();
                            user.Pwd = reader["Pwd"].ToString();
                            user.RoleType = (RoleType)reader["RoleType"]; 
                            user.Avatar = reader["Avatar"].ToString(); 
                            user.Sex = (SexType)reader["Sex"]; 
                            user.Phone = reader["Phone"].ToString(); 
                            user.Address = reader["Address"].ToString();
                            user.Money = (float)reader["Money"];
                            user.SellerId = (int)reader["SellerId"]; ;
                            user.CreateTime = (DateTime)reader["CreateTime"];
                            user.Extcredit = (int)reader["Extcredit"];
                            user.LinkMan = reader["LinkMan"].ToString();
                            return user;
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

        public static bool JudgeUser(string phone, string username)
        {
            var sql = @"select * from account where username=?username or phone=?phone limit 1;";
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?username", username));
            parameters.Add(new MySqlParameter("?phone", phone));
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, sql,parameters.ToArray());
                    return reader.HasRows;
                }
            }
            catch (System.Exception ex)
            {
                throw;
            }
            return false;
        }

        public static bool JudgeUserLogin(string phone, string password,int sellerId)
        {
            var sql = @"select * from account where pwd=?password and phone=?phone and sellerId=?sellerId limit 1;";
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?password", password));
            parameters.Add(new MySqlParameter("?phone", phone));
            parameters.Add(new MySqlParameter("?sellerId", sellerId));
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, sql, parameters.ToArray());
                    return reader.HasRows;
                }
            }
            catch (System.Exception ex)
            {
                throw;
            }
            return false;
        }

        /// <summary>
        /// 根据基本信息构成实体
        /// </summary>
        /// <param name="str"></param>
        /// <returns></returns>
        private static Account GetEntityFromString(string str)
        {
            if (String.IsNullOrEmpty(str))
                return null;
            string[] arr = str.Split('^');
            var entry = new Account();

            entry.Id = Int32.Parse(arr[0]);
            entry.UserName = arr[1];
            entry.RoleType = (RoleType)Int32.Parse(arr[2]);
            //if (arr.Length == 4)
            //{
            //    entry.Servers =
            //        arr[3].Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries).Select(
            //            p => Convert.ToInt32(p)).ToList();
            //}
            return entry;
        }

        /// <summary>
        /// 根据实体获取存储cookie内的基本信息
        /// </summary>
        /// <param name="entry"></param>
        /// <returns></returns>
        public static string GetStringFromEntity(Account entry)
        {
            return String.Format("{0}^{1}^{2}",
                entry.Id,
                entry.UserName,
                (int)entry.RoleType
                );
        }

        /// <summary>
        /// 设置登录
        /// </summary>
        /// <param name="userId">存储在票证中的用户标识。</param>
        /// <param name="isPersistent">如果票证将存储在持久性 Cookie（跨浏览器会话保存），则为 true；否则为 false。如果该票证存储在 URL 中，将忽略此值。</param>
        /// <param name="userData">存储在票证中的用户特定的数据。</param>
        /// <param name="expiration">票证过期时的本地日期和时间。</param>
        public static void SetLogOn(long userId, bool isPersistent, string userData, DateTime expiration)
        {
            if (HttpContext.Current == null)
                return;

            var response = HttpContext.Current.Response;
            var request = HttpContext.Current.Request;
            var ticket = new FormsAuthenticationTicket(
                1
                , userId.ToString()
                , DateTime.Now
                , expiration
                , true
                , userData
                , FormsAuthentication.FormsCookiePath
                );
            var encryptedTicket = FormsAuthentication.Encrypt(ticket);
            var authCookie = new HttpCookie(FormsAuthentication.FormsCookieName, encryptedTicket);
            authCookie.HttpOnly = true;
            authCookie.Expires = expiration;
            if (!String.IsNullOrEmpty(FormsAuthentication.CookieDomain))
                authCookie.Domain = FormsAuthentication.CookieDomain;

            var identity = new FormsIdentity(ticket);
            var user = new GenericPrincipal(identity, new[] { userData });
            HttpContext.Current.User = user;

            response.Cookies.Add(authCookie);
            response.AppendHeader("P3P", "CP=CAO PSA OUR");
        }

        /// <summary>
        /// 退出登录
        /// </summary>
        public static void SetLogOut()
        {
            if (HttpContext.Current == null)
                return;
            FormsAuthentication.SignOut();
            var authCookie = new HttpCookie(FormsAuthentication.FormsCookieName);
            if (!String.IsNullOrEmpty(FormsAuthentication.CookieDomain))
                authCookie.Domain = FormsAuthentication.CookieDomain;
            authCookie.HttpOnly = true;
            authCookie.Expires = DateTime.Now.AddDays(-1d);
            HttpContext.Current.Response.Cookies.Add(authCookie);
        }

        /// <summary>
        /// 获取当前登录用户
        /// </summary>
        /// <returns></returns>
        public static Account GetCurUser()
        {
            var context = HttpContext.Current;
            var userId = 0;
            var userData = String.Empty;
            if (context == null)
                return null;

            var cookie = context.Request.Cookies[FormsAuthentication.FormsCookieName];
            if (cookie == null || String.IsNullOrEmpty(cookie.Value))
                return null;

            try
            {
                var ticket = FormsAuthentication.Decrypt(cookie.Value);
                userId = Convert.ToInt32(ticket.Name);
                userData = ticket.UserData;
            }
            catch (Exception ex)
            {
                userId = 0;
                userData = String.Empty;
            }

            if (userId == 0)
                return null;
            return GetEntityFromString(userData);
        }
    }
}