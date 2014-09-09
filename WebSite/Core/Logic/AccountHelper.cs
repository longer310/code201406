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
using Backstage.Model;
using MySql.Data.MySqlClient;

namespace Backstage.Core
{
    public static class AccountHelper
    {
        public static PagResults<Account> GetUserList(string wheresql = "", string ordersql = ""
            , int start = 0, int limit = 0, int isgetcount = 0)
        {
            var result = new PagResults<Account>();
            result.Results = new List<Account>();
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
                        user.NickName = reader["NickName"].ToString();
                        user.Pwd = reader["Pwd"].ToString();
                        user.RoleType = (RoleType)reader["RoleType"];
                        user.Avatar = reader["Avatar"].ToString();
                        user.Sex = (SexType)reader["Sex"];
                        user.Phone = reader["Phone"].ToString();
                        user.Address = reader["Address"].ToString();
                        user.Money = (float)reader["Money"];
                        user.SellerId = (int)reader["SellerId"];
                        user.CreateTime = (DateTime)reader["CreateTime"];
                        user.Integral = (int)reader["Integral"];
                        user.LinkMan = reader["LinkMan"].ToString();
                        user.Discount = (float)reader["Discount"];
                        user.TotalRecharge = (float)reader["TotalRecharge"];
                        user.TotalConsume = (float)reader["TotalConsume"];
                        user.Status = (int)reader["Status"];
                        user.TotalLoginCount = (int)reader["TotalLoginCount"];
                        user.TotalOrdersCount = (int)reader["TotalOrdersCount"];
                        user.RegisterTime = (DateTime)reader["RegisterTime"];
                        user.LastLoginTime = (DateTime)reader["LastLoginTime"];
                        user.Remark = reader["Remark"].ToString();

                        result.Results.Add(user);
                    }

                    if (isgetcount == 1)
                    {
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
                                result.TotalCount = reader.GetInt32(0);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw;
            }
            return result;
        }


        public static PagResults<Account> GetPagAdmins(int index, int size)
        {
            var items = new PagResults<Account>();
            string cmdText = @"select * from account where roletype = ?roletype limit ?index,?size";
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?index", index));
            parameters.Add(new MySqlParameter("?size", size));
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
                        user.NickName = reader["NickName"].ToString();
                        user.Pwd = reader["Pwd"].ToString();
                        user.RoleType = (RoleType)reader["RoleType"];
                        user.Avatar = reader["Avatar"].ToString();
                        user.Sex = (SexType)reader["Sex"];
                        user.Phone = reader["Phone"].ToString();
                        user.Address = reader["Address"].ToString();
                        user.Money = (float)reader["Money"];
                        user.SellerId = (int)reader["SellerId"];
                        user.CreateTime = (DateTime)reader["CreateTime"];
                        user.Integral = (int)reader["Integral"];
                        user.LinkMan = reader["LinkMan"].ToString();
                        user.Discount = (float)reader["Discount"];
                        user.TotalRecharge = (float)reader["TotalRecharge"];
                        user.TotalConsume = (float)reader["TotalConsume"];
                        user.Status = (int)reader["Status"];
                        user.TotalLoginCount = (int)reader["TotalLoginCount"];
                        user.TotalOrdersCount = (int)reader["TotalOrdersCount"];
                        user.RegisterTime = (DateTime)reader["RegisterTime"];
                        user.LastLoginTime = (DateTime)reader["LastLoginTime"];
                        user.Remark = reader["Remark"].ToString();

                        items.Results.Add(user);

                        //一个函数有两次连接数据库 先把连接断开 然后重连
                        conn.Close();
                        conn.Dispose();
                        conn.Open();

                        cmdText = @"select count(*) from account where roletype = " + RoleType.SuperManage;
                        reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText);
                        if (reader.HasRows)
                        {
                            if (reader.Read())
                            {
                                items.TotalCount = reader.GetInt32(0);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw;
            }

            return items;
        }

        public static IList<Account> GetUserList(IList<int> uids)
        {
            IList<Account> list = new List<Account>();
            if (uids.Count < 1)
                return list;
            

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
                        user.NickName = reader["NickName"].ToString();
                        user.Pwd = reader["Pwd"].ToString();
                        user.RoleType = (RoleType)reader["RoleType"];
                        user.Avatar = reader["Avatar"].ToString();
                        user.Sex = (SexType)reader["Sex"];
                        user.Phone = reader["Phone"].ToString();
                        user.Address = reader["Address"].ToString();
                        user.Money = (float)reader["Money"];
                        user.SellerId = (int)reader["SellerId"];
                        user.CreateTime = (DateTime)reader["CreateTime"];
                        user.Integral = (int)reader["Integral"];
                        user.LinkMan = reader["LinkMan"].ToString();
                        user.Discount = (float)reader["Discount"];
                        user.TotalRecharge = (float)reader["TotalRecharge"];
                        user.TotalConsume = (float)reader["TotalConsume"];
                        user.Status = (int)reader["Status"];
                        user.TotalLoginCount = (int)reader["TotalLoginCount"];
                        user.TotalOrdersCount = (int)reader["TotalOrdersCount"];
                        user.RegisterTime = (DateTime)reader["RegisterTime"];
                        user.LastLoginTime = (DateTime)reader["LastLoginTime"];
                        user.Remark = reader["Remark"].ToString();

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
        public static int SaveAccount(Account account)
        {
            var cmdText = String.Empty;
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            if (account.Id > 0)
            {
                cmdText = @"UPDATE account SET
                                        UserName        = ?UserName,
                                        NickName        = ?NickName,
                                        Pwd             = ?Pwd,
                                        SellerId          = ?SellerId,
                                        RoleType        = ?RoleType,
                                        Avatar          = ?Avatar,
                                        Sex             = ?Sex,
                                        LinkMan             = ?LinkMan,
                                        Phone             = ?Phone,
                                        Address        = ?Address,
                                        Money             = ?Money,
                                        Integral             = ?Integral,
                                        CreateTime      = ?CreateTime,
                                        RegisterTime          = ?RegisterTime  ,  
                                        Status                = ?Status     ,     
                                        Discount              = ?Discount   ,     
                                        TotalRecharge         = ?TotalRecharge   ,
                                        TotalConsume          = ?TotalConsume    ,
                                        TotalLoginCount       = ?TotalLoginCount ,
                                        TotalOrdersCount      = ?TotalOrdersCount,
                                        LastLoginTime      = ?LastLoginTime,
                                        Remark         = ?Remark   
                                    WHERE
                                        Id = ?Id";
                parameters.Add(new MySqlParameter("?Id", account.Id));
                parameters.Add(new MySqlParameter("?UserName", account.UserName));
                parameters.Add(new MySqlParameter("?NickName", account.NickName));
                parameters.Add(new MySqlParameter("?Pwd", account.Pwd));
                parameters.Add(new MySqlParameter("?RoleType", account.RoleType));
                parameters.Add(new MySqlParameter("?Avatar", account.Avatar));
                parameters.Add(new MySqlParameter("?Sex", account.Sex));
                parameters.Add(new MySqlParameter("?CreateTime", account.CreateTime));
                parameters.Add(new MySqlParameter("?Phone", account.Phone));
                parameters.Add(new MySqlParameter("?Address", account.Address));
                parameters.Add(new MySqlParameter("?Money", account.Money));
                parameters.Add(new MySqlParameter("?Integral", account.Integral));
                parameters.Add(new MySqlParameter("?LinkMan", account.LinkMan));
                parameters.Add(new MySqlParameter("?SellerId", account.SellerId));
                parameters.Add(new MySqlParameter("?RegisterTime", account.RegisterTime));
                parameters.Add(new MySqlParameter("?Status", account.Status));
                parameters.Add(new MySqlParameter("?Discount", account.Discount));
                parameters.Add(new MySqlParameter("?TotalRecharge", account.TotalRecharge));
                parameters.Add(new MySqlParameter("?TotalConsume", account.TotalConsume));
                parameters.Add(new MySqlParameter("?TotalLoginCount", account.TotalLoginCount));
                parameters.Add(new MySqlParameter("?TotalOrdersCount", account.TotalOrdersCount));
                parameters.Add(new MySqlParameter("?LastLoginTime", account.LastLoginTime));
                parameters.Add(new MySqlParameter("?Remark", account.Remark));
            }
            else
            {
                cmdText = @"insert into account
                                        (
                                        UserName   ,
                                        NickName   ,
                                        Pwd        ,
                                        RoleType   ,
                                        Avatar     ,
                                        Sex        ,
                                        Phone        ,
                                        Address   ,
                                        SellerId     ,
                                        Money        ,
                                        Integral        ,
                                        LinkMan        ,
                                        RegisterTime           ,
                                        Status                 ,
                                        Discount               ,
                                        TotalRecharge          ,
                                        TotalConsume           ,
                                        TotalLoginCount        ,
                                        TotalOrdersCount       ,
                                        LastLoginTime          ,
                                        Remark          ,
                                        CreateTime 
                                        ) 
                                        values
                                        (
                                        ?UserName  ,
                                        ?NickName  ,
                                        ?Pwd       ,
                                        ?RoleType  ,
                                        ?Avatar    ,
                                        ?Sex       ,
                                        ?Phone       ,
                                        ?Address  ,
                                        ?SellerId    ,
                                        ?Money       ,
                                        ?Integral       ,
                                        ?LinkMan       ,
                                        ?RegisterTime           ,
                                        ?Status                 ,
                                        ?Discount               ,
                                        ?TotalRecharge          ,
                                        ?TotalConsume           ,
                                        ?TotalLoginCount        ,
                                        ?TotalOrdersCount       ,
                                        ?LastLoginTime          ,
                                        ?Remark          ,
                                        ?CreateTime
                                        )";
                parameters.Add(new MySqlParameter("?UserName", account.UserName));
                parameters.Add(new MySqlParameter("?NickName", account.NickName));
                parameters.Add(new MySqlParameter("?Pwd", account.Pwd));
                parameters.Add(new MySqlParameter("?RoleType", account.RoleType));
                parameters.Add(new MySqlParameter("?Avatar", account.Avatar));
                parameters.Add(new MySqlParameter("?Sex", account.Sex));
                parameters.Add(new MySqlParameter("?CreateTime", account.CreateTime));
                parameters.Add(new MySqlParameter("?Phone", account.Phone));
                parameters.Add(new MySqlParameter("?Address", account.Address));
                parameters.Add(new MySqlParameter("?Money", account.Money));
                parameters.Add(new MySqlParameter("?SellerId", account.SellerId));
                parameters.Add(new MySqlParameter("?Integral", account.Integral));
                parameters.Add(new MySqlParameter("?LinkMan", account.LinkMan));
                parameters.Add(new MySqlParameter("?RegisterTime", account.RegisterTime));
                parameters.Add(new MySqlParameter("?Status", account.Status));
                parameters.Add(new MySqlParameter("?Discount", account.Discount));
                parameters.Add(new MySqlParameter("?TotalRecharge", account.TotalRecharge));
                parameters.Add(new MySqlParameter("?TotalConsume", account.TotalConsume));
                parameters.Add(new MySqlParameter("?TotalLoginCount", account.TotalLoginCount));
                parameters.Add(new MySqlParameter("?TotalOrdersCount", account.TotalOrdersCount));
                parameters.Add(new MySqlParameter("?LastLoginTime", account.LastLoginTime));
                parameters.Add(new MySqlParameter("?Remark", account.Remark));
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

        /// <summary>
        /// 删除用户 修改状态 （账户+绑定账户）
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static int DelUser(int id)
        {
            var cmdText = String.Format("update account set status = -1 where Id={0}", id);
            cmdText += String.Format("update AccountBinding set status = -1 where Id={0}", id);

            try
            {
                return MySqlHelper.ExecuteNonQuery(Utility._gameDbConn, CommandType.Text, cmdText);
            }
            catch (Exception ex)
            {
                return 0;
            }
        }

        /// <summary>
        /// 删除用户 修改状态 （账户+绑定账户）
        /// </summary>
        /// <param name="ids"></param>
        /// <returns></returns>
        public static bool DelUserList(List<int> ids)
        {
            var cmdText = new StringBuilder("");
            foreach (var id in ids)
            {
                cmdText = cmdText.AppendFormat("update account set status = -1 where Id={0};", id);
                cmdText = cmdText.AppendFormat("update AccountBinding set status = -1 where Id={0};", id);
            }
            var cmdsql = cmdText.ToString();
            try
            {
                return MySqlHelper.ExecuteNonQuery(Utility._gameDbConn, CommandType.Text, cmdsql) > 0;
            }
            catch (Exception ex)
            {
                return false;
            }
        }


        public static Account FindUserByPhone(string phone,int sellerId)
        {
            var sql = String.Format("select * from account where Phone='{0}' and SellerId={1} and Status=0 limit 1;", phone,sellerId);
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
                            user.NickName = reader["NickName"].ToString();
                            user.Pwd = reader["Pwd"].ToString();
                            user.RoleType = (RoleType)reader["RoleType"];
                            user.Avatar = reader["Avatar"].ToString();
                            user.Sex = (SexType)reader["Sex"];
                            user.Phone = reader["Phone"].ToString();
                            user.Address = reader["Address"].ToString();
                            user.Money = (float)reader["Money"];
                            user.SellerId = (int)reader["SellerId"];
                            user.CreateTime = (DateTime)reader["CreateTime"];
                            user.Integral = (int)reader["Integral"];
                            user.LinkMan = reader["LinkMan"].ToString();
                            user.Discount = (float)reader["Discount"];
                            user.TotalRecharge = (float)reader["TotalRecharge"];
                            user.TotalConsume = (float)reader["TotalConsume"];
                            user.Status = (int)reader["Status"];
                            user.TotalLoginCount = (int)reader["TotalLoginCount"];
                            user.TotalOrdersCount = (int)reader["TotalOrdersCount"];
                            user.RegisterTime = (DateTime)reader["RegisterTime"];
                            user.LastLoginTime = (DateTime)reader["LastLoginTime"];
                            user.Remark = reader["Remark"].ToString();
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
            var sql = String.Format("select * from account where Id={0} and status=0 limit 1;", id);
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
                            user.NickName = reader["NickName"].ToString();
                            user.Pwd = reader["Pwd"].ToString();
                            user.RoleType = (RoleType)reader["RoleType"];
                            user.Avatar = reader["Avatar"].ToString();
                            user.Sex = (SexType)reader["Sex"];
                            user.Phone = reader["Phone"].ToString();
                            user.Address = reader["Address"].ToString();
                            user.Money = (float)reader["Money"];
                            user.SellerId = (int)reader["SellerId"]; ;
                            user.CreateTime = (DateTime)reader["CreateTime"];
                            user.Integral = (int)reader["Integral"];
                            user.LinkMan = reader["LinkMan"].ToString();
                            user.Discount = (float)reader["Discount"];
                            user.TotalRecharge = (float)reader["TotalRecharge"];
                            user.TotalConsume = (float)reader["TotalConsume"];
                            user.Status = (int)reader["Status"];
                            user.TotalLoginCount = (int)reader["TotalLoginCount"];
                            user.TotalOrdersCount = (int)reader["TotalOrdersCount"];
                            user.RegisterTime = (DateTime)reader["RegisterTime"];
                            user.LastLoginTime = (DateTime)reader["LastLoginTime"];
                            user.Remark = reader["Remark"].ToString();
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

        public static Account GetUserByPhone(string phone, int sellerid)
        {
            var sql = String.Format("select * from account where phone={0} and sellerid={1} limit 1;", phone, sellerid);
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
                            user.NickName = reader["NickName"].ToString();
                            user.Pwd = reader["Pwd"].ToString();
                            user.RoleType = (RoleType)reader["RoleType"];
                            user.Avatar = reader["Avatar"].ToString();
                            user.Sex = (SexType)reader["Sex"];
                            user.Phone = reader["Phone"].ToString();
                            user.Address = reader["Address"].ToString();
                            user.Money = (float)reader["Money"];
                            user.SellerId = (int)reader["SellerId"]; ;
                            user.CreateTime = (DateTime)reader["CreateTime"];
                            user.Integral = (int)reader["Integral"];
                            user.LinkMan = reader["LinkMan"].ToString();
                            user.Discount = (float)reader["Discount"];
                            user.TotalRecharge = (float)reader["TotalRecharge"];
                            user.TotalConsume = (float)reader["TotalConsume"];
                            user.Status = (int)reader["Status"];
                            user.TotalLoginCount = (int)reader["TotalLoginCount"];
                            user.TotalOrdersCount = (int)reader["TotalOrdersCount"];
                            user.RegisterTime = (DateTime)reader["RegisterTime"];
                            user.LastLoginTime = (DateTime)reader["LastLoginTime"];
                            user.Remark = reader["Remark"].ToString();
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
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, sql, parameters.ToArray());
                    if (reader.HasRows)
                    {
                        if (reader.Read())
                        {
                            Account user = new Account();
                            user.Id = reader.GetInt32(0);
                            user.UserName = reader["UserName"].ToString();
                            user.NickName = reader["NickName"].ToString();
                            user.Pwd = reader["Pwd"].ToString();
                            user.RoleType = (RoleType)reader["RoleType"];
                            user.Avatar = reader["Avatar"].ToString();
                            user.Sex = (SexType)reader["Sex"];
                            user.Phone = reader["Phone"].ToString();
                            user.Address = reader["Address"].ToString();
                            user.Money = (float)reader["Money"];
                            user.SellerId = (int)reader["SellerId"]; ;
                            user.CreateTime = (DateTime)reader["CreateTime"];
                            user.Integral = (int)reader["Integral"];
                            user.LinkMan = reader["LinkMan"].ToString();
                            user.Discount = (float)reader["Discount"];
                            user.TotalRecharge = (float)reader["TotalRecharge"];
                            user.TotalConsume = (float)reader["TotalConsume"];
                            user.Status = (int)reader["Status"];
                            user.TotalLoginCount = (int)reader["TotalLoginCount"];
                            user.TotalOrdersCount = (int)reader["TotalOrdersCount"];
                            user.RegisterTime = (DateTime)reader["RegisterTime"];
                            user.LastLoginTime = (DateTime)reader["LastLoginTime"];
                            user.Remark = reader["Remark"].ToString();
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

        public static bool JudgeUser(string phone, string username,int sellerId)
        {
            var sql = @"select * from account where sellerId=?sellerId and (username=?username or phone=?phone) limit 1;";
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?username", username));
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

        public static bool JudgeUserLogin(string phone, string password, int sellerId)
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