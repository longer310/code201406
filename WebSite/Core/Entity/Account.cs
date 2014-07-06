using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Entity
{
    /// <summary>
    /// 账号表
    /// </summary>
    public class Account : KVEntity
    {
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
        /// 头像url
        /// </summary>
        public string Avatar { get; set; }
        /// <summary>
        /// 性别
        /// </summary>
        public int Sex { get; set; }
        /// <summary>
        /// 创建时间或者修改时间
        /// </summary>
        public DateTime CreateTime { get; set; }
    }
}