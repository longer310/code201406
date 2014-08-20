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
        public string AppId { get; set; }
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

        public string PointX { get; set; }

        public string PointY { get; set; }

        /// <summary>
        /// 消费所获积分比例（每元）
        /// </summary>
        public int ReChargeIntegral { get; set; }

        /// <summary>
        /// 消费所获积分比例（每元）
        /// </summary>
        public int ConsumptionIntegral { get; set; }

        /// <summary>
        /// 评论所获积分比例（每条）
        /// </summary>
        public int CommentIntegral { get; set; }

        /// <summary>
        /// 分享所获积分比例（每条）
        /// </summary>
        public int ShareIntegral { get; set; }

        /// <summary>
        /// 运费
        /// </summary>
        public int Freight { get; set; }

        /// <summary>
        /// 满多少免运费
        /// </summary>
        public int NeedToFreeFreight { get; set; }

        /// <summary>
        /// 商户分类id
        /// </summary>
        public int Mid { get; set; }

        /// <summary>
        /// 商户的用户量
        /// </summary>
        public int UserCount { get; set; }

        /// <summary>
        /// 商户模板id
        /// </summary>
        public int Tid { get; set; }

        /// <summary>
        /// 服务时间
        /// </summary>
        public DateTime ServerEndTime { get; set; }

        /// <summary>
        /// 商户logo地址
        /// </summary>
        public string LogoUrl { get; set; }

        /// <summary>
        /// 是否使用易WiFi
        /// </summary>
        public int HasWifi { get; set; }

        /// <summary>
        /// 是否使用云打印
        /// </summary>
        public int HasPrint { get; set; }
        /// <summary>
        /// 管理员联系方式
        /// </summary>
        public string ManagerPhone { get; set; }

        /// <summary>
        /// 服务QQ号码
        /// </summary>
        public string Qq { get; set; }
        /// <summary>
        /// 微信公众号
        /// </summary>
        public string WinXinAccount { get; set; }
        /// <summary>
        /// 邮箱号
        /// </summary>
        public string Email { get; set; }

        /// <summary>
        /// 类名称列表【活动咨询、商品展示、快速预约、图片墙、包厢】
        /// </summary>
        public List<string> CnameList { get; set; }

        /// <summary>
        /// 总营业额
        /// </summary>
        public float Money { get; set; }
    }
}