using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Entity
{
    /// <summary>
    /// 充值月统计
    /// </summary>
    public class RechargeMonthStatistics : KVEntity
    {
        /// <summary>
        /// 商户id
        /// </summary>
        public int SellerId { get; set; }
        /// <summary>
        /// 年
        /// </summary>
        public int Year { get; set; }
        /// <summary>
        /// 年总计
        /// </summary>
        public float Total { get; set; }
        /// <summary>
        /// 1月总计
        /// </summary>
        public float Month1 { get; set; }
        /// <summary>
        /// 2月总计
        /// </summary>
        public float Month2 { get; set; }
        /// <summary>
        /// 3月总计
        /// </summary>
        public float Month3 { get; set; }
        /// <summary>
        /// 4月总计
        /// </summary>
        public float Month4 { get; set; }
        /// <summary>
        /// 5月总计
        /// </summary>
        public float Month5 { get; set; }
        /// <summary>
        /// 6月总计
        /// </summary>
        public float Month6 { get; set; }
        /// <summary>
        /// 7月总计
        /// </summary>
        public float Month7 { get; set; }
        /// <summary>
        /// 8月总计
        /// </summary>
        public float Month8 { get; set; }
        /// <summary>
        /// 9月总计
        /// </summary>
        public float Month9 { get; set; }
        /// <summary>
        /// 10月总计
        /// </summary>
        public float Month10 { get; set; }
        /// <summary>
        /// 11月总计
        /// </summary>
        public float Month11 { get; set; }
        /// <summary>
        /// 12月总计
        /// </summary>
        public float Month12 { get; set; }
    }
}