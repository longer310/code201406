using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Entity
{
    public class ShoppingCart : KVEntity
    {
        /// <summary>
        /// 用户id
        /// </summary>
        public int UserId { get; set; }
        /// <summary>
        /// 产品id
        /// </summary>
        public int Gid { get; set; }
        /// <summary>
        /// 产品图片地址
        /// </summary>
        public string Img { get; set; }
        /// <summary>
        /// 数量
        /// </summary>
        public int Num { get; set; }
        /// <summary>
        /// 单价
        /// </summary>
        public float Price { get; set; }
        /// <summary>
        /// 时间
        /// </summary>
        public DateTime CreateTime { get; set; }
    }
}