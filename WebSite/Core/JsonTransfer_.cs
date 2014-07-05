using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Backstage.Core
{
    public class JsonTransfer : Tools.Json.JsonTransfer
    {
        /// <summary>
        /// 
        /// </summary>
        public JsonTransfer()
            : base()
        {

        }

        public void AddSuccessParam()
        {
            Add("status", "1");
            Add("message", "返回消息");
        }

        /// <summary>
        /// 默认追加到_contentKey里
        /// </summary>
        /// <param name="content"></param>
        public JsonTransfer(object content)
            : base(content)
        {
        }

        
    }
}
