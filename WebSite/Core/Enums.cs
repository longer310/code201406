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

    /// <summary>
    /// 1、图片，2、资讯，3、产品、4、优惠券
    /// </summary>
    public enum CommentType
    {
        /// <summary>
        /// 图片
        /// </summary>
        Img = 1,
        /// <summary>
        /// 资讯
        /// </summary>
        Avtive = 2,
        /// <summary>
        /// 产品
        /// </summary>
        Goods = 3,
        /// <summary>
        /// 优惠券
        /// </summary>
        Coupons = 4
    }
}