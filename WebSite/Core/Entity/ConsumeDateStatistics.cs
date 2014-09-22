using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Entity
{
    /// <summary>
    /// 销量日统计
    /// </summary>
    public class ConsumeDateStatistics : KVEntity
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
        /// 月
        /// </summary>
        public int Month { get; set; }
        /// <summary>
        /// 日
        /// </summary>
        public int Day { get; set; }
        /// <summary>
        /// 日总计
        /// </summary>
        public float Total { get; set; }
        /// <summary>
        /// 0-1点总计
        /// </summary>
        public float Interval0 { get; set; }
        /// <summary>
        /// 1-2点总计
        /// </summary>
        public float Interval1 { get; set; }
        /// <summary>
        /// 2-3点总计
        /// </summary>
        public float Interval2 { get; set; }
        /// <summary>
        /// 3-4点总计
        /// </summary>
        public float Interval3 { get; set; }
        /// <summary>
        /// 4-5点总计
        /// </summary>
        public float Interval4 { get; set; }
        /// <summary>
        /// 5-6点总计
        /// </summary>
        public float Interval5 { get; set; }
        /// <summary>
        /// 6-7点总计
        /// </summary>
        public float Interval6 { get; set; }
        /// <summary>
        /// 7-8点总计
        /// </summary>
        public float Interval7 { get; set; }
        /// <summary>
        /// 8-9点总计
        /// </summary>
        public float Interval8 { get; set; }
        /// <summary>
        /// 9-10点总计
        /// </summary>
        public float Interva9 { get; set; }
        /// <summary>
        /// 10-11点总计
        /// </summary>
        public float Interval10 { get; set; }
        /// <summary>
        /// 11-12点总计
        /// </summary>
        public float Interval11 { get; set; }
        /// <summary>
        /// 12-13点总计
        /// </summary>
        public float Interval12 { get; set; }
        /// <summary>
        /// 13-14点总计
        /// </summary>
        public float Interval13 { get; set; }
        /// <summary>
        /// 14-15点总计
        /// </summary>
        public float Interval14 { get; set; }
        /// <summary>
        /// 15-16点总计
        /// </summary>
        public float Interval15 { get; set; }
        /// <summary>
        /// 16-17点总计
        /// </summary>
        public float Interval16 { get; set; }
        /// <summary>
        /// 17-18点总计
        /// </summary>
        public float Interval17 { get; set; }
        /// <summary>
        /// 18-19点总计
        /// </summary>
        public float Interval18 { get; set; }
        /// <summary>
        /// 19-20点总计
        /// </summary>
        public float Interval19 { get; set; }
        /// <summary>
        /// 20-21点总计
        /// </summary>
        public float Interval20 { get; set; }
        /// <summary>
        /// 21-22点总计
        /// </summary>
        public float Interval21 { get; set; }
        /// <summary>
        /// 22-23点总计
        /// </summary>
        public float Interval22 { get; set; }
        /// <summary>
        /// 23-0点总计
        /// </summary>
        public float Interval23 { get; set; }
    }
}