using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Entity
{
    public class Position
    {
        public int Id { get; set; }

        //public int ImgId { get; set; }

        public int BoxTypeId { get; set; }

        /// <summary>
        /// 多个url,","相隔
        /// </summary>
        public string ImgUrls { get; set; }

        public string Title { get; set; }

        public float Price { get; set; }

        public string Description { get; set; }

        public string Phone { get; set; }

        public int Status { get; set; }

        public int SellerId { get; set; }

    }
}