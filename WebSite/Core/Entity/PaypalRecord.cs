using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Entity
{
    /// <summary>
    /// 支付宝充值记录表
    /// </summary>
    public class PaypalRecord : KVEntity
    {
        /// <summary>
        /// 订单id
        /// </summary>
        public int OrderId { get; set; }
        /// <summary>
        /// 支付宝返回状态
        /// </summary>
        public string Status { get; set; }
        /// <summary>
        /// 支付宝交易号
        /// </summary>
        public string Trade_no { get; set; }
    }
}