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
    public partial class DevMaster : System.Web.UI.MasterPage
    {
        public Account Merchant
        {
            get { return AccountHelper.GetCurUser(); }
        }
        public string DomainUrl { get { ; return Utility._domainurl; } }
        protected void Page_Load(object sender, EventArgs e)
        {


        }
    }
}