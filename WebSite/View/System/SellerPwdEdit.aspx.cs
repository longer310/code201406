using Backstage.Core;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Backstage.View.System
{
    public partial class SellerPwdEdit : BasePage
    {
        public string _UserName;

        protected void Page_Load(object sender, EventArgs e)
        {
            var seller = CurrentUser.UserName; 
        }
    }
}