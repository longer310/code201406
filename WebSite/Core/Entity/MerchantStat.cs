using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Entity
{
    public class MerchantStat
    {
        public int UserCount { get; set; }

        public int ActiveCount { get; set; }

        public int GoodsCount { get; set; }

        public int ImgCount { get; set; }

        public int OrderNumber { get; set; }

        public int MoneyCount { get; set; }

        /// <summary>
        /// 公告信息
        /// </summary>
        public string AnnouncementContent { get; set; }

    }

    public class SystemStat
    {

        /// <summary>
        /// 用户数量
        /// </summary>
        public int UserCount { get; set; }

        /// <summary>
        /// 商户数量
        /// </summary>
        public int MerchantCount { get; set; }

        public int ActiveCount { get; set; }

        public int GoodsCount { get; set; }

        public int ImgCount { get; set; }

        public int OrderNumber { get; set; }

        /// <summary>
        /// 订单金额
        /// </summary>
        public float MoneyCount { get; set; }

        /// <summary>
        /// 分类商家统计
        /// </summary>
        public Dictionary<string,string> CategoryStat { get; set; }

        /// <summary>
        /// 公告信息
        /// </summary>
        public string AnnouncementContent { get; set; }

    }


}