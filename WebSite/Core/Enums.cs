using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core
{
    /// <summary>
    /// 数值越小 权限越大
    /// </summary>
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
        /// 商家
        /// </summary>
        Merchant = 10,

        /// <summary>
        /// 普通会员
        /// </summary>
        User = 20,

        /// <summary>
        /// 高级会员
        /// </summary>
        User1 = 21,

        /// <summary>
        /// 超级会员
        /// </summary>
        User2 = 22,

        /// <summary>
        /// 第三方会员
        /// </summary>
        ThirdUser = 30,

        /// <summary>
        /// 第三方高级会员
        /// </summary>
        ThirdUser1 = 31,

        /// <summary>
        /// 第三方超级会员
        /// </summary>
        ThirdUser2 = 32,
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
    public static class EnumHelper
    {
        public static string CommentTypeToName(CommentType type)
        {
            switch (type)
            {
                case CommentType.Avtive:
                    return "活动";
                case CommentType.Coupons:
                    return "电子券";
                case CommentType.Goods:
                    return "商品";
                case CommentType.Img:
                    return "图片";
                default: return "";
            }
        }

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
        /// 待送餐
        /// </summary>
        WaitDelivery = 1,

        /// <summary>
        /// 已送餐
        /// </summary>
        Deliveryed = 2,
    }

    public enum OrderStatus
    {
        /// <summary>
        /// 新建
        /// </summary>
        New = 0,
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
        End = 10,


        /// <summary>
        /// 取消订单
        /// </summary>
        Cancel = -1,
    }

    /// <summary>
    /// 页面请求订单状态
    /// </summary>
    public enum ReqOrderStatus
    {
        /// <summary>
        /// 所有
        /// </summary>
        All = 0,
        /// <summary>
        /// 未付款
        /// </summary>
        NoPay = 1,
        /// <summary>
        /// 已付款
        /// </summary>
        Pay = 2,
        /// <summary>
        /// 待发货
        /// </summary>
        WaitDeliverGoods = 3,
        /// <summary>
        /// 已发货
        /// </summary>
        DeliverGoodsed = 4,
        /// <summary>
        /// 已完结（用户完结或者倒计时到了完结）
        /// </summary>
        End = 5,
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
        /// <summary>
        /// 评论优惠卷
        /// </summary>
        CommentCoupon = 24
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

    public enum CouponStatus
    {
        Used = 1,
        UnUse = 0
    }

    /// <summary>
    /// 素材库图片类型 1、图片墙，2、活动，3、产品，4、头像
    /// </summary>
    public enum ImageType
    {
        /// <summary>
        /// 所有
        /// </summary>
        All = 0,
        /// <summary>
        /// 图片墙
        /// </summary>
        Img = 1,
        /// <summary>
        /// 活动
        /// </summary>
        Avtive = 2,
        /// <summary>
        /// 产品
        /// </summary>
        Goods = 3,
        /// <summary>
        /// 头像
        /// </summary>
        Logo = 4
    }
}