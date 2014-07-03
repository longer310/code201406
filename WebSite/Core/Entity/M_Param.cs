using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Entity
{
    /// <summary>
    /// 开发者后台 参数配置
    /// </summary>
    public class M_Param
    {
        public int Id { get; set; }
        /// <summary>
        /// 推送的广告图片id
        /// </summary>
        public Int64 AdImgId { get; set; }
    }
}