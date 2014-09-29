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
        //WaitDeliverGoods = 3,
        /// <summary>
        /// 已发货
        /// </summary>
        DeliverGoodsed = 3,
        /// <summary>
        /// 已完结（用户完结或者倒计时到了完结）
        /// </summary>
        End = 4,
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
    public enum UploadType
    {
        /// <summary>
        /// 所有
        /// </summary>
        All = 0,

        //-----图片类型-----

        /// <summary>
        /// 图片墙
        /// </summary>
        Img = 101,
        /// <summary>
        /// 活动
        /// </summary>
        Active = 102,
        /// <summary>
        /// 产品
        /// </summary>
        Goods = 103,
        /// <summary>
        /// 商品分类
        /// </summary>
        GoodCategories = 104,
        /// <summary>
        /// 会员
        /// </summary>
        User = 105,
        /// <summary>
        /// 优惠券
        /// </summary>
        Coupon = 106,
        /// <summary>
        /// 商户登录广告设置
        /// </summary>
        MerchantLoginAd = 107,
        /// <summary>
        /// 商户wifi广告设置
        /// </summary>
        MerchantWifiAd = 108,
        /// <summary>
        /// 开发方软件广告设置
        /// </summary>
        PlatformAd = 109,
        /// <summary>
        /// 快捷方式
        /// </summary>
        FastLinks = 110,
        /// <summary>
        /// 快捷方式列表
        /// </summary>
        FastLinksList = 111,
        /// <summary>
        /// 位子管理
        /// </summary>
        Position = 112,




        //-----文件类型-----
        
        /// <summary>
        /// 安装包文件
        /// </summary>
        Package = 200,
    }
    /// <summary>
    /// 商户类型
    /// </summary>
    public enum MerchantTypes
    {
        /// <summary>
        /// 餐饮超市类
        /// </summary>
        Food = 1,
        /// <summary>
        /// 夜场
        /// </summary>
        Night = 2,
        /// <summary>
        /// 企业
        /// </summary>
        Company = 3,
    }

    public enum RechargeStatus
    {
        /// <summary>
        /// 充值失败
        /// </summary>
        Fail = -1,
        /// <summary>
        /// 充值请求
        /// </summary>
        Request = 0,
        /// <summary>
        /// 充值成功
        /// </summary>
        Success = 10,
    }

    public enum MsgTempleId
    {
        /// <summary>
        /// 商户提现模板
        /// 尊敬的【{param1}】商家，您有一笔新的提现，提现金额为：{param2}，我们将于{param3}个工作日处理！如非本人操作请及时联系我们！商微平台官网：{param4}
        /// </summary>
        MerchantWithdraw = 91002183,
        /// <summary>
        /// 订单提醒商户模板
        /// 尊敬的【{param1}】商家，您有笔新的订单已付款，订单号为：{param2}；请及时处理。后台管理地址为{param3}！
        /// </summary>
        OrdersRemindMerchant = 91002182,
        /// <summary>
        /// 新增商户短信通知模板
        /// 尊敬的【{param1}】商家，恭喜您已成为我们平台的签约商户！您的后台管理地址为{param2}，登陆名：{param3}；默认初始密码为：{param4},请及时登陆修改密码！如有问题请联系我们客服，易微平台官网：{param5}
        /// </summary>
        AddMerchant = 91002181,
        /// <summary>
        /// 预订位置模板
        /// 【{param4}】提醒您！您{param3}手机号于{param1}预定的{param2}已经成功。我们为您预留15分钟，请您准时到店！
        /// </summary>
        ScheduledLocation = 91002180,
        /// <summary>
        /// 会员修改密码模板
        /// 【{param4}】尊敬的{param1}用户，您本次修改密码的验证码为{param2}，本验证码{param3}分钟内有效，如非本人操作，仅及时修改密码！
        /// </summary>
        UserModifyPwd = 91002179,
        /// <summary>
        /// 订单完成提醒模板
        /// 【{param4}】提醒您！您{param3}手机号于{param1}预定的{param2}已经成功。我们为您预留15分钟，请您准时到店！
        /// </summary>
        OrdersFinish = 91002178,
        /// <summary>
        /// 会员注册验证码模板
        /// 您的注册验证码为{param2}，本验证码{param3}分钟内有效，【{param1}】感谢您的使用
        /// </summary>
        UserRegisterCode = 91002177,
        /// <summary>
        /// 会员更改绑定号码模板
        /// 您的验证码为{param2}，此验证码仅用于更改绑定号码，本验证码{param3}分钟内有效。【{param1}】感谢您的使用！
        /// </summary>
        UserModifyPhone = 91002176,
    }

    public enum StatisticsType
    {
        /// <summary>
        /// 日统计
        /// </summary>
        Day = 0,
        /// <summary>
        /// 月统计
        /// </summary>
        Month = 1,
        /// <summary>
        /// 季度统计
        /// </summary>
        Quarter = 2,
        /// <summary>
        /// 年统计
        /// </summary>
        Year = 3,
    }
}