using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Entity
{
    /// <summary>
    /// 短信类
    /// </summary>
    public class SendMsgClass1
    {
        public string param1 { get; set; }
    }
    public class SendMsgClass2 : SendMsgClass1
    {
        public string param2 { get; set; }
    }
    public class SendMsgClass3 : SendMsgClass2
    {
        public string param3 { get; set; }
    }
    public class SendMsgClass4 : SendMsgClass3
    {
        public string param4 { get; set; }
    }
    public class SendMsgClass5 : SendMsgClass4
    {
        public string param5 { get; set; }
    }
}