using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Entity
{
    /// <summary>
    /// 图片尺寸配置表
    /// </summary>
    public class ImgSizeCfg : KVEntity
    {
        /// <summary>
        /// 图片类型
        /// </summary>
        public UploadType Type { get; set; }
        /// <summary>
        /// 是否是原图（后台上传的图片）以原图大小进行压缩再截取，原图地址存储在各个表中
        /// </summary>
        public int IsOriginal { get; set; }
        /// <summary>
        /// 宽
        /// </summary>
        public int Width { get; set; }
        /// <summary>
        /// 高
        /// </summary>
        public int Height { get; set; }
    }



}