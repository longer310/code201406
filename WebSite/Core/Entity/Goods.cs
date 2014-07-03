using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Entity
{
    /// <summary>
    /// 商户产品
    /// </summary>
    public class Goods
    {
        public int Id { get; set; }
        /// <summary>
        /// 商户id
        /// </summary>
        public int SellerId { get; set; }
        /// <summary>
        /// 封面图
        /// </summary>
        public Int64 Logo { get; set; }
        /// <summary>
        /// 产品图集
        /// </summary>
        public string ImgIds { get; set; }
        /// <summary>
        /// 销量
        /// </summary>
        public int Sales { get; set; }
        /// <summary>
        /// 标题
        /// </summary>
        public string Title { get; set; }
        /// <summary>
        /// 分类id
        /// </summary>
        public int Cid { get; set; }
        /// <summary>
        /// 现价
        /// </summary>
        public int Nowprice { get; set; }
        /// <summary>
        /// 原价
        /// </summary>
        public int OriginalPrice { get; set; }
        /// <summary>
        /// 评级
        /// </summary>
        public int Score { get; set; }
    }
}