using System;
using System.Collections.Generic;
using System.EnterpriseServices;
using System.Linq;
using System.Web;
using Backstage.Core;
using Backstage.Core.Entity;
using Backstage.Core.Logic;

namespace Backstage.Handler
{
    public class DefaultHandler : BaseHandler
    {
        public override void ProcessRequest(HttpContext context)
        {
            base.ProcessRequest(HttpContext.Current);
            switch (Action)
            {
                case "getManagerList":
                    GetManagerList(); break;
                case "updatedata":
                    UpdateData(); break;
                case "deldata":
                    DelData(); break;
                default: break;
            }
        }


        private void GetManagerList()
        {
            JsonTransfer jt = new JsonTransfer();
            var user = AccountHelper.GetCurUser();
            if (user.RoleType != RoleType.SuperManage)
            {
                jt.SetError("无权限");
                Response.Write(jt.ToJson());
                return;
            }

            int pageIndex = GetInt("pageIndex");
            int pageSize = GetInt("pageSize");
            var result = AccountHelper.GetUserList(" where (RoleType = 2 or RoleType = 3) ", "",
                pageIndex * pageSize, pageSize, 1);

            jt.Add("list", result.Results);
            jt.Add("count", result.TotalCount);
            jt.Add("curcount", result.TotalCount);
            Response.Write(jt.ToJson());
        }

        private void UpdateData()
        {
            JsonTransfer jt = new JsonTransfer();
            var user = AccountHelper.GetCurUser();
            if (user.RoleType != RoleType.SuperManage)
            {
                jt.SetError("无权限");
                Response.Write(jt.ToJson());
                return;
            }

            Account account = new Account();
            account.Id = GetInt("id");
            account.RoleType = (RoleType)GetInt("roletype");
            account.UserName = GetString("username");
            account.Pwd = GetString("pwd");
            account.Avatar = GetString("avatar");
            account.Sex = (SexType)GetInt("sex");
            account.CreateTime = GetTime("createtime");

            int num = AccountHelper.SaveAccount(account);
            jt.Add("num", num);
            Response.Write(jt.ToJson());
        }

        private void DelData()
        {
            JsonTransfer jt = new JsonTransfer();
            var user = AccountHelper.GetCurUser();
            if (user.RoleType != RoleType.SuperManage)
            {
                jt.SetError("无权限");
                Response.Write(jt.ToJson());
                return;
            }
            int id = GetInt("id");

            int num = AccountHelper.DelUser(id);
            jt.Add("num", num);
            Response.Write(jt.ToJson());
        }
    }
}