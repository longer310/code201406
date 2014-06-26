using System;
using System.Collections.Generic;
using System.EnterpriseServices;
using System.Linq;
using System.Web;
using Backstage.Core;

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
                    UpdateData();break;
                case "deldata":
                    DelData();break;
                default: break;
            }
        }
        private void GetManagerList()
        {
            JsonTransfer jt = new JsonTransfer();
            var user = Utility.GetCurUser();
            if (user.RoleType != RoleType.SuperManage)
            {
                jt.SetError("无权限");
                Response.Write(jt.ToJson());
                return;
            }

            int pageIndex = GetInt("pageIndex");
            int pageSize = GetInt("pageSize");
            int totalnum;
            var list = UserHelper.GetUserList(pageIndex, pageSize, out totalnum);

            jt.Add("list", list);
            jt.Add("count", totalnum);
            jt.Add("curcount", list.Count);
            Response.Write(jt.ToJson());
        }

        private void UpdateData()
        {
            JsonTransfer jt = new JsonTransfer();
            var user = Utility.GetCurUser();
            if (user.RoleType != RoleType.SuperManage)
            {
                jt.SetError("无权限");
                Response.Write(jt.ToJson());
                return;
            }

            int id = GetInt("id");
            int roleType = GetInt("roletype");
            string userName = GetString("username");
            string pwd = GetString("pwd");

            int num = UserHelper.UpdateUser(id, userName, pwd, roleType);
            jt.Add("num", num);
            Response.Write(jt.ToJson());
        }

        private void DelData()
        {
            JsonTransfer jt = new JsonTransfer();
            var user = Utility.GetCurUser();
            if (user.RoleType != RoleType.SuperManage)
            {
                jt.SetError("无权限");
                Response.Write(jt.ToJson());
                return;
            }
            int id = GetInt("id");

            int num = UserHelper.DelUser(id);
            jt.Add("num", num);
            Response.Write(jt.ToJson());
        }
    }
}