using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Entity
{
    public class Fastlinks
    {
        public int Id { get; set; }

        public string Title { get; set; }

        public string Url { get; set; }

        public string ImgUrl { get; set; }

        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime CreateTime { get; set; }
    }
}