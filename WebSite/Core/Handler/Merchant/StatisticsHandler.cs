using System;
using System.Collections.Generic;
using System.EnterpriseServices;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Xml.Serialization;
using Backstage.Core;
using Backstage.Core.Entity;
using Backstage.Core.Handler;
using Backstage.Core.Logic;
using Backstage.View.User;

namespace Backstage.Handler
{
    public class StatisticsHandler : BaseHandler
    {
        public override void ProcessRequest(HttpContext context)
        {
            RoleType = RoleType.Merchant;//需商家管理权限 暂定权限管理
            base.ProcessRequest(HttpContext.Current);
            switch (Action)
            {
                #region 充值统计、消费统计
                case "getconsumestat": //获取销售统计
                    GetConsumeStat(); break;
                case "getchargestat": //获取充值统计
                    GetChargeStat(); break;
                #endregion

                default: break;
            }
        }


        #region 充值统计、消费统计
        public class ChargeStatResponse
        {
            public RechargeStatisticsHelper.ReqRechargeStatistics Stat { get; set; }
            public List<ReqChargeStatItem> List { get; set; }

            public ChargeStatResponse()
            {
                Stat = new RechargeStatisticsHelper.ReqRechargeStatistics(StatisticsType.Day);
                List = new List<ReqChargeStatItem>();
            }
        }
        /// <summary>
        /// 获取充值统计
        /// </summary>
        private void GetChargeStat()
        {
            var sellerId = CurSellerId;
            var type = (StatisticsType)GetInt("type");//统计类型
            var start = GetInt("start");//传0
            var limit = GetInt("limit");//传10 只取前十名

            var data = new ChargeStatResponse();
            data.Stat = new RechargeStatisticsHelper.ReqRechargeStatistics(type);
            switch (type)
            {
                case StatisticsType.Day:
                    data.Stat = RechargeStatisticsHelper.GetRechargeDateStatisticsList(sellerId, DateTime.Now); break;
                case StatisticsType.Month:
                    data.Stat = RechargeStatisticsHelper.GetRechargeMonthStatisticsList(sellerId, DateTime.Now.Year, DateTime.Now.Month); break;
                case StatisticsType.Quarter:
                    data.Stat = RechargeStatisticsHelper.GetRechargeQuarterStatisticsList(sellerId, DateTime.Now.Year); break;
                case StatisticsType.Year:
                    data.Stat = RechargeStatisticsHelper.GetRechargeYearStatisticsList(sellerId, DateTime.Now.Year); break;
            }

            var startTime = DateTime.Now;
            var endTime = DateTime.Now;
            switch (type)
            {
                case StatisticsType.Day:
                    startTime = DateTime.Now.Date;
                    endTime = startTime.AddDays(1).AddMilliseconds(-1);
                    break;
                case StatisticsType.Month:
                    startTime = new DateTime(startTime.Year, startTime.Month, 1).Date;
                    endTime = startTime.AddMonths(1).AddMilliseconds(-1);
                    break;
                case StatisticsType.Quarter:
                case StatisticsType.Year:
                    startTime = new DateTime(startTime.Year, 1, 1).Date;
                    endTime = startTime.AddYears(1).AddMilliseconds(-1);
                    break;
            }

            var list = ChargeLogHelper.GetRechargeLogList(CurSellerId, startTime, endTime, start * limit, limit);
            foreach (var chargeLog in list)
            {
                var item = new ReqChargeStatItem();
                item.UserId = chargeLog.UserId;
                item.TotalMoney = chargeLog.TotalMoney;
                item.Phone = chargeLog.Phone;
                item.Pre = (chargeLog.TotalMoney*1.0/data.Stat.TotalMoney*100).ToString("F2");

                data.List.Add(item);
            }

            var jt = new JsonTransfer();
            jt.Add("data", data);
            Response.Write(jt.ToJson());
            Response.End();
        }
        /// <summary>
        /// 获取消费统计
        /// </summary>
        private void GetConsumeStat()
        {
            var sellerId = GetInt("sellerId");
            var index = GetInt("index");
            var size = GetInt("size");
            var goods = GoodsHelper.GetGoodsList(sellerId, "", "order by CreateTime", index * size, size);

            JsonTransfer jt = new JsonTransfer();
            jt.Add("data", goods);
            Response.End();
        }
        #endregion
    }
}
