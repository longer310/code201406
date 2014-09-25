using Backstage.Core;
using Backstage.Core.Entity;
using Backstage.Core.Handler;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tools.Json;

namespace Backstage.View.Position
{
    public partial class Edit : BasePage
    {
        public string Id;
        public IList<BoxType> BoxTypes = new List<BoxType>();

        protected void Page_Load(object sender, EventArgs e)
        {
            Id = Request.QueryString["id"].ToString();
            BoxTypes = PositionHelper.GetListBoxTypes(Convert.ToInt32(SellerId), 0, 0);
        }
    }
}