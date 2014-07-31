using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Entity
{

    /// <summary>
    /// 活动资讯
    /// </summary>
    public class Active
    {
        public int Id { get; set; }

        public int SellerId { get; set; }

        public int CoverImgId { get; set; }

        /// <summary>
        /// 优惠券
        /// </summary>
        public int CouponId { get; set; }

        public string CoverImgUrl { get; set; }

        public string Title { get; set; }

        /// <summary>
        /// 截取Description的前20个字符串
        /// </summary>
        public string Summary { get; set; }

        /// <summary>
        /// 描述
        /// </summary>
        public string Description { get; set; }

        public int Commentnum { get; set; }

        public DateTime CreateTime { get; set; }

        /// <summary>
        /// 浏览次数
        /// </summary>
        public int Views { get; set; }

    }
}