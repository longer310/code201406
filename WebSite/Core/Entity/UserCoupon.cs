using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Entity
{
    /// <summary>
    /// 用户优惠券
    /// </summary>
    public class UserCoupon
    {
        public int Id { get; set; }

        public int UserId { get; set; }

        public int CouponId { get; set; }

        public DateTime CreateTime { get; set; }

        /// <summary>
        /// 商户id
        /// </summary>
        public int SellerId { get; set; }

        /// <summary>
        /// 是否使用 0：未使用 1：已使用
        /// </summary>
        public int Status { get; set; }
    }
}