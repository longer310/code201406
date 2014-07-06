using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Model
{
    /// <summary>
    /// 操作类接口返回值
    /// </summary>
    public class StatusMessage
    {
        /// <summary>
        /// 1:成功，0：失败
        /// </summary>
        public int Status { get; set; }

        /// <summary>
        /// 消息
        /// </summary>
        public string Message { get; set; }
    }
}