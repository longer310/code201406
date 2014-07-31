using Backstage.Core;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Backstage.View.Active
{
    public partial class Add : BasePage
    {
        public string sellerId;

        protected void Page_Load(object sender, EventArgs e)
        {

            sellerId = Request.QueryString["sellerId"].ToString();
        }
    }
}