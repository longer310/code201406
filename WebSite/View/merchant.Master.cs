using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Backstage.Core;
using Backstage.Core.Entity;
using Backstage.Core.Logic;

namespace WebSite.View
{
    /// <summary>
    /// 商户模板页
    /// </summary>
    public class MerchantMasterBasePage : System.Web.UI.MasterPage
    {
        public string GetString(string paramName)
        {
            string defaultVale = "";
            var p1 = Request.Form[paramName];
            if (string.IsNullOrEmpty(p1))
            {
                p1 = Request.QueryString[paramName];
                if (string.IsNullOrEmpty(p1))
                {
                    return defaultVale;
                }
            }
            return p1;
        }

        public string SellerId
        {
            get
            {
                var sellerId = GetString("sellerId");
                if (sellerId != null && sellerId.Length > 0)
                    return sellerId;
                return Merchant.Id.ToString();
            }
        }
        public Merchant Merchant
        {
            get
            {
                int id = Account.Id;
                if (!string.IsNullOrEmpty(GetString("sellerId")))
                {
                    if (Utility.IsNum(SellerId))
                    {

                        return MerchantHelper.GetMerchant(Convert.ToInt32(SellerId));
                    }
                }
                var account = AccountHelper.GetUser(id);
                return MerchantHelper.GetMerchant(account.SellerId);
            }
        }
        public Account Account
        {
            get
            {
                if (!string.IsNullOrEmpty(GetString("sellerId")))
                {
                    if (Utility.IsNum(SellerId))
                    {
                        return AccountHelper.GetUser(Convert.ToInt32(SellerId));
                    }
                }
                return AccountHelper.GetCurUser();
            }
        }
        public string DomainUrl { get { return Utility._domainurl; } }
    }
    public partial class MerchantMaster : MerchantMasterBasePage
    {
        public string UserName { get; set; }
        public float Money { get; set; }
        public string MerchantName { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Account != null)
            {
                UserName = Account.UserName;
                Money = Account.Money;
            }
            if (Merchant != null)
            {
                MerchantName = Merchant.Name;
            }
        }
    }
}