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
    }
}