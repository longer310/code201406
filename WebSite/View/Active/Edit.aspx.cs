using Backstage.Core;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Backstage.View.Active
{
    public partial class Edit : BasePage
    {
        public string Id = "";
        public string SellerId = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            Id = Request.QueryString["id"].ToString();
            var active = ActiveHelper.GetItem(Convert.ToInt32(Id));
            SellerId = active.SellerId.ToString();
        }
    }
}