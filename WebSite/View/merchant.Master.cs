﻿using System;
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
        public Account Merchant
        {
            get { return AccountHelper.GetCurUser(); }
        }
        public string DomainUrl { get { return Utility._domainurl; } }

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