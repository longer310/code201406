using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Entity
{
    /// <summary>
    /// 分享记录表
    /// </summary>
    public class ShareLog : KVEntity
    {
        /// <summary>
        /// 会员id
        /// </summary>
        public int UserId { get; set; }
        /// <summary>
        /// 分享类型
        /// </summary>
        public int Type { get; set; }
        /// <summary>
        /// 分享类型id
        /// </summary>
        public int TypeId { get; set; }
        /// <summary>
        /// 分享内容
        /// </summary>
        public string Content { get; set; }
        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime CreateTime { get; set; }

        public ShareLog()
        {
            CreateTime = DateTime.Now;
        }
    }
}