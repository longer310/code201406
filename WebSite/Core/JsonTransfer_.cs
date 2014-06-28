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
