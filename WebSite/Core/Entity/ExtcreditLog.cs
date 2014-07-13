using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Entity
{
    /// <summary>
    /// 积分获取/消耗记录
    /// </summary>
    public class ExtcreditLog : KVEntity
    {
        public int UserId { get; set; }
        public int SellerId { get; set; }
        /// <summary>
        /// 来源id（订单id，评论id，分享产品id，签到时间戳）
        /// </summary>
        public int SourceId { get; set; }
        /// <summary>
        /// 获取或消耗的积分 正负表示
        /// </summary>
        public int Extcredit { get; set; }
        public ExtcreditSourceType Type { get; set; }
        public DateTime CreateTime { get; set; }
    }
}