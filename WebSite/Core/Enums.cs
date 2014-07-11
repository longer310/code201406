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
        Merchant = 10,

        /// <summary>
        /// 用户
        /// </summary>
        User = 20,
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

    public enum SexType
    {
        /// <summary>
        /// 男
        /// </summary>
        Male = 0,
        /// <summary>
        /// 女
        /// </summary>
        Female = 1
    }

    public enum OrderType
    {
        /// <summary>
        /// 到店用餐
        /// </summary>
        Shop = 0,

        /// <summary>
        /// 送餐
        /// </summary>
        Delivery = 1,
    }

    public enum OrderStatus
    {
        /// <summary>
        /// 新建
        /// </summary>
        New = 0 ,
        /// <summary>
        /// 填写了基本信息，未付款
        /// </summary>
        Update = 1,
        /// <summary>
        /// 已付款
        /// </summary>
        Pay = 2,
        /// <summary>
        /// 已完结（到店吃或者已送餐）
        /// </summary>
        End = 3,
    }
}