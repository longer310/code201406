using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Entity
{
    /// <summary>
    /// 商户类型表
    /// </summary>
    public class MerchantType : KVEntity
    {
        /// <summary>
        /// 添加的名称
        /// </summary>
        public string Name { get; set; }
        /// <summary>
        /// 默认分类id 1：餐饮  2：夜场 3：企业
        /// </summary>
        public int TypeId { get; set; }
        /// <summary>
        /// 该分类下 商户的个数
        /// </summary>
        public int Count { get; set; }
    }
}