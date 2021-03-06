﻿using Backstage.Core;
using Backstage.Core.Handler;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Backstage.Core.Entity;
using Backstage.Core;
using Backstage.Core.Logic;

namespace WebSite.View.Dev
{
    public partial class Index : BasePage
    {
        public List<Fastlinks>  Fastlinkslist= new List<Fastlinks>();
        public string DomainUrl = Utility._domainurl;
        public SystemStat SystemStat;

        protected void Page_Load(object sender, EventArgs e)
        {
            Fastlinkslist = DevSystemHelper.GetPagFastlinks(0, 0).Results.ToList();
            SystemStat = DevSystemHelper.GetSystemStat();

        }
    }
}