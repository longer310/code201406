﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;
using Backstage.Core.Entity;
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
        private Account _currentUser;
        private bool _isLogin;
        private string _action;
        private string _freeActions;
        private RoleType _roleType;

        public virtual void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            Request = context.Request;
            Response = context.Response;

            if (!IsLogin)//未登录
            {
                if (!string.IsNullOrEmpty(_freeActions) && _freeActions.IndexOf("," + Action + ",") > -1)
                {
                    if (_roleType < CurrentUser.RoleType)
                    {
                        Response.Write(new JsonTransfer().SetError("无权限"));
                        Response.End();
                    }
                }
                else
                {
                    Response.Write(new JsonTransfer().SetError("您还未登录或登录超时，请重新登录！"));
                    Response.End();
                }
            }
        }
        /// <summary>
        /// 是否登陆
        /// </summary>
        public bool IsLogin
        {
            get { return _isLogin; }
        }
        /// <summary>
        /// 可能为null，使用的时候要记得判断
        /// </summary>
        public Account CurrentUser
        {
            get { return _currentUser; }
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
        /// 设置该页面为不验证登录的页面，格式“,a,b,c,”
        /// </summary>
        protected string FreeActions
        {
            get { return _freeActions; }
            set { _freeActions = value; }
        }
        /// <summary>
        /// 设置访问权限
        /// </summary>
        protected RoleType RoleType
        {
            get { return _roleType; }
            set { _roleType = value; }
        }
        /// <summary>
        /// 初始化
        /// </summary>
        public BaseHandler()
        {
            _currentUser = AccountHelper.GetCurUser();
            _isLogin = _currentUser != null;
        }
        public bool IsReusable
        {
            get { return false; }
        }
        
        public void ReturnErrorMsg(string msg)
        {
            JsonTransfer jt = new JsonTransfer();
            jt.SetError("msg");
            Response.Write(jt.ToJson());
            Response.End();
        }
        public void ReturnCorrectMsg(string msg)
        {
            JsonTransfer jt = new JsonTransfer();
            jt.Add("success", msg);
            Response.Write(jt.ToJson());
            Response.End();
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