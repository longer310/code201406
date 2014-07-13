using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Entity
{
    public class UserWifi
    {
        public int Id { get; set; }

        public int UserId { get; set; }

        /// <summary>
        /// wifi的密码
        /// </summary>
        public string Pwd { get; set; }

        public int SellerId { get; set; }

        /// <summary>
        /// 有效期
        /// </summary>
        public DateTime Expiry { get; set; }

    }
}