using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Entity
{
    public class Coupon
    {
        public int Id { get; set; }

        public int SellerId { get; set; }

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
        public DateTime Expiry { get; set; }

        /// <summary>
        /// 摘要（截断Decription前20个字符串）
        /// </summary>
        public string Summary { get; set; }

        /// <summary>
        /// 描述
        /// </summary>
        public string Description { get; set; }

        /// <summary>
        /// 满多少的金额优惠
        /// </summary>
        public int FullMoney { get; set; }

        /// <summary>
        /// 优惠的具体金额
        /// </summary>
        public int DiscountMoney { get; set; }

        /// <summary>
        /// 限定使用商品（制定的Id不能使用优惠券）
        /// </summary>
        public IList<int> GoodsIds { get; set; }

        /// <summary>
        /// 评论数
        /// </summary>
        public int Commentnum { get; set; }

        /// <summary>
        /// 是否使用 0：未使用 1：已使用
        /// </summary>
        public int Status { get; set; }
    }
}