using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Entity
{
    /// <summary>
    /// 购物车
    /// </summary>
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
        //public string Img { get; set; }
        /// <summary>
        /// 数量
        /// </summary>
        public int Num { get; set; }
        /// <summary>
        /// 现价
        /// </summary>
        //public float Nowprice { get; set; }
        /// <summary>
        /// 原价
        /// </summary>
        //public float OriginalPrice { get; set; }
        /// <summary>
        /// 标题
        /// </summary>
        //public string Title { get; set; }
        /// <summary>
        /// 产品描述
        /// </summary>
        //public string Description { get; set; }
        /// <summary>
        /// 时间
        /// </summary>
        public DateTime CreateTime { get; set; }
    }
}