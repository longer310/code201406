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

        /// <summary>
        /// 包厢号
        /// </summary>
        public string BoxNumber { get; set; }

        public float Price { get; set; }

        public string Description { get; set; }

        public string Phone { get; set; }

        /// <summary>
        /// 0:未预定，1：已预定，2:占用
        /// </summary>
        public int Status { get; set; }

        public int SellerId { get; set; }

        public DateTime CreateTime { get; set; }


        /// <summary>
        /// 冗余（不存数据库）
        /// </summary>
        public string BoxTypeTitle { get; set; }

    }
}