using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage
{
    public static class GlobalConfig
    {
        public static string DbConn = System.Configuration.ConfigurationManager.AppSettings["gamedbconn"];
    }
}