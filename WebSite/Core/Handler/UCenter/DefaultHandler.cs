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
            int pageIndex = GetInt("pageIndex");
            int pageSize = GetInt("pageSize");
            int totalnum;
            var list = Utility.GetUserList(pageIndex, pageSize, out totalnum);

            JsonTransfer jt = new JsonTransfer();
            jt.Add("list", list);
            jt.Add("count", totalnum);
            jt.Add("curcount", list.Count);
            Response.Write(jt.ToJson());
        }
    }
}