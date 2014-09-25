using Backstage.Core;
using Backstage.Core.Entity;
using Backstage.Core.Handler;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Backstage.View.Position
{
    public partial class Add : BasePage
    {
        public IList<BoxType> BoxTypes = new List<BoxType>();

        protected void Page_Load(object sender, EventArgs e)
        {
            BoxTypes = PositionHelper.GetListBoxTypes(Convert.ToInt32(SellerId), 0, 0);
        }
    }
}