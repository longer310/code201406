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
    public partial class SellerInFo : BasePage
    {
        public Merchant Seller = new Merchant();
        public List<Backstage.Core.Logic.ParamHelper.SignTypeItem> SignList;
        public Account _Account;

        protected void Page_Load(object sender, EventArgs e)
        {
            Seller = MerchantHelper.GetMerchant(Int32.Parse(SellerId));
            SignList = ParamHelper.PlatformCfgData.SignList;
            _Account = AccountHelper.GetUser(Seller.Id);
        }
    }
}