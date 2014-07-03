using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Entity
{
    /// <summary>
    /// 用户收藏
    /// </summary>
    public class Favorite : KVEntity
    {
        /// <summary>
        /// 收藏的产品id列表
        /// </summary>
        public string Gids { get; set; }
    }
}