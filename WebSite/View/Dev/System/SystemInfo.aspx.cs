using Backstage.Core;
using Backstage.Core.Logic;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Backstage.View.Dev.System
{
    public partial class SystemInfo :BasePage
    {
        public Backstage.Core.Logic.ParamHelper.PlatformCfg PlatformCfg;
        protected void Page_Load(object sender, EventArgs e)
        {
            PlatformCfg = ParamHelper.PlatformCfgData;

        }
    }
}