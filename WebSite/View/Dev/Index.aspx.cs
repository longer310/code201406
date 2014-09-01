using Backstage.Core.Handler;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Backstage.Core.Entity;

namespace WebSite.View.Dev
{
    public partial class Index : System.Web.UI.Page
    {
        public List<Fastlinks>  Fastlinkslist= new List<Fastlinks>();
        protected void Page_Load(object sender, EventArgs e)
        {
            //Fastlinkslist = DevSystemHelper.GetPagFastlinks(0, 0).Results.ToList();

        }
    }
}