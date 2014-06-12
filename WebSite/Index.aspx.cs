using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Backstage.Core;


namespace Backstage
{
    public partial class Index : BasePage
    {
        public string RoleName = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (CurrentUser != null)
            {
                switch (CurrentUser.RoleType)
                {
                    case RoleType.User:
                        RoleName = "普通用户";
                        now17.Visible = false;
                        break;
                    case RoleType.Manage:
                        RoleName = "管理员";
                        now17.Visible = false;
                        break;
                    case RoleType.SuperManage:
                        RoleName = "超级管理员";
                        now17.Visible = true;
                        break;
                    default: break;
                }
            }
        }

        protected void ResetCache(object sender, EventArgs e)
        {
            DataTable dt = Utility.GetGameServerList();
            foreach (DataRow row in dt.Rows)
            {
                string connstr = row["gameconn"].ToString();
                var sql = string.Format("UPDATE n_autoload SET `load`=1 WHERE `table`='c_intdatacfg';");
                MySqlHelper.ExecuteNonQuery(connstr, CommandType.Text, sql);
            }

        }
    }
}
