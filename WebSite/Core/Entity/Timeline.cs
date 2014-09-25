using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Entity
{
    /// <summary>
    /// 包厢时间段
    /// </summary>
    public class Timeline
    {
        public int Id { get; set; }

        public int PositionId { get; set; }

        /// <summary>
        /// 时间段的名称
        /// </summary>
        public string Title { get; set; }
        public DateTime BeginTime { get; set; }

        public DateTime EndTime { get; set; }

        /// <summary>
        /// 日期
        /// </summary>
        public DateTime Date { get; set; }

        /// <summary>
        ///  1：被预定，0：未被预定，2：已经到店
        /// </summary>
        public int Status { get; set; }

        public int SellerId { get; set; }

    }
}