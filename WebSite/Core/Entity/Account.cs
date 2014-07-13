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
        public int Extcredit { get; set; }

        public Account()
        {
            Avatar = Utility._userdefaulthead;
            Phone = Address = "";
            CreateTime = DateTime.Now;
        }
    }
}