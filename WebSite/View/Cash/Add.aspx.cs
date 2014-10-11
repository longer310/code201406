using Backstage.Core;
using Backstage.Core.Entity;
using Backstage.Core.Logic;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Backstage.View.Cash
{
    public partial class Add : BasePage
    {
        public Merchant Seller;
        public Account Account;
        public List<Backstage.Core.Logic.ParamHelper.SignTypeItem> SignList;
        public float _LockMoney;

        protected void Page_Load(object sender, EventArgs e)
        {
            Seller = MerchantHelper.GetMerchant(Int32.Parse(SellerId));
            Account = AccountHelper.GetUser(Int32.Parse(SellerId));
            SignList = ParamHelper.PlatformCfgData.SignList;
            _LockMoney = Account.Money - Seller.Money;
        }
    }
}