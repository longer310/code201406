using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Entity
{
    /// <summary>
    /// 模板表
    /// </summary>
    public class Temple : KVEntity
    {
        /// <summary>
        /// 模板名称
        /// </summary>
        public string Name { get; set; }
        /// <summary>
        /// 模板图片
        /// </summary>
        public string LogoUrl { get; set; }
        /// <summary>
        /// 类型id 0:全部，1：餐饮超市类  2：夜场类 3：企业类
        /// </summary>
        public int TypeId { get; set; }
    }
}