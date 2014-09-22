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
                case "getconsumelist": //获取销售列表
                    GetConsumeList(); break;
                case "getchargestat": //获取充值统计
                    GetChargeStat(); break;
                case "getchargelist": //获取充值列表
                    GetChargeList(); break;
                #endregion

                default: break;
            }
        }


        #region 充值统计、消费统计
        /// <summary>
        /// 获取充值列表
        /// </summary>
        private void GetChargeList()
        {
            var start = GetInt("start");
            var limit = GetInt("limit");
            var type = (StatisticsType)GetInt("type");//统计类型
            var startTime = DateTime.Now;
            var endTime = DateTime.Now;
            switch (type)
            {
                case StatisticsType.Day:
                    startTime = DateTime.Now.Date;
                    endTime = startTime.AddDays(1).AddMilliseconds(-1);
                    break;
                case StatisticsType.Month:
                    startTime = new DateTime(startTime.Year,startTime.Month,1).Date;
                    endTime = startTime.AddMonths(1).AddMilliseconds(-1);
                    break;
                case StatisticsType.Quarter:
                case StatisticsType.Year:
                    startTime = new DateTime(startTime.Year, 1, 1).Date;
                    endTime = startTime.AddYears(1).AddMilliseconds(-1);
                    break;
            }

            var result = ChargeLogHelper.GetRechargeLogList(CurSellerId, startTime, endTime, start*limit, limit);

            var jt = new JsonTransfer();
            jt.Add("list", result.Results);
            jt.Add("count", result.TotalCount);
            Response.Write(jt.ToJson());
        }

        /// <summary>
        /// 获取充值统计
        /// </summary>
        private void GetChargeStat()
        {
            var sellerId = CurSellerId;
            var type = (StatisticsType)GetInt("type");//统计类型

            //var result = new RechargeStatisticsHelper.ReqRechargeStatistics(type);
            //switch (type)
            //{
            //    case StatisticsType.Day:
            //        result = RechargeStatisticsHelper.GetRechargeDateStatisticsList(sellerId, DateTime.Now); break;
            //    case StatisticsType.Month:
            //        result = RechargeStatisticsHelper.GetRechargeMonthStatisticsList(sellerId, DateTime.Now.Year, DateTime.Now.Month); break;
            //    case StatisticsType.Quarter:
            //        result = RechargeStatisticsHelper.GetRechargeQuarterStatisticsList(sellerId, DateTime.Now.Year); break;
            //    case StatisticsType.Year:
            //        result = RechargeStatisticsHelper.GetRechargeYearStatisticsList(sellerId, DateTime.Now.Year); break;
            //}

            //var jt = new JsonTransfer();
            //jt.Add("data", result);
            //Response.Write(jt.ToJson());
            //Response.End();
        }

        /// <summary>
        /// 获取消费列表
        /// </summary>
        private void GetConsumeList()
        {
            var start = GetInt("start");
            var limit = GetInt("limit");
            var sellerId = GetInt("sellerId");
            var type = (StatisticsType)GetInt("type");//统计类型
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
