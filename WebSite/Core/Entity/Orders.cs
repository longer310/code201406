using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Entity
{
    /// <summary>
    /// 产品订单
    /// </summary>
    public class Orders : KVEntity
    {
        /// <summary>
        /// 产品图片地址
        /// </summary>
        public string Img { get; set; }
        public int Gid { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public float TotalPrice { get; set; }
        /// <summary>
        /// 单价
        /// </summary>
        public float Price { get; set; }

    }
}