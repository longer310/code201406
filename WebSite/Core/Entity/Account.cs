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
        /// 性别 0/1 男/女
        /// </summary>
        public SexType Sex { get; set; }
        /// <summary>
        /// 创建时间或者修改时间
        /// </summary>
        public DateTime CreateTime { get; set; }
        /// <summary>
        /// 联系人
        /// </summary>
        public string LinkMan { get; set; }
        /// <summary>
        /// 地址
        /// </summary>
        public string Address { get; set; }
        /// <summary>
        /// 联系方式
        /// </summary>
        public string Phone { get; set; }
        /// <summary>
        /// 商户id
        /// </summary>
        public int SellerId { get; set; }
        /// <summary>
        /// 余额
        /// </summary>
        public float Money { get; set; }
        /// <summary>
        /// 积分
        /// </summary>
        public int Integral { get; set; }
        /// <summary>
        /// 昵称
        /// </summary>
        public string NickName { get; set; }
        /// <summary>
        /// 注册时间
        /// </summary>
        public DateTime RegisterTime { get; set; }
        /// <summary>
        /// 最后一次登录时间
        /// </summary>
        public DateTime LastLoginTime { get; set; }
        /// <summary>
        /// 可享受的折扣
        /// </summary>
        public float Discount { get; set; }
        /// <summary>
        /// 总充值
        /// </summary>
        public float TotalRecharge { get; set; }
        /// <summary>
        /// 总消费
        /// </summary>
        public float TotalConsume { get; set; }
        /// <summary>
        /// 状态 0：正常 -1：已删除
        /// </summary>
        public int Status { get; set; }
        /// <summary>
        /// 总登录次数
        /// </summary>
        public int TotalLoginCount { get; set; }
        /// <summary>
        /// 总订单数
        /// </summary>
        public int TotalOrdersCount { get; set; }
        /// <summary>
        /// 会员备注
        /// </summary>
        public string Remark { get; set; }

        public Account()
        {
            if (string.IsNullOrEmpty(Avatar)) Avatar = Utility._userdefaulthead;
            if (string.IsNullOrEmpty(Phone)) Phone = "";
            if (string.IsNullOrEmpty(Address)) Address = "";
            if (string.IsNullOrEmpty(LinkMan)) LinkMan = "";
            if (string.IsNullOrEmpty(NickName)) NickName = "";
            CreateTime = DateTime.Now;
            Discount = 10;//默认不打折
        }

        public void Concume(float price)
        {
            Money -= price;
            TotalConsume += price;
            TotalOrdersCount++;//完成付款的订单数

            //添加到该商户
            if (SellerId > 0)
            {
                var merchant = AccountHelper.GetUser(SellerId);
                if (merchant != null)
                {
                    merchant.Money += price;
                    AccountHelper.UpdateUser(merchant);
                }
            }
        }
    }
}