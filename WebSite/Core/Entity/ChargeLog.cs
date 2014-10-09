using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Entity
{
    /// <summary>
    /// 充值消费记录表
    /// </summary>
    public class ChargeLog : KVEntity
    {
        /// <summary>
        /// 会员id
        /// </summary>
        public int UserId { get; set; }
        /// <summary>
        /// 充值余额
        /// </summary>
        public float Money { get; set; }
        /// <summary>
        /// 充值类型
        /// </summary>
        public int Pid { get; set; }
        /// <summary>
        /// 充值记录：第三方充值流水号，消费记录：订单表的id
        /// </summary>
        public string OrderId { get; set; }
        /// <summary>
        /// 商户id
        /// </summary>
        public int SellerId { get; set; }
        /// <summary>
        /// 充值类型名称
        /// </summary>
        public string PayName { get; set; }
        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime CreateTime { get; set; }

        /// <summary>
        /// 充值状态 0：充值请求、10：充值成功、-1：充值失败
        /// </summary>
        public RechargeStatus Status { get; set; }

        /// <summary>
        /// 更新状态时间
        /// </summary>
        public DateTime UpdateStatusTime { get; set; }
        /// <summary>
        /// 订单关联的商品数量总数——用于直接查询
        /// </summary>
        public int Num { get; set; }
        /// <summary>
        /// 订单关联的商品id列表
        /// </summary>
        public List<int> GidList { get; set; }
        /// <summary>
        /// 订单关联的商品数量列表
        /// </summary>
        public List<int> NumList { get; set; }

        public ChargeLog()
        {
            CreateTime = DateTime.Now;
            UpdateStatusTime = Utility.UnixEpochDateTime;
            Status = RechargeStatus.Request;

            GidList = new List<int>();
            NumList = new List<int>();
        }
    }

    /// <summary>
    /// 充值统计界面需要下发的数据
    /// </summary>
    public class ReqChargeStatItem
    {
        /// <summary>
        /// 用户id
        /// </summary>
        public int UserId { get; set; }
        /// <summary>
        /// 总充值金额
        /// </summary>
        public double TotalMoney { get; set; }
        /// <summary>
        /// 用户名
        /// </summary>
        public string UserName { get; set; }
        /// <summary>
        /// 所占百分比
        /// </summary>
        public string Pre { get; set; }
    }

    /// <summary>
    /// 消费统计界面需要下发的数据
    /// </summary>
    public class ReqConsumeStatItem
    {
        /// <summary>
        /// 商品名称
        /// </summary>
        public string GoodsName { get; set; }
        /// <summary>
        /// 商品分类名称
        /// </summary>
        public string GoodsCategoriesName { get; set; }
        /// <summary>
        /// 销量
        /// </summary>
        public int Num { get; set; }
        /// <summary>
        /// 所占百分比
        /// </summary>
        public string Pre { get; set; }
    }
}