using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Backstage.Core;

namespace Backstage.Handler
{
    public class DefaultHandler : BaseHandler
    {
        public override void ProcessRequest(HttpContext context)
        {
            base.ProcessRequest(HttpContext.Current);
            switch (Action)
            {
                case "getManagerList":
                    GetManagerList(); break;
                default: break;
            }
        }
        private void GetManagerList()
        {

        }
    }
}