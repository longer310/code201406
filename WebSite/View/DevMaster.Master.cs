using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Backstage.Core;
using Backstage.Core.Entity;

namespace WebSite.View
{
    /// <summary>
    /// 开发者（平台）模板页
    /// </summary>
    public class DevMasterBasePage : System.Web.UI.MasterPage
    {
        public Account DevUser
        {
            get { return AccountHelper.GetCurUser(); }
        }
        public string DomainUrl { get { ; return Utility._domainurl; } }
    }
    public partial class DevMaster : DevMasterBasePage
    {
        public string RoleName = string.Empty;
        public string UserName { get; set; }
        public float Money { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (DevUser != null)
            {
                UserName = DevUser.UserName;
                Money = DevUser.Money;

                UserName = DevUser.UserName;
                switch (DevUser.RoleType)
                {
                    case RoleType.Manage:
                        RoleName = "管理员";
                        break;
                    case RoleType.SuperManage:
                        RoleName = "超级管理员";
                        break;
                    default: break;
                }
            }
        }
    }
}