using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Entity
{
    /// <summary>
    /// 商户信息
    /// </summary>
    public class Merchant : KVEntity
    {
        /// <summary>
        /// 商户名称
        /// </summary>
        public string Name { get; set; }
        /// <summary>
        /// 商户名称缩写 用于发送验证码
        /// </summary>
        public string Tname { get; set; }
        /// <summary>
        /// 地址
        /// </summary>
        public string Address { get; set; }
        /// <summary>
        /// 联系方式
        /// </summary>
        public string Phone { get; set; }
        /// <summary>
        /// 简介描述
        /// </summary>
        public string Description { get; set; }
        /// <summary>
        /// 商家地图url（百度地图手机网N站）
        /// </summary>
        public string Mapurl { get; set; }
        /// <summary>
        /// 微信开发者 appid
        /// </summary>
        public int AppId { get; set; }
        /// <summary>
        /// 微信开发者 app密码
        /// </summary>
        public string AppSecret { get; set; }
        /// <summary>
        /// 微信token
        /// </summary>
        public string AccessToken { get; set; }
        /// <summary>
        /// 微信token有效期
        /// </summary>
        public DateTime AccessExpire { get; set; }
        /// <summary>
        /// 安卓下载地址
        /// </summary>
        public string AndroidUrl { get; set; }
        /// <summary>
        /// Ios下载地址
        /// </summary>
        public string IosUrl { get; set; }
        /// <summary>
        /// 关注微信地址
        /// </summary>
        public string WxUrl { get; set; }
    }
}