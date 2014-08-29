using Backstage.Core;
using Backstage.Core.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Backstage.View.Dev.UserCenter
{
    public partial class Edit : BasePage
    {
        public Account account;


        protected void Page_Load(object sender, EventArgs e)
        {
            int id = Int32.Parse(Request.QueryString["id"]);
            account = AccountHelper.GetUser(id);
        }
    }
}