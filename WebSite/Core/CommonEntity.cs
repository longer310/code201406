using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core
{
    public class User
    {
        public int Id { get; set; }
        public string UserName { get; set; }
        public string Pwd { get; set; }
        public RoleType RoleType { get; set; }
        //public List<int> Servers { get; set; }
    }
}