using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Security.Principal;
using System.Text;
using System.Web;
using System.Web.Security;
using Backstage.Core.Entity;
using MySql.Data.MySqlClient;

namespace Backstage.Core
{
    public static class Utility
    {
        public static string _gameDbConn = System.Configuration.ConfigurationManager.AppSettings["gamedbconn"];//帐号db
        public static string _gameConn = System.Configuration.ConfigurationManager.AppSettings["gameconn"];//游戏db
        public static string _loginUrl = System.Configuration.ConfigurationManager.AppSettings["loginurl"];//游戏后台登录地址
        public static string _indexUrl = System.Configuration.ConfigurationManager.AppSettings["indexurl"];//游戏后台首地址地址
        public static string _reloadUrls = System.Configuration.ConfigurationManager.AppSettings["reloadurls"];//跳转地址列表
        public static string _accountId = System.Configuration.ConfigurationManager.AppSettings["accountid"];

        public static string _ledou_secret = System.Configuration.ConfigurationManager.AppSettings["ledou_secret"];//跳转地址列表

        public static Account FindUser(string userName)
        {
            var sql = string.Format("select * from account where username='{0}' limit 1;", userName);
            try
            {
                MySqlDataReader reader = MySqlHelper.ExecuteReader(_gameDbConn, CommandType.Text, sql);
                if (reader.HasRows)
                {
                    if (reader.Read())
                    {
                        Account user = new Account();
                        user.Id = reader.GetInt32(0);
                        user.UserName = reader.GetString(1);
                        user.Pwd = reader.GetString(2);
                        user.RoleType = (RoleType)reader.GetInt32(3);
                        //user.Servers = reader["ServerList"].ToString().Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries).Select(p => Convert.ToInt32(p)).ToList();
                        return user;
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
        /// 根据基本信息构成实体
        /// </summary>
        /// <param name="str"></param>
        /// <returns></returns>
        private static Account GetEntityFromString(string str)
        {
            if (string.IsNullOrEmpty(str))
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
            return string.Format("{0}^{1}^{2}",
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
            if (!string.IsNullOrEmpty(FormsAuthentication.CookieDomain))
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
            if (!string.IsNullOrEmpty(FormsAuthentication.CookieDomain))
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
            var userData = string.Empty;
            if (context == null)
                return null;

            var cookie = context.Request.Cookies[FormsAuthentication.FormsCookieName];
            if (cookie == null || string.IsNullOrEmpty(cookie.Value))
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
                userData = string.Empty;
            }

            if (userId == 0)
                return null;
            return GetEntityFromString(userData);
        }

        public static DataTable GetGameServerList()
        {
            var sql = "select * from c_serverlist";
            return MySqlHelper.ExecuteDataset(_gameDbConn, CommandType.Text, sql).Tables[0];
        }

        /// <summary>
        /// 获取一个已连接的连接串
        /// </summary>
        /// <param name="strConn">连接串</param>
        /// <returns></returns>
        public static IDbConnection ObtainConn(string strConn)
        {
            using (MySqlConnection conn = new MySqlConnection(strConn))
            {
                try
                {
                    conn.Open();
                }
                catch
                {
                    conn.Close();
                    throw;
                }
                return conn;
            }
        }

        /// <summary>
        /// 查看用户是否有权限
        /// </summary>
        /// <param name="needRoleType"></param>
        /// <returns></returns>
        public static bool HasAuthority(RoleType needRoleType)
        {
            Account curUser = GetCurUser();
            if (curUser == null) return false;
            if (curUser.RoleType == RoleType.SuperManage || needRoleType == RoleType.User) return true;
            else if (needRoleType == RoleType.SuperManage) return false;
            return true;
        }


        public static DataTable servers;

        public static DataTable Servers
        {
            get
            {
                if (servers == null) servers = GetGameServerList();
                return servers;
            }
        }

        public static string ServerConn(int serverId)
        {
            if (Servers.Select(string.Format("serverid={0}", serverId)).Count() == 0) return null;
            return Servers.Select(string.Format("serverid={0}", serverId))[0]["GameConn"].ToString();
        }


        #region unix时间
        private const long UnixEpoch = 621355968000000000L;
        /// <summary>
        /// Unix时间原点
        /// </summary>
        public static readonly DateTime UnixEpochDateTime = new DateTime(UnixEpoch, DateTimeKind.Utc);

        private const long TicksPerMs = TimeSpan.TicksPerSecond / 1000;

        /// <summary>
        /// DateTime转化成Unix时间
        /// </summary>
        /// <param name="dateTime">本地时间</param>
        /// <returns>unix时间</returns>
        public static long ToUnixTime(this DateTime dateTime)
        {
            var epoch = (dateTime.ToUniversalTime().Ticks - UnixEpoch) / TimeSpan.TicksPerSecond;
            return epoch;
        }

        /// <summary>
        /// Unix时间转成DateTime
        /// </summary>
        /// <param name="unixTime">unix时间</param>
        /// <returns>本地时间</returns>
        public static DateTime FromUnixTime(this double unixTime)
        {
            return (UnixEpochDateTime + TimeSpan.FromSeconds(unixTime)).ToLocalTime();
        }

        /// <summary>
        /// Unix时间转成DateTime
        /// </summary>
        /// <param name="unixTime">unix时间</param>
        /// <returns>本地时间</returns>
        public static DateTime FromUnixTime(this long unixTime)
        {
            return (UnixEpochDateTime + TimeSpan.FromSeconds(unixTime)).ToLocalTime();
        }

        /// <summary>
        /// 该时间距离当前时间还有多少秒
        /// </summary>
        public static int ToTs(this DateTime dateTime)
        {
            if (dateTime <= DateTime.Now) return 0;
            return (int)Math.Ceiling(dateTime.Subtract(DateTime.Now).TotalSeconds);
        }
        #endregion

        #region 生成随机数字
        private static Random random = new Random();

        /// <summary>
        /// 生成随机数字[min,max)
        /// </summary>
        /// <param name="min">返回的最小值</param>
        /// <param name="max">返回的最大值</param>
        /// <returns></returns>
        public static int GetRandom(int min, int max)
        {
            lock (random)
            {
                return random.Next(min, max);
            }
        }

        /// <summary>
        /// 生成1-100的随机数[1,101)
        /// </summary>
        /// <returns></returns>
        public static int GetRandom()
        {
            lock (random)
            {
                return random.Next(1, 101);
            }
        }
        #endregion

        #region  MD5加密
        /// <summary>
        /// 标准MD5加密
        /// </summary>
        /// <param Name="source">待加密字符串</param>
        /// <param Name="addKey">附加字符串</param>
        /// <param Name="encoding">编码方式</param>
        /// <returns></returns>
        public static string MD5_Encrypt(string source, string addKey, Encoding encoding)
        {
            if (addKey.Length > 0)
            {
                source = source + addKey;
            }

            MD5 MD5 = new MD5CryptoServiceProvider();
            byte[] datSource = encoding.GetBytes(source);
            byte[] newSource = MD5.ComputeHash(datSource);
            string byte2String = null;
            for (int i = 0; i < newSource.Length; i++)
            {
                string thisByte = newSource[i].ToString("x");
                if (thisByte.Length == 1) thisByte = "0" + thisByte;
                byte2String += thisByte;
            }
            return byte2String;
        }

        /// <summary>
        /// 标准MD5加密
        /// </summary>
        /// <param Name="source">待加密字符串</param>
        /// <param Name="encoding">编码方式</param>
        /// <returns></returns>
        public static string MD5_Encrypt(string source, string encoding)
        {
            return MD5_Encrypt(source, string.Empty, Encoding.GetEncoding(encoding));
        }
        /// <summary>
        /// 标准MD5加密
        /// </summary>
        /// <param Name="source">被加密的字符串</param>
        /// <returns></returns>
        public static string MD5_Encrypt(string source)
        {
            return MD5_Encrypt(source, string.Empty, Encoding.UTF8);
        }
        public static byte[] MD5_Encrypt(byte[] source)
        {
            MD5 MD5 = new MD5CryptoServiceProvider();
            byte[] datSource = source;
            return MD5.ComputeHash(datSource);
        }

        #endregion

        #region 是否是整数
        public static bool IsNum(string str)
        {
            if (string.IsNullOrEmpty(str)) return false;
            for (int i = 0; i < str.Length; i++)
            {
                if (str[i] < '0' || str[i] > '9')
                    return false;
            }
            return true;
        }
        #endregion

        #region 获取加密字符串

        public static string GetWaitMd5Str(string date, string apiname, List<string> paramstrs)
        {
            string str = date +"+"+apiname+"+";
            foreach (var paramstr in paramstrs)
            {
                str += paramstr + "+";
            }
            str = str.TrimEnd('+');
            return str;
        }
        #endregion
    }
}