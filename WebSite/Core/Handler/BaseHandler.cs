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
    public class BaseHandler : IRequiresSessionState, IHttpHandler
    {
        protected HttpRequest Request;
        protected HttpResponse Response;
        private string _action;

        public virtual void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            Request = context.Request;
            Response = context.Response;
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
        public void ReturnErrorMsg(string msg)
        {
            JsonTransfer jt = new JsonTransfer();
            jt.Add("status", "0");
            jt.Add("message", msg);
            Response.Write(CryptHelper.DES_Encrypt(jt.ToJson()));
            Response.End();
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

    public class JsonHelpr
    {
        public static string ResponseData(string action, string msg, object data)
        {
            var output = new
            {
                key = action,
                Msg = msg,
                Data = data
            };
            return JsonConvert.SerializeObject(output);
        }

        public static string ResponseData(string action, string msg)
        {
            object data = null;
            var output = new
            {
                key = action,
                Msg = msg,
                Data = data
            };
            return JsonConvert.SerializeObject(output);
        }
    }
}