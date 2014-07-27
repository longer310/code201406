using System;
using System.Collections.Generic;
using System.EnterpriseServices;
using System.Linq;
using System.Web;
using Backstage.Core;
using Backstage.Core.Entity;

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
                case "getpwd":
                    GetPwd(); break;
                default: break;
            }
        }

        private void GetPwd()
        {
            int phone = GetInt("phone");
            var user = AccountHelper.GetUserByPhone(phone);
            if (user.Id == 0)
            {
                ReturnErrorMsg("手机号码不存在");
            }
            if (Utility._msg_opensend == "1")
                Utility.SendMsg(user.Pwd, phone.ToString(), Utility._msg_getpwd);
            ReturnCorrectMsg("请注意查收密码");
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
            int totalnum;
            var list = AccountHelper.GetUserList(out totalnum, " where (RoleType = 2 or RoleType = 3) ", "",
                pageIndex * pageSize, pageSize);

            jt.Add("list", list);
            jt.Add("count", totalnum);
            jt.Add("curcount", list.Count);
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

            int num = AccountHelper.UpdateUser(account);
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