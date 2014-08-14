using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Handler.Backstage
{
    public class SystemHandler : BaseApiHandler
    {
        public override void ProcessRequest(HttpContext context)
        {
            base.SetApiName("SystemHandler");
            base.ProcessRequest(HttpContext.Current);
            switch (Action)
            {
                //case "getlist":
                //    GetList(); break;
                //case "getitem":
                //    GetItem(); break;
                //case "update":
                //    UpdateData(); break;
                //case "delete":
                //    Delete(); break;
                //case "create":
                //    Create(); break;
                //default: break;
            }
        }

    }
}