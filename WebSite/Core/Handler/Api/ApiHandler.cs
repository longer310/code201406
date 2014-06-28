using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Web;
using Backstage.Core;

namespace Backstage.Handler
{
    public class ApiHandler : BaseApiHandler
    {
        public override void ProcessRequest(HttpContext context)
        {
            base.SetApiName("ApiHandler");
            base.ProcessRequest(HttpContext.Current);
            switch (Action)
            {
                case "getpageinfo":
                    GetPageInfo();
                    break;
                default: break;
            }
        }
        private void GetPageInfo()
        {
            JsonTransfer jt = new JsonTransfer();
            int sellerid = GetInt("sellerid");

            if (sellerid == 0)
            {
                jt.Add("status", 0);
                jt.Add("message", "商户id不合法");
                Response.Write(jt.ToJson());
                return;
            }
        }
    }
}