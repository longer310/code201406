using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Backstage.Core;
using Backstage.Core.Entity;

namespace WebSite.View
{
    /// <summary>
    /// 商户模板页
    /// </summary>
    public class MerchantMasterBasePage : System.Web.UI.MasterPage
    {
        public Account Merchant
        {
            get { return AccountHelper.GetCurUser(); }
        }
        public string DomainUrl { get { ; return Utility._domainurl; } }
    }
    public partial class MerchantMaster : MerchantMasterBasePage
    {
        public string UserName { get; set; }
        public float Money { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Merchant != null)
            {
                UserName = Merchant.UserName;
                Money = Merchant.Money;
            }
        }
    }
}