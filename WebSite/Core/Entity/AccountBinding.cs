using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Entity
{
    /// <summary>
    /// 第三方账号绑定表
    /// </summary>
    public class AccountBinding : KVEntity
    {
        /// <summary>
        /// 第三方账号类型
        /// </summary>
        public AccountType AccountType { get; set; }
        /// <summary>
        /// 第三方账号标识
        /// </summary>
        public string UserIdentity { get; set; }
    }
}