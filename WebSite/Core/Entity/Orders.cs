using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Entity
{
    /// <summary>
    /// 产品订单
    /// </summary>
    public class Orders : KVEntity
    {
        /// <summary>
        /// 用户id
        /// </summary>
        public int UserId { get; set; }
        /// <summary>
        /// 产品id
        /// </summary>
        //public string Gids { get; set; }
        public List<int> GidList { get; set; }
        /// <summary>
        /// 数量列表
        /// </summary>
        //public string Nums { get; set; }
        public List<int> NumList { get; set; }
        /// <summary>
        /// 产品图片地址
        /// </summary>
        //public string Imgs { get; set; }
        public List<string> ImgList { get; set; }
        /// <summary>
        /// 产品标题列表
        /// </summary>
        //public string Titles { get; set; }
        public List<string> TitleList { get; set; }
        /// <summary>
        /// 产品说明列表
        /// </summary>
        //public string Contents { get; set; }
        public List<string> ContentList { get; set; }
        /// <summary>
        /// 产品现价列表
        /// </summary>
        //public string NowPrices { get; set; }
        public List<float> NowPriceList { get; set; }
        /// <summary>
        /// 产品原价列表
        /// </summary>
        //public string OriginalPrices { get; set; }
        public List<float> OriginalPriceList { get; set; }
        /// <summary>
        /// 最后总价
        /// </summary>
        public float TotalPrice { get; set; }
        /// <summary>
        /// 商品总价
        /// </summary>
        public float StotalPrice { get; set; }
        /// <summary>
        /// 支付方式id
        /// </summary>
        public int Pid { get; set; }
        /// <summary>
        /// 用餐时间
        /// </summary>
        public DateTime OrderTime { get; set; }
        /// <summary>
        /// 就餐类型（到店用餐、送餐）
        /// </summary>
        public OrderType OrderType { get; set; }
        /// <summary>
        /// 就餐人数
        /// </summary>
        public int OrderPeople { get; set; }
        /// <summary>
        /// 电子券id
        /// </summary>
        public int CouponId { get; set; }
        /// <summary>
        /// 电子券标题
        /// </summary>
        public string CouponTitle { get; set; }
        /// <summary>
        /// 电子券优惠价格
        /// </summary>
        public float CtotalPrice { get; set; }
        /// <summary>
        /// 电子券描述
        /// </summary>
        public string Ccontent { get; set; }
        /// <summary>
        /// 送货地址
        /// </summary>
        public string Address { get; set; }
        /// <summary>
        /// 联系人
        /// </summary>
        public string LinkMan { get; set; }
        /// <summary>
        /// 联系方式
        /// </summary>
        public string Mobile { get; set; }
        /// <summary>
        /// 订单创建时间
        /// </summary>
        public DateTime CreateTime { get; set; }
        /// <summary>
        /// 备注
        /// </summary>
        public string Remark { get; set; }
        /// <summary>
        /// 订单状态
        /// </summary>
        public OrderStatus Status { get; set; }
        /// <summary>
        /// 商户id
        /// </summary>
        public int SellerId { get; set; }
        ///// <summary>
        ///// 订单完成可以得到的积分
        ///// </summary>
        //public int Extcredit { get; set; }
        /// <summary>
        /// 所打折扣
        /// </summary>
        public float Discount { get; set; }

        /// <summary>
        /// 包厢号 夜场类 商户才有 包厢名称+包厢类型
        /// </summary>
        public string Boxno { get; set; }

        public Orders()
        {
            //Gids = Nums = Imgs = NowPrices = OriginalPrices = 
            GidList = new List<int>();
            NumList = new List<int>();
            ImgList = new List<string>();
            TitleList = new List<string>();
            ContentList = new List<string>();
            NowPriceList = new List<float>();
            OriginalPriceList = new List<float>();

            Address = LinkMan = Mobile = "";
            CreateTime = DateTime.Now;
            OrderTime = DateTime.Now;
        }

        public ReqOrderStatus GetReqStatus()
        {
            if(OrderType == OrderType.WaitDelivery)
                return ReqOrderStatus.Pay;
            else if (OrderType == OrderType.Deliveryed)
                return ReqOrderStatus.DeliverGoodsed;
            else if (Status == OrderStatus.Pay)
                return ReqOrderStatus.Pay;
            else if (Status == OrderStatus.End)
                return ReqOrderStatus.End;
            else
            {
                if(Status < OrderStatus.Pay)
                    return ReqOrderStatus.NoPay;
                else
                    return ReqOrderStatus.Pay;
            }
        }
    }
}