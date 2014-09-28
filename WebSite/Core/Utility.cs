using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.NetworkInformation;
using System.Net.Security;
using System.Net.Sockets;
using System.Security.Cryptography;
using System.Security.Cryptography.X509Certificates;
using System.Security.Principal;
using System.Text;
using System.Web;
using System.Web.Security;
using Backstage.Core.Entity;
using Backstage.Core.Logic;
using log4net;
using MySql.Data.MySqlClient;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace Backstage.Core
{
    public static class Utility
    {
        private static ILog logger = LogManager.GetLogger("Utility");
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
        public static string _app_id = System.Configuration.ConfigurationManager.AppSettings["app_id"];//找回密码信息格式
        public static string _app_secret = System.Configuration.ConfigurationManager.AppSettings["app_secret"];//账号名
        public static string _msg_password = System.Configuration.ConfigurationManager.AppSettings["msg_password"];//密码
        public static string _msg_sms_type = System.Configuration.ConfigurationManager.AppSettings["msg_sms_type"];//通道ID
        public static string _msg_opensend = System.Configuration.ConfigurationManager.AppSettings["msg_opensend"];//是否开启短信发送验证码
        public static string _userdefaulthead = System.Configuration.ConfigurationManager.AppSettings["userdefaulthead"];//用户默认头像
        public static string _domainurl = System.Configuration.ConfigurationManager.AppSettings["domainurl"];//域名头
        public static string _onlydomainurl = System.Configuration.ConfigurationManager.AppSettings["onlydomainurl"];//域名头
        public static string _3vurl = System.Configuration.ConfigurationManager.AppSettings["3vurl"];//3V平台官网


        //apikey（管理中心系统集成里）
        public static string _machine_apikey = System.Configuration.ConfigurationManager.AppSettings["machine_apikey"];
        //用户id（管理中心系统集成里 http://my.10ss.net/index.php?a=Apisystem）
        public static string _machine_partner = System.Configuration.ConfigurationManager.AppSettings["machine_partner"];
        //machine_apiurl（易联接口请求地址）
        public static string _machine_apiip = System.Configuration.ConfigurationManager.AppSettings["machine_apiip"];
        public static string _machine_apiport = System.Configuration.ConfigurationManager.AppSettings["machine_apiport"];
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
                if (string.IsNullOrEmpty(str)) return new List<int>();
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
                if (string.IsNullOrEmpty(str)) return new List<float>();
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
                if (string.IsNullOrEmpty(str)) return new List<string>();
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
        /// 获取用户头像信息
        /// </summary>
        /// <returns></returns>
        public static string GetAvatar(HttpContext context, int uid, string avatar)
        {
            var dirPath = context.Server.MapPath(string.Format("../../File/{0}/image/", uid));
            if (!Directory.Exists(dirPath))
            {
                Directory.CreateDirectory(dirPath);
            }
            Base64StringToImage(avatar, dirPath + "head");
            avatar = _domainurl + "/File/" + uid + "/image/head.jpg";
            return avatar;
        }
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
                Bitmap tempbmp = new Bitmap(ms);
                Bitmap bmp = new Bitmap(tempbmp);
                tempbmp.Dispose();

                bmp.Save(folderUrl + ".jpg", System.Drawing.Imaging.ImageFormat.Jpeg);
            }
            catch (Exception ex)
            {
                logger.ErrorFormat(ex.Message);
                logger.ErrorFormat(ex.InnerException.Message);
                throw ex;
            }
        }
        #endregion

        #region 获取不同分辨率的图片地址
        /// <summary>
        /// 获取不同分辨率的图片地址
        /// </summary>
        /// <param name="url"></param>
        /// <param name="width"></param>
        /// <param name="height"></param>
        /// <param name="context"></param>
        /// <param name="needcheck">是否生成图片</param>
        /// <returns></returns>
        public static string GetSizePicUrl(string url, int width, int height, HttpContext context = null, int needcheck = 1)
        {
            url = GetPhoneNeedUrl(url);
            var index = url.LastIndexOf('.');
            if (index < 0) return url;
            var result = url.Substring(0, index) + "_" + width + "x" + height + url.Substring(index);
            if (needcheck == 1)
            {
                //获取图片情况下 需检查图片是否存在
                var isExist = false;
                try
                {
                    Ping ping = new Ping();
                    PingReply reply = ping.Send(result);
                    if (reply != null && reply.Status.Equals(IPStatus.Success))
                    {
                        //可以访问
                        isExist = true;
                    }
                }
                catch (Exception)
                {
                    isExist = false;
                }

                if (!isExist)
                {
                    //不存在图片 按照原始图片 生成新的尺寸图片
                    var alist = url.Split(new char[] { '/' }, StringSplitOptions.RemoveEmptyEntries);
                    var i = 0;
                    foreach (var s in alist)
                    {
                        if (s == "File" || s == "file")
                        {
                            break;
                        }
                        i++;
                    }
                    var filePath = "../../File/";
                    for (int j = i + 1; j < alist.Count(); j++)
                    {
                        filePath += alist[j] + "/";
                    }
                    filePath = filePath.TrimEnd("/".ToCharArray());

                    if (context != null) filePath = context.Server.MapPath(filePath);
                    MakeThumNail(filePath, width, height);
                }
            }
            return result;
        }
        /// <summary>
        /// 获取不同分辨率的图片地址
        /// </summary>
        /// <param name="urllist"></param>
        /// <param name="width"></param>
        /// <param name="height"></param>
        /// <param name="context"></param>
        /// <param name="needcheck">是否生成图片</param>
        /// <returns></returns>
        public static List<string> GetSizePicUrlList(List<string> urllist, int width, int height, HttpContext context = null, int needcheck = 1)
        {
            var result = new List<string>();
            foreach (var item in urllist)
            {
                var url = GetPhoneNeedUrl(item);
                var index = url.LastIndexOf('.');
                if (index < 0) return result;
                var urlitem = url.Substring(0, index) + "_" + width + "x" + height + url.Substring(index);
                if (needcheck == 1)
                {
                    //获取图片情况下 需检查图片是否存在
                    var isExist = false;
                    try
                    {
                        Ping ping = new Ping();
                        PingReply reply = ping.Send(urlitem);
                        if (reply != null && reply.Status.Equals(IPStatus.Success))
                        {
                            //可以访问
                            isExist = true;
                        }
                    }
                    catch (Exception)
                    {
                        isExist = false;
                    }

                    if (!isExist)
                    {
                        //不存在图片 按照原始图片 生成新的尺寸图片
                        var alist = url.Split(new char[] { '/' }, StringSplitOptions.RemoveEmptyEntries);
                        var i = 0;
                        foreach (var s in alist)
                        {
                            if (s == "File" || s == "file")
                            {
                                break;
                            }
                            i++;
                        }
                        var filePath = "../../File/";
                        for (int j = i + 1; j < alist.Count(); j++)
                        {
                            filePath += alist[j] + "/";
                        }
                        filePath = filePath.TrimEnd("/".ToCharArray());

                        if (context != null) filePath = context.Server.MapPath(filePath);
                        MakeThumNail(filePath, width, height);
                    }
                }
                result.Add(urlitem);
            }
            return result;
        }
        #endregion

        #region 发送短信
        public class SendSmsResponse
        {
            public string identifier { get; set; }
            public string res_code { get; set; }
            public string res_message { get; set; }
        }
        /// <summary>
        /// 发送短信
        /// </summary>
        /// <param name="mobile"></param>
        /// <param name="templeId"></param>
        /// <param name="jsobject"></param>
        /// <returns></returns>
        public static string SendMsg(string mobile, MsgTempleId templeId, object jsobject)
        {
            var access_token = GetAccessToken();
            if (access_token == string.Empty) return "获取access_token出错";

            try
            {
                string url = "http://api.189.cn/v2/emp/templateSms/sendSms";
                SortedDictionary<string, string> parameters = new SortedDictionary<string, string>();
                parameters.Add("app_id", _app_id);
                parameters.Add("access_token", access_token);
                parameters.Add("acceptor_tel", mobile);
                parameters.Add("template_id", ((int)templeId).ToString());
                parameters.Add("template_param", JsonConvert.SerializeObject(jsobject));
                parameters.Add("timestamp", open189_sign.v1.Utility.GetCurrentDate());
                string sign = open189_sign.v1.Utility.DoSignature(parameters, _app_secret);
                parameters.Add("sign", sign);
                HttpWebResponse response = CreatePostHttpResponse(url, parameters, null, null, Encoding.UTF8, null);
                StreamReader sr = new StreamReader(response.GetResponseStream(), Encoding.UTF8);
                string content = sr.ReadToEnd();
                var sendResponse = JsonConvert.DeserializeObject<SendSmsResponse>(content);

                if (sendResponse.res_code == "0")
                    return "发送成功";
                else return "发送短信失败";
            }
            catch (Exception ex)
            {
                return "发送短信失败";
            }
        }

        public class AccessTokenResponse
        {
            public string access_token { get; set; }
            public string expires_in { get; set; }
            public string res_code { get; set; }
            public string res_message { get; set; }
        }
        /// <summary>
        /// 令牌接口 access_token
        /// </summary>
        /// <returns></returns>
        private static string GetAccessToken()
        {
            try
            {
                string url = "https://oauth.api.189.cn/emp/oauth2/v3/access_token";
                IDictionary<string, string> parameters = new Dictionary<string, string>();
                parameters.Add("grant_type", "client_credentials");
                parameters.Add("app_id", _app_id);
                parameters.Add("app_secret", _app_secret);
                HttpWebResponse response = CreatePostHttpResponse(url, parameters, null, null, Encoding.UTF8, null);
                StreamReader sr = new StreamReader(response.GetResponseStream(), Encoding.UTF8);
                string content = sr.ReadToEnd();
                var accessTokenResponse = JsonConvert.DeserializeObject<AccessTokenResponse>(content);

                if (accessTokenResponse.res_code == "0")
                    return accessTokenResponse.access_token;
                else return string.Empty;
            }
            catch (Exception ex)
            {
                return string.Empty;
            }
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

        #region 手机端接口处理图片
        /// <summary>
        /// 获得手机端需要的图片地址
        /// </summary>
        /// <param name="url"></param>
        /// <returns></returns>
        public static string GetPhoneNeedUrl(string url)
        {
            if (url.StartsWith("/bg/File"))
                url = _onlydomainurl + url;
            return url;
        }
        public static List<string> GetPhoneNeedUrlList(List<string> urls)
        {
            var list = new List<string>();
            foreach (var url in urls)
            {
                var itemurl = "";
                if (url.StartsWith("/bg/File"))
                    itemurl = _onlydomainurl + url;
                list.Add(itemurl);
            }
            return list;
        }
        #endregion

        #region 无线打印发送
        public static bool SendOrdersMsgToPrint(Orders orders)
        {

            var merchant = MerchantHelper.GetMerchant(orders.SellerId);
            if (merchant == null) return false;
            if (string.IsNullOrEmpty(merchant.MachineCode) || string.IsNullOrEmpty(merchant.MachineKey)) return false;
            var merchanttype = MerchantTypeHelper.GetMerchantType(merchant.Mid);
            if (merchanttype == null) return false;
            StringBuilder sb = new StringBuilder(string.Empty);
            var ordertypename = orders.OrderType == OrderType.Shop ? "到店" : "送餐";

            sb.AppendFormat("【{0}】{1}\n", merchanttype.Name, ordertypename);

            sb.AppendFormat("订单号：{0}\n", orders.Id);
            sb.AppendFormat("订单类型：{0}\n", ordertypename);
            sb.AppendFormat("订单时间：{0}\n", orders.CreateTime.ToString("yyyy-MM-dd hh:mm:ss"));

            sb.Append("【收货信息】\n");
            sb.AppendFormat("联系人：{0}\n", orders.LinkMan);
            sb.AppendFormat("联系电话：{0}\n", orders.Mobile);
            sb.AppendFormat("地址：{0}\n", orders.Address);

            sb.Append("【订单详情】\n");
            sb.Append("******************************\n");
            var i = 0;
            foreach (var order in orders.GidList)
            {
                sb.AppendFormat("{0}   {1}   {2}\n", i + 1, orders.TitleList[i], orders.NumList[i]);
                i++;
            }
            sb.Append("******************************\n");
            sb.AppendFormat("总计数量：{0}\n", orders.NumList.Sum(o => o));
            sb.AppendFormat("总金额：{0}\n", orders.TotalPrice);

            sb.AppendFormat("【备注】：{0}\n", orders.Remark);

            return SendPrinterData(sb.ToString(), merchant);
        }
        public static bool SendPrinterData(string content, Merchant merchant)
        {
            try
            {
                string ss = "";
                var machine_code = merchant.MachineCode;
                var partner = _machine_partner;

                Dictionary<string, string> parameters = new Dictionary<string, string>();//加密参数列表
                parameters.Add("content", content);
                parameters.Add("machine_code", machine_code);
                parameters.Add("partner", partner);
                string sign = getMachineSign(parameters, _machine_apikey, merchant.MachineKey);
                //parameters.Add("sign", sign);
                //HttpWebResponse response = CreatePostHttpResponse(_machine_apiurl, parameters, null, null, Encoding.UTF8,
                //    null);
                //StreamReader sr = new StreamReader(response.GetResponseStream(), Encoding.UTF8);
                //string retContent = sr.ReadToEnd();
                ////var sendResponse = JsonConvert.DeserializeObject<string>(retContent);
                //var retNum = Convert.ToInt32(retContent);

                //if (retNum <= 2)
                //    return true;
                //else return false;

                string postquery = "partner={0}&sign={1}&machine_code={2}&content={3}".Replace("{0}", partner).Replace("{1}", sign).Replace("{2}", machine_code).Replace("{3}", content);

                string sendMsg = "POST / HTTP/1.1\r\n" +
                                "Host: " + _machine_apiip + ":" + _machine_apiport + "\r\n" +
                                "Content-Type: application/x-www-form-urlencoded\r\n" +
                                "Content-Length: " + postquery.Length.ToString() + "\r\n\r\n"
                                + postquery;
                //WorkerMan接口服务器，使用socket传送数据                                          
                Socket mySocket = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
                mySocket.Connect(_machine_apiip, int.Parse(_machine_apiport));




                int ctLen = Encoding.UTF8.GetBytes(postquery).Length;

                byte[] buffer = Encoding.UTF8.GetBytes(string.Format(sendMsg, _machine_apiip + ":" + _machine_apiport, ctLen, postquery));
                mySocket.Send(buffer, 0, buffer.Length, SocketFlags.None);



                //接收返回数据
                buffer = new byte[2048000];
                int n;
                MemoryStream ms = new MemoryStream();
                while ((n = mySocket.Receive(buffer, 0, buffer.Length, SocketFlags.None)) > 0)
                {
                    ms.Write(buffer, 0, n);
                    Array.Clear(buffer, 0, buffer.Length);
                }
                string result = Encoding.UTF8.GetString(ms.ToArray());
                ms.Close();
                mySocket.Shutdown(SocketShutdown.Both);
                mySocket.Close();

                //解析返回数据，取最后一行为返回数字
                string Retstr = "";
                if (!string.IsNullOrWhiteSpace(result) && result.Contains("\r\n"))
                {
                    var resAarry = result.Replace("\r\n", "@")
                        .Split(new char[] { '@' }, StringSplitOptions.RemoveEmptyEntries);
                    var res = resAarry[resAarry.Length - 1];
                    int r;
                    if (int.TryParse(res, out r))
                        Retstr = r.ToString();
                }
                switch (Retstr)
                {
                    case "1":
                        //"数据已经发送到客户端"
                        return true;
                    case "2":
                        //"数据已经发送到队列"
                        return true;
                    case "3":
                        //"没找到mac地址";
                        return false;
                    case "4":
                        //"sign不对";
                        return false;
                    default:
                        return false;
                }
            }
            catch (Exception exc)
            {
                logger.ErrorFormat("无线打印数据出错：{0}", exc.Message);
                return false;
            }
        }

        /// <summary>
        /// 创建本次调用的签名
        /// </summary>       
        /// <param name="parameters">parameters，参数列表</param>
        /// <param name="preKey">preKey，apikey的值</param>
        /// <param name="secKey">secKey，终端密钥的值</param>
        /// <returns>String，签名</returns>
        private static String getMachineSign(IDictionary<string, string> parameters, string preKey, string secKey)
        {
            // 第一步：把字典按Key的字母顺序排序
            IDictionary<string, string> sortedParams = new SortedDictionary<string, string>(parameters);
            IEnumerator<KeyValuePair<string, string>> dem = sortedParams.GetEnumerator();

            // 第二步：把所有参数名和参数值串在一起
            StringBuilder query = new StringBuilder("");
            while (dem.MoveNext())
            {
                string key = dem.Current.Key;
                string value = dem.Current.Value;
                if (!string.IsNullOrEmpty(key) && !string.IsNullOrEmpty(value))
                {
                    query.Append(key).Append(value);
                }
            }
            string source = query.ToString();
            source = preKey + source + secKey;
            //System.Console.Out.WriteLine("source:" + source);
            return System.Web.Security.FormsAuthentication.HashPasswordForStoringInConfigFile(source, "MD5").ToUpper();
            //return MD5(source);
        }
        #endregion

        # region 图片处理
        /// <summary>
        /// 缩放图像
        /// </summary>
        /// <param name="originalImagePath">图片原始路径</param>
        /// <param name="thumNailPath">保存路径</param>
        /// <param name="width">缩放图的宽</param>
        /// <param name="height">缩放图的高</param>
        /// <param name="model">缩放模式</param>
        public static void MakeThumNail(string originalImagePath, int width, int height, string model = "Cut", string thumNailPath = "")
        {
            System.Drawing.Image originalImage = System.Drawing.Image.FromFile(originalImagePath);
            if (string.IsNullOrEmpty(thumNailPath))
            {
                thumNailPath = Utility.GetSizePicUrl(originalImagePath, width, height, null, 0);
            }

            int thumWidth = width;      //缩略图的宽度
            int thumHeight = height;    //缩略图的高度
            if (height == 0) model = "W";
            if (width == 0) model = "H";

            int x = 0;
            int y = 0;

            int originalWidth = originalImage.Width;    //原始图片的宽度
            int originalHeight = originalImage.Height;  //原始图片的高度

            switch (model)
            {
                case "HW":      //指定高宽缩放,可能变形
                    break;
                case "W":       //指定宽度,高度按照比例缩放
                    thumHeight = originalImage.Height * width / originalImage.Width;
                    break;
                case "H":       //指定高度,宽度按照等比例缩放
                    thumWidth = originalImage.Width * height / originalImage.Height;
                    break;
                case "Cut":
                    if ((double)originalImage.Width / (double)originalImage.Height > (double)thumWidth / (double)thumHeight)
                    {
                        originalHeight = originalImage.Height;
                        originalWidth = originalImage.Height * thumWidth / thumHeight;
                        y = 0;
                        x = (originalImage.Width - originalWidth) / 2;
                    }
                    else
                    {
                        originalWidth = originalImage.Width;
                        originalHeight = originalWidth * height / thumWidth;
                        x = 0;
                        y = (originalImage.Height - originalHeight) / 2;
                    }
                    break;
                default:
                    break;
            }

            //新建一个bmp图片
            System.Drawing.Image bitmap = new System.Drawing.Bitmap(thumWidth, thumHeight);

            //新建一个画板
            System.Drawing.Graphics graphic = System.Drawing.Graphics.FromImage(bitmap);

            //设置高质量查值法
            graphic.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.High;

            //设置高质量，低速度呈现平滑程度
            graphic.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;

            //清空画布并以透明背景色填充
            graphic.Clear(System.Drawing.Color.Transparent);

            //在指定位置并且按指定大小绘制原图片的指定部分
            graphic.DrawImage(originalImage, new System.Drawing.Rectangle(0, 0, thumWidth, thumHeight), new System.Drawing.Rectangle(x, y, originalWidth, originalHeight), System.Drawing.GraphicsUnit.Pixel);

            try
            {
                bitmap.Save(thumNailPath, System.Drawing.Imaging.ImageFormat.Jpeg);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                originalImage.Dispose();
                bitmap.Dispose();
                graphic.Dispose();
            }
        }

        # endregion
    }
}