using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebSite
{
    public static class GlobalConfig
    {
        public static string DbConn = System.Configuration.ConfigurationManager.AppSettings["gamedbconn"];
    }
}