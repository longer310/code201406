using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Entity
{
    /// <summary>
    /// 支付方式表
    /// </summary>
    public class Payment:KVEntity
    {
        /// <summary>
        /// 名称
        /// </summary>
        public string Name { get; set; }
        /// <summary>
        /// 描述
        /// </summary>
        public string Description { get; set; }
        /// <summary>
        /// 支付图片url
        /// </summary>
        public string ImgUrl { get; set; }
        /// <summary>
        /// 支付用户账户
        /// </summary>
        public string Account { get; set; }
        /// <summary>
        /// 私钥KEY
        /// </summary>
        public string PrivateKey { get; set; }
        /// <summary>
        /// PID
        /// </summary>
        public string Pid { get; set; }
        /// <summary>
        /// 支付宝账号类型
        /// </summary>
        public int AccountType { get; set; }
        /// <summary>
        /// 支付状态 0：未启用 1：启用
        /// </summary>
        public int Status { get; set; }
    }
}