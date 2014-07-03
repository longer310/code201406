using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using Backstage.Core.Entity;

namespace Backstage.Core
{
    public class BasePage : Page
    {
        private Account _currentUser;
        private bool _isLogin;

        /// <summary>
        /// 可能为null，使用的时候要记得判断
        /// </summary>
        public Account CurrentUser
        {
            get { return _currentUser; }
        }

        public bool IsLogin
        {
            get { return _isLogin; }
        }

        public BasePage()
        {

        }

        /// <summary>
        /// 公用Redirect方法
        /// </summary>
        /// <param name="url"></param>
        public void Redirect(string url)
        {
            Response.Redirect(url, true);
        }

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);

            _currentUser = Utility.GetCurUser();
            _isLogin = _currentUser != null;

            if (!_isLogin)
            {
                RedirectToLoginPage();
            }
        }

        private void RedirectToLoginPage()
        {
            string url = GetRawUrl();
            if (!url.Contains("rtn") && !url.ToLower().Contains("login"))
                Redirect(Utility._loginUrl + "?rtn=" + HttpUtility.UrlEncode(url));
        }

        /// <summary>
        /// 得到原始的URL地址，如果经过Intelligencia.UrlRewriter，则返回地址栏里的URL
        /// </summary>
        /// <returns></returns>
        public string GetRawUrl()
        {
            HttpContext context = HttpContext.Current;
            if (context == null)
                return null;
            if (context.Items["UrlRewriter.NET.RawUrl"] != null)
            {
                bool isHttp = context.Items["Rewriter.HTTPS"].ToString() == "off";
                bool isDefaultPort = context.Items["Rewriter.SERVER_PORT"].ToString() == "80";
                return string.Format("http{0}://{1}{2}{3}",
                                     isHttp ? "" : "s",
                                     context.Items["Rewriter.HTTP_HOST"],
                                     isDefaultPort ? "" : ":" + context.Items["Rewriter.SERVER_PORT"],
                                     context.Items["UrlRewriter.NET.RawUrl"]
                    );
            }
            else
                return context.Request.Url.ToString();
        }

        private DataTable servers;

        protected DataTable Servers
        {
            get
            {
                if (servers == null) servers = Utility.GetGameServerList();
                return servers;
            }
        }

        protected string ServerConn(int serverId)
        {
            return Servers.Select(string.Format("serverid={0}", serverId))[0]["GameConn"].ToString();
        }

        protected string LogConn(int serverId)
        {
            return Servers.Select(string.Format("serverid={0}", serverId))[0]["GameConn"].ToString();
            //return Servers.Select(string.Format("serverid={0}", serverId))[0]["LogConn"].ToString();
        }
        protected int GetDefaultServerId()
        {
            return Convert.ToInt32(Servers.Rows[0]["serverid"]);
        }
        protected object[] GetServerForBind()
        {
            List<object> list = new List<object>();
            foreach (DataRow row in Servers.Rows)
            {
                list.Add(new object[] { row["serverid"].ToString(), row["servername"].ToString() });
            }
            return list.ToArray();
        }
        protected static bool IsNum(string str)
        {
            if (string.IsNullOrEmpty(str)) return false;
            for (int i = 0; i < str.Length; i++)
            {
                if (str[i] < '0' || str[i] > '9')
                    return false;
            }
            return true;
        }
    }
}