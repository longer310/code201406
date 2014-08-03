using Backstage.Core;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Backstage.View.SourceMaterial
{
    public partial class Edit : BasePage
    {
        public string SellerId;
        public string Id;
        protected void Page_Load(object sender, EventArgs e)
        {
            SellerId = Request.QueryString["sellerid"].ToString();
            Id = Request.QueryString["id"].ToString();
        }
    }
}