using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Entity
{
    public class MerchantExtend
    {
        public int SellerId { get; set; }

        /// <summary>
        /// 评论积分
        /// </summary>
        public int CommentIntegral { get; set; }

        /// <summary>
        /// 消费积分
        /// </summary>
        public int ConsumeIntegral { get; set; }

        /// <summary>
        /// 充值积分
        /// </summary>
        public int ChargeIntegral { get; set; }

        /// <summary>
        /// 签到积分
        /// </summary>
        public int RegisteIntegaral { get; set; }

        /// <summary>
        /// 分享积分
        /// </summary>
        public int ShareIntegral { get; set; }



    }
}