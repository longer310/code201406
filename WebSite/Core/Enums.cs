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

        /// <summary>
        /// 第三方用户
        /// </summary>
        ThirdUser = 30,
    }

    /// <summary>
    /// 1、图片，2、资讯，3、产品、4、优惠券
    /// </summary>
    public enum CommentType
    {
        /// <summary>
        /// 所有
        /// </summary>
        All = 0,
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

    /// <summary>
    /// 第三方账号类型
    /// </summary>
    public enum AccountType
    {
        /// <summary>
        /// 微信
        /// </summary>
        WeiXin = 1,
        /// <summary>
        /// 新浪
        /// </summary>
        Sina = 2,
        /// <summary>
        /// 腾讯
        /// </summary>
        Tencent = 3,
        /// <summary>
        /// 支付宝
        /// </summary>
        Paypal = 4,
    }

    /// <summary>
    /// 积分来源/去向类型
    /// </summary>
    public enum ExtcreditSourceType
    {
        /// <summary>
        /// 购买优惠券
        /// </summary>
        BuyCoupon = 1,
        /// <summary>
        /// 充值
        /// </summary>
        Charge = 2,
        /// <summary>
        /// 签到——限制每天一次
        /// </summary>
        Register = 3,
        /// <summary>
        /// 消费 订单
        /// </summary>
        Consume = 4,

        /// <summary>
        /// 分享商品——限制每个平台每个商品能获得积分只有第一次分享
        /// </summary>
        ShareGoods = 11,
        /// <summary>
        /// 分享活动——同上
        /// </summary>
        ShareActive = 12,
        /// <summary>
        /// 分享图片墙——同上
        /// </summary>
        ShareImg = 13,

        /// <summary>
        /// 评论商品——限制每个商品能获得积分只有第一次评论
        /// </summary>
        CommentGoods = 21,
        /// <summary>
        /// 评论活动——同上
        /// </summary>
        CommentActive = 22,
        /// <summary>
        /// 评论图片墙——同上
        /// </summary>
        CommentImg = 23,
    }

    /// <summary>
    /// 1、图片，2、资讯，3、产品
    /// </summary>
    public enum ShareType
    {
        /// <summary>
        /// 所有
        /// </summary>
        All = 0,
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
        /// 评论
        /// </summary>
        Comment = 4,
    }

    public enum PlatformType
    {
        /// <summary>
        /// 无
        /// </summary>
        None = 0,
        /// <summary>
        /// 微信
        /// </summary>
        WeiXin = 1,
        /// <summary>
        /// 新浪
        /// </summary>
        Sina = 2,
        /// <summary>
        /// 腾讯Qzone
        /// </summary>
        Qzone = 3,
        /// <summary>
        /// 腾讯微博
        /// </summary>
        TencentMico = 4,
    }
}