using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Entity
{
    /// <summary>
    /// 开发者后台 参数配置
    /// </summary>
    public class Param : KVEntity
    {
        /// <summary>
        /// 用于查找的键值
        /// </summary>
        public string Key { get; set; }
        /// <summary>
        /// json串 或 单独整型
        /// </summary>
        public string Kvalue { get; set; }
        /// <summary>
        /// 说明
        /// </summary>
        public string Description { get; set; }
    }
}