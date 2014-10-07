using Backstage.Core;
using Backstage.Core.Entity;
using Backstage.Core.Logic;
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
        public Merchant Seller;

        protected void Page_Load(object sender, EventArgs e)
        {
            var seller = CurrentUser.UserName;
            Seller = MerchantHelper.GetMerchant(Int32.Parse(SellerId));
        }
    }
}