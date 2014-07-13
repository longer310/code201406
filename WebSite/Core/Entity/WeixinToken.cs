using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Entity
{
    public class WeixinToken
    {
        public int Id { get; set; }

        public string Access_token { get; set; }

        public int SellerId { get; set; }

        public DateTime Token_Expire { get; set; }

    }
}