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

        public int MoneyCount { get; set; }

        /// <summary>
        /// 公告信息
        /// </summary>
        public string AnnouncementContent { get; set; }

    }


}