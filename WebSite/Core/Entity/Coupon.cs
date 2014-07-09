using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Entity
{
    public class Coupon
    {
        public int Id { get; set; }

        public string Title { get; set; }

        public int ImgId { get; set; }

        public string ImgUrl { get; set; }

        /// <summary>
        /// 积分
        /// </summary>
        public int Extcredit { get; set; }

        /// <summary>
        /// 有效期
        /// </summary>
        public DateTime Dxpiry { get; set; }

        /// <summary>
        /// 描述
        /// </summary>
        public string Description { get; set; }

    }
}