using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Security;
using System.Security.Cryptography;
using System.Security.Cryptography.X509Certificates;
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
        #region 配置参数
        public static string _gameDbConn = System.Configuration.ConfigurationManager.AppSettings["gamedbconn"];//帐号db
        public static string _gameConn = System.Configuration.ConfigurationManager.AppSettings["gameconn"];//游戏db
        public static string _loginUrl = System.Configuration.ConfigurationManager.AppSettings["loginurl"];//游戏后台登录地址
        public static string _indexUrl = System.Configuration.ConfigurationManager.AppSettings["indexurl"];//游戏后台首地址地址
        public static string _reloadUrls = System.Configuration.ConfigurationManager.AppSettings["reloadurls"];//跳转地址列表
        public static string _accountId = System.Configuration.ConfigurationManager.AppSettings["accountid"];

        public static string _ledou_secret = System.Configuration.ConfigurationManager.AppSettings["ledou_secret"];//跳转地址列表

        public static string _md5open = System.Configuration.ConfigurationManager.AppSettings["md5open"];//是否验证md5加密
        public static string _desopen = System.Configuration.ConfigurationManager.AppSettings["desopen"];//是否des加密返回
        public static string _register_message = System.Configuration.ConfigurationManager.AppSettings["register_message"];//注册短信格式
        public static string _modifyphone_message = System.Configuration.ConfigurationManager.AppSettings["modifyphone_message"];//注册短信格式
        public static string _message = System.Configuration.ConfigurationManager.AppSettings["message"];//注册短信格式
        public static string _msg_url = System.Configuration.ConfigurationManager.AppSettings["msg_url"];//短信请求地址
        public static string _msg_getpwd = System.Configuration.ConfigurationManager.AppSettings["msg_getpwd"];//找回密码信息格式
        public static string _msg_zh = System.Configuration.ConfigurationManager.AppSettings["msg_zh"];//账号名
        public static string _msg_mm = System.Configuration.ConfigurationManager.AppSettings["msg_mm"];//密码
        public static string _msg_sms_type = System.Configuration.ConfigurationManager.AppSettings["msg_sms_type"];//通道ID
        public static string _msg_opensend = System.Configuration.ConfigurationManager.AppSettings["msg_opensend"];//是否开启短信发送验证码
        public static string _userdefaulthead = System.Configuration.ConfigurationManager.AppSettings["userdefaulthead"];//用户默认头像
        public static string _domainurl = System.Configuration.ConfigurationManager.AppSettings["domainurl"];//域名头
        #endregion

        #region 判断是否具有权限
        /// <summary>
        /// 查看用户是否有权限
        /// </summary>
        /// <param name="needRoleType"></param>
        /// <returns></returns>
        public static bool HasAuthority(RoleType needRoleType)
        {
            Account curUser = AccountHelper.GetCurUser();
            if (curUser == null) return false;
            if (curUser.RoleType == RoleType.SuperManage || needRoleType == RoleType.Merchant) return true;
            else if (needRoleType == RoleType.SuperManage) return false;
            return true;
        }
        #endregion

        #region 返回一个开启的连接
        /// <summary>
        /// 获取一个已连接的连接串
        /// </summary>
        /// <param name="strConn">连接串</param>
        /// <returns></returns>
        public static MySqlConnection ObtainConn(string strConn)
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
        #endregion

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
        /// DateTime转化成Unix时间
        /// </summary>
        /// <param name="dateTime">本地时间</param>
        /// <returns>unix时间</returns>
        public static int GetUnixTime(this DateTime dateTime)
        {
            var epoch = (dateTime.ToUniversalTime().Ticks - UnixEpoch) / TimeSpan.TicksPerSecond;
            return (int)epoch;
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

        public static string GetVerificationCode(int num)
        {
            var str = string.Empty;
            for (int i = 0; i < num; i++)
            {
                str += GetRandom(1, 10);
            }
            return str;
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
            string str = date + "+" + apiname + "+";
            foreach (var paramstr in paramstrs)
            {
                str += paramstr + "+";
            }
            str = str.TrimEnd('+');
            return str;
        }
        #endregion

        #region 字符串与数组的转换

        public static int GetValueByList(List<int> li, List<int> mi, int value)
        {
            if (li.Count != mi.Count) return 0;
            for (int i = 0; i < li.Count; i++)
            {
                if (li[i] == value)
                    return mi[i];
            }
            return 0;
        }
        public static List<int> GetListint(string str)
        {
            try
            {
                return str.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries).Select(p => Convert.ToInt32(p)).ToList();
            }
            catch (Exception)
            {
                return new List<int>();
            }
        }
        public static List<float> GetListfloat(string str)
        {
            try
            {
                return str.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries).Select(p => float.Parse(p)).ToList();
            }
            catch (Exception)
            {
                return new List<float>();
            }
        }
        public static List<string> GetListstring(string str)
        {
            try
            {
                return str.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries).ToList();
            }
            catch (Exception)
            {
                return new List<string>();
            }
        }

        public static string GetString(List<int> list)
        {
            list = list.OrderBy(o => o).ToList();//升序排列 很重要 关系到查找！
            return String.Join(",", list.ConvertAll<string>(new Converter<int, string>(m => m.ToString())).ToArray());
        }

        public static string GetString(List<string> list)
        {
            return String.Join(",", list.ConvertAll<string>(new Converter<string, string>(m => m.ToString())).ToArray());
        }

        public static string GetString(List<float> list)
        {
            return String.Join(",", list.ConvertAll<string>(new Converter<float, string>(m => m.ToString())).ToArray());
        }
        public static string GetWhereSql(List<int> idlist, string columnname = "Id")
        {
            if (idlist == null || idlist.Count == 0) return string.Empty;
            string wheresql = "";
            string str = String.Join(",", idlist.ConvertAll<string>(new Converter<int, string>(m => m.ToString())).ToArray());
            str = str.TrimEnd(',');
            wheresql += string.Format(" where {0} in(", columnname) + str + ") ";

            return wheresql;
        }
        #endregion

        #region 图片字符串转换
        /// <summary>
        /// /图片 转为    base64编码的文本  
        /// </summary>
        /// <param name="Imagefilename"></param>
        private static string ImgToBase64String(string Imagefilename)
        {
            try
            {
                Bitmap bmp = new Bitmap(Imagefilename);
                FileStream fs = new FileStream(Imagefilename + ".txt", FileMode.Create);
                StreamWriter sw = new StreamWriter(fs);

                MemoryStream ms = new MemoryStream();
                bmp.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg);
                byte[] arr = new byte[ms.Length];
                ms.Position = 0;
                ms.Read(arr, 0, (int)ms.Length);
                ms.Close();
                String strbaser64 = Convert.ToBase64String(arr);
                return strbaser64;
            }
            catch (Exception ex)
            {
                throw;
            }
        }
        //base64编码的文本 转为    图片  
        public static void Base64StringToImage(string base64Str, string folderUrl)
        {
            try
            {
                byte[] arr = Convert.FromBase64String(base64Str);
                MemoryStream ms = new MemoryStream(arr);
                Bitmap bmp = new Bitmap(ms);

                bmp.Save(folderUrl + ".jpg", System.Drawing.Imaging.ImageFormat.Jpeg);
            }
            catch (Exception ex)
            {
                throw;
            }
        }
        #endregion

        #region 发送短信
        /// <summary>
        /// 发送短信
        /// </summary>
        /// <param name="code"></param>
        /// <param name="phone"></param>
        /// <param name="message"></param>
        public static void SendMsg(string code, string phone, string message)
        {
            string msg = string.Format(message, code);
            Encoding encoding = Encoding.GetEncoding("UTF-8");
            IDictionary<string, string> parameters = new Dictionary<string, string>();
            parameters.Add("zh", _msg_zh);
            parameters.Add("mm", _msg_mm);
            parameters.Add("hm", phone);
            parameters.Add("nr", msg);
            parameters.Add("sms_type", _msg_sms_type);
            CreatePostHttpResponse(_msg_url, parameters, null, null, encoding, null);
        }


        private static readonly string DefaultUserAgent = "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.2; SV1; .NET CLR 1.1.4322; .NET CLR 2.0.50727)";
        private static bool CheckValidationResult(object sender, X509Certificate certificate, X509Chain chain, SslPolicyErrors errors)
        {
            return true; //总是接受  
        }
        /// <summary>  
        /// 创建POST方式的HTTP请求  
        /// </summary>  
        /// <param name="url">请求的URL</param>  
        /// <param name="parameters">随同请求POST的参数名称及参数值字典</param>  
        /// <param name="timeout">请求的超时时间</param>  
        /// <param name="userAgent">请求的客户端浏览器信息，可以为空</param>  
        /// <param name="requestEncoding">发送HTTP请求时所用的编码</param>  
        /// <param name="cookies">随同HTTP请求发送的Cookie信息，如果不需要身份验证可以为空</param>  
        /// <returns></returns>  
        public static HttpWebResponse CreatePostHttpResponse(string url, IDictionary<string, string> parameters, int? timeout, string userAgent, Encoding requestEncoding, CookieCollection cookies)
        {
            if (string.IsNullOrEmpty(url))
            {
                throw new ArgumentNullException("url");
            }
            if (requestEncoding == null)
            {
                throw new ArgumentNullException("requestEncoding");
            }
            HttpWebRequest request = null;
            //如果是发送HTTPS请求  
            if (url.StartsWith("https", StringComparison.OrdinalIgnoreCase))
            {
                ServicePointManager.ServerCertificateValidationCallback = new RemoteCertificateValidationCallback(CheckValidationResult);
                request = WebRequest.Create(url) as HttpWebRequest;
                request.ProtocolVersion = HttpVersion.Version10;
            }
            else
            {
                request = WebRequest.Create(url) as HttpWebRequest;
            }
            request.Method = "POST";
            request.ContentType = "application/x-www-form-urlencoded";

            if (!string.IsNullOrEmpty(userAgent))
            {
                request.UserAgent = userAgent;
            }
            else
            {
                request.UserAgent = DefaultUserAgent;
            }

            if (timeout.HasValue)
            {
                request.Timeout = timeout.Value;
            }
            if (cookies != null)
            {
                request.CookieContainer = new CookieContainer();
                request.CookieContainer.Add(cookies);
            }
            //如果需要POST数据  
            if (!(parameters == null || parameters.Count == 0))
            {
                StringBuilder buffer = new StringBuilder();
                int i = 0;
                foreach (string key in parameters.Keys)
                {
                    if (i > 0)
                    {
                        buffer.AppendFormat("&{0}={1}", key, parameters[key]);
                    }
                    else
                    {
                        buffer.AppendFormat("{0}={1}", key, parameters[key]);
                    }
                    i++;
                }
                byte[] data = requestEncoding.GetBytes(buffer.ToString());
                using (Stream stream = request.GetRequestStream())
                {
                    stream.Write(data, 0, data.Length);
                }
            }
            return request.GetResponse() as HttpWebResponse;
        }
        #endregion
    }
}