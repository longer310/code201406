using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Entity
{
    public class WeixinToken
    {
        public int Id { get; set; }

        /// <summary>
        /// 微信的acess_token
        /// </summary>
        public string Access_token { get; set; }

        public int SellerId { get; set; }

        /// <summary>
        /// 过期时间
        /// </summary>
        public DateTime Token_Expire { get; set; }

    }
}