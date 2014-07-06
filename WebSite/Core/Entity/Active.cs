using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Entity
{

    /// <summary>
    /// 活动资讯
    /// </summary>
    public class Active
    {
        public int Id { get; set; }

        public int SellerId { get; set; }

        public int CoverImgId { get; set; }

        public string Title { get; set; }

        public string Summary { get; set; }

        public DateTime CreateTime { get; set; }
        
    }
}