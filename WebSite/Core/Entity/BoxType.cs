using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Entity
{
    public class BoxType
    {
        public int Id { get; set; }


        /// <summary>
        /// 商家Id
        /// </summary>
        public int SellerId { get; set; }

        public string Title { get; set; }

        /// <summary>
        /// 最低消费
        /// </summary>
        public int Lowest { get; set; }

        /// <summary>
        /// 可以容纳人数
        /// </summary>
        public int HoldNum { get; set; }

        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime CreateTime { get; set; }

    }
}