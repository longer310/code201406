using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Entity
{
    public class UserPosition
    {
        public int Id { get; set; }

        public int UserId { get; set; }

        public int PositionId { get; set; }

        public int SellerId { get; set; }

        public int PayId { get; set; }

        public DateTime CreateTime { get; set; }

        public string Phone { get; set; }

        public string Message { get; set; }

        public string NickName { get; set; }

        /// <summary>
        /// 订单状态（1：预定成功，2：已经到店，-1：取消订单）
        /// </summary>
        public int Status { get; set; }

        public int TimeId { get; set; }
    }
}