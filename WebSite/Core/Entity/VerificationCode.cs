using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Entity
{
    /// <summary>
    /// 注册验证码表
    /// </summary>
    public class VerificationCode : KVEntity
    {
        /// <summary>
        /// 联系方式
        /// </summary>
        public string Phone { get; set; }
        /// <summary>
        /// 商户id
        /// </summary>
        public int SellerId { get; set; }
        /// <summary>
        /// 验证码
        /// </summary>
        public string Code { get; set; }
        /// <summary>
        /// 过期时间
        /// </summary>
        public DateTime ExpiredTime { get; set; }

        public VerificationCode()
        {
            ExpiredTime = DateTime.MinValue;
            Code = string.Empty;
            Phone = string.Empty;
        }
    }
}