using Backstage.Core;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Backstage.View.Coupon
{
    public partial class Edit : BasePage
    {
        public string Id = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            Id = Request.QueryString["id"].ToString();
        }
    }
}