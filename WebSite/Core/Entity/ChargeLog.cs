﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Entity
{
    /// <summary>
    /// 充值消费记录表
    /// </summary>
    public class ChargeLog : KVEntity
    {
        /// <summary>
        /// 会员id
        /// </summary>
        public int UserId { get; set; }
        /// <summary>
        /// 充值余额
        /// </summary>
        public float Money { get; set; }
        /// <summary>
        /// 充值类型
        /// </summary>
        public int Pid { get; set; }
        /// <summary>
        /// 订单id
        /// </summary>
        public string OrderId { get; set; }
        /// <summary>
        /// 商户id
        /// </summary>
        public int SellerId { get; set; }
        /// <summary>
        /// 充值类型名称
        /// </summary>
        public string PayName { get; set; }
        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime CreateTime { get; set; }
    }
}