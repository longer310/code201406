using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Backstage.View.Active
{
    public partial class List : System.Web.UI.Page
    {
        public string sellerid;

        protected void Page_Load(object sender, EventArgs e)
        {
            sellerid = Request.QueryString["sellerid"].ToString();
        }
    }
}