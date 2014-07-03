using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Entity
{
    /// <summary>
    /// 账号表
    /// </summary>
    public class Account
    {
        public int Id { get; set; }
        /// <summary>
        /// 用户名
        /// </summary>
        public string UserName { get; set; }
        /// <summary>
        /// 登录密码
        /// </summary>
        public string Pwd { get; set; }
        /// <summary>
        /// 角色类型
        /// </summary>
        public RoleType RoleType { get; set; }
        /// <summary>
        /// 测试
        /// </summary>
        public List<int> ServerIds { get; set; }
    }
}