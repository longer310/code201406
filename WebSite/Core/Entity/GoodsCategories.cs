using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Entity
{
    /// <summary>
    /// 商户产品分类 cid=id
    /// </summary>
    public class GoodsCategories : KVEntity
    {
        /// <summary>
        /// 分类排序
        /// </summary>
        public int Index{get; set;}
        /// <summary>
        /// 分类名称
        /// </summary>
        public string Name { get; set; }

        /// <summary>
        /// 商户id
        /// </summary>
        public int SellerId { get; set; }

        /// <summary>
        /// 分类图片地址
        /// </summary>
        public string ImageUrl { get; set; }

        /// <summary>
        /// 该类下产品个数
        /// </summary>
        public int Count { get; set; }

        public GoodsCategories()
        {
            Name = "";
        }
    }
}