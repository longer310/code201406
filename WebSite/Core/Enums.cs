using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core
{

    public enum RoleType
    {
        /// <summary>
        /// 超级管理员 拥有所有功能
        /// </summary>
        SuperManage = 1,

        /// <summary>
        /// 一级管理员 不具备转账
        /// </summary>
        Manage = 2,

        /// <summary>
        /// 二级管理员 不具备转账
        /// </summary>
        SecondManage = 3,

        /// <summary>
        /// 商家
        /// </summary>
        User = 10
    }
}