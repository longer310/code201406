using Backstage.Core;
using Backstage.Core.Entity;
using Backstage.Core.Handler;
using Backstage.Core.Logic;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Backstage.View
{
    public partial class Index : BasePage
    {
        public MerchantStat MerchantStat;

        protected void Page_Load(object sender, EventArgs e)
        {
            MerchantStat = SystemHelper.GetMerchantStat(Int32.Parse(SellerId));
            MerchantStat.AnnouncementContent = AnnouncementHelper.GetNewsItem().Content;
            
        }
    }


}