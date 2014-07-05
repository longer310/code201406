using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Model
{

    /// <summary>
    /// 活动资讯
    /// </summary>
    public class Active
    {
        public int Id { get; set; }

        public int SellerId { get; set; }

        public int Views { get; set; }

        public int Commentnum { get; set; }

        public string Title { get; set; }

        public string Url { get; set; }

        public string Content { get; set; }

        public DateTime CreateTime { get; set; }
        
    }
}