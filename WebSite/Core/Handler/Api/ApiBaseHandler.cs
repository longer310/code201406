using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;
using Newtonsoft.Json;

namespace Backstage.Core
{
    /// <summary>
    ///BaseHandler 的摘要说明
    /// </summary>
    public class BaseApiHandler : IRequiresSessionState, IHttpHandler
    {
        protected HttpRequest Request;
        protected HttpResponse Response;
        private string _action;
        private string _apiName;
        private string _token;
        private string key = "L6J987UEW23U43K46D23USD0N23DF523R";//md5机密串

        protected void SetApiName(string str)
        {
            _apiName = str;
        }

        public virtual void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            Request = context.Request;
            Response = context.Response;

            //验证请求是否合法
            string waitToken = key + "+" + ApiName + "+" + Action + DateTime.Today.ToString("yyyy-MM-dd");
            string mytoken = CryptHelper.MD5_Encrypt(waitToken);
            if (!Token.Equals(mytoken))
            {
                ReturnErrorMsg("非法请求，验证失败");
            }
        }

        public void ReturnErrorMsg(string msg)
        {
            JsonTransfer jt = new JsonTransfer();
            jt.Add("status", "0");
            jt.Add("message", msg);
            Response.Write(CryptHelper.DES_Encrypt(jt.ToJson()));
            Response.End();
        }

        public string ApiName
        {
            get
            {
                if(string.IsNullOrEmpty(_apiName)) _apiName = "ApiHandler";
                return _apiName;
            }
        }
        /// <summary>
        /// 获取当前的Action值
        /// </summary>
        protected string Action
        {
            get
            {
                if (string.IsNullOrEmpty(_action))
                    _action = Request.QueryString["action"];

                return _action;
            }
        }
        /// <summary>
        /// 获取当前的Action值
        /// </summary>
        protected string Token
        {
            get
            {
                if (string.IsNullOrEmpty(_token))
                    _token = Request.QueryString["token"];

                return _token;
            }
        }
        public bool IsReusable
        {
            get { return false; }
        }

        public int GetInt(string paramName, int defaultVale)
        {
            var p1 = Request.Form[paramName];
            if (string.IsNullOrEmpty(p1))
            {
                p1 = Request.QueryString[paramName];
                if (string.IsNullOrEmpty(p1))
                {
                    return defaultVale;
                }
            }
            int returnVaLue = 0;
            int.TryParse(p1.Trim(), out returnVaLue);
            return returnVaLue;
        }

        public int GetInt(string paramName)
        {
            int defaultVale = 0;
            var p1 = Request.Form[paramName];
            if (string.IsNullOrEmpty(p1))
            {
                p1 = Request.QueryString[paramName];
                if (string.IsNullOrEmpty(p1))
                {
                    return defaultVale;
                }
            }
            int returnVaLue = 0;
            int.TryParse(p1.Trim(), out returnVaLue);
            return returnVaLue;
        }

        public float GetFloat(string paramName, int defaultVale)
        {
            var p1 = Request.Form[paramName];
            if (string.IsNullOrEmpty(p1))
            {
                p1 = Request.QueryString[paramName];
                if (string.IsNullOrEmpty(p1))
                {
                    return defaultVale;
                }
            }
            float returnVaLue = 0;
            float.TryParse(p1.Trim(), out returnVaLue);
            return returnVaLue;
        }

        public float GetFloat(string paramName)
        {
            int defaultVale = 0;
            var p1 = Request.Form[paramName];
            if (string.IsNullOrEmpty(p1))
            {
                p1 = Request.QueryString[paramName];
                if (string.IsNullOrEmpty(p1))
                {
                    return defaultVale;
                }
            }
            float returnVaLue = 0;
            float.TryParse(p1.Trim(), out returnVaLue);
            return returnVaLue;
        }

        public string GetString(string paramName, string defaultVale)
        {
            var p1 = Request.Form[paramName];
            if (string.IsNullOrEmpty(p1))
            {
                p1 = Request.QueryString[paramName];
                if (string.IsNullOrEmpty(p1))
                {
                    return defaultVale;
                }
            }
            return p1;
        }
        public string GetString(string paramName)
        {
            string defaultVale = "";
            var p1 = Request.Form[paramName];
            if (string.IsNullOrEmpty(p1))
            {
                p1 = Request.QueryString[paramName];
                if (string.IsNullOrEmpty(p1))
                {
                    return defaultVale;
                }
            }
            return p1;
        }

        public DateTime GetTime(string paramName, DateTime defaultVale)
        {
            var p1 = Request.Form[paramName];
            if (string.IsNullOrEmpty(p1))
            {
                p1 = Request.QueryString[paramName];
                if (string.IsNullOrEmpty(p1))
                {
                    return defaultVale;
                }
            }

            DateTime.TryParse(p1.Trim(), out defaultVale);
            return defaultVale;
        }


        public DateTime GetTime(string paramName)
        {
            DateTime defaultVale = default(DateTime);
            var p1 = Request.Form[paramName];
            if (string.IsNullOrEmpty(p1))
            {
                p1 = Request.QueryString[paramName];
                if (string.IsNullOrEmpty(p1))
                {
                    return defaultVale;
                }
            }

            DateTime.TryParse(p1.Trim(), out defaultVale);
            return defaultVale;
        }
    }

}