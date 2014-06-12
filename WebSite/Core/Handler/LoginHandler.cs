﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Backstage.Core;

namespace Backstage.Handler
{
    public class LoginHandler : BaseHandler
    {
        public override void ProcessRequest(HttpContext context)
        {
            base.ProcessRequest(HttpContext.Current);
            switch (Action)
            {
                case "login":
                    Login(); break;
                case "logout":
                    Logout();break;
                case "getUserList":
                    GetUserList();break;
                default: break;
            }
        }
        private void Login()
        {
            string userName = GetString("userName");
            string pwd = GetString("pwd");

            User user = Utility.FindUser(userName);
            JsonTransfer jt = new JsonTransfer();
            if (user == null)
                jt.SetError("不存在此用户");
            else if (user.Pwd != pwd)
                jt.SetError("密码错误");
            else
            {
                //设置已登录
                Utility.SetLogOn(user.Id, true, Utility.GetStringFromEntity(user), DateTime.Now.AddDays(1));
                jt.Add("success","登录成功");
            }
            Response.Write(jt.ToJson());
        }

        private void Logout()
        {
            Utility.SetLogOut();
            //Response.Redirect("../login.aspx");
            Response.Write(JsonHelpr.ResponseData("1", "退出成功"));
        }

        private void GetUserList()
        {
            string startTime = GetString("startTime");
            string endTime = GetString("endTime");

            var list = new List<User>();
            list.Add(new User() { Id = 1, UserName = "张三" });
            list.Add(new User() { Id = 2, UserName = "李四" });

            Response.Write(JsonHelpr.ResponseData("1", "0", list));
        }
    }
}