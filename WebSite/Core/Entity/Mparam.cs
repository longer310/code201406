using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Entity
{
    /// <summary>
    /// 开发者后台 参数配置
    /// </summary>
    public class Mparam : KVEntity
    {
        /// <summary>
        /// 推送的广告图片id
        /// </summary>
        public int AdImgId { get; set; }
        /// <summary>
        /// URL
        /// </summary>
        public string AdImgUrl { get; set; }
        /// <summary>
        /// 标题
        /// </summary>
        public string Title { get; set; }

        /// <summary>
        /// 跳转到的URL
        /// </summary>
        public string Url { get; set; }
    }
}