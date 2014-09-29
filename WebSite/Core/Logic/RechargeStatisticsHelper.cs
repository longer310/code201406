using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Compilation;
using Backstage.Core.Entity;
using Backstage.Model;
using MySql.Data.MySqlClient;

namespace Backstage.Core.Logic
{
    public static class RechargeStatisticsHelper
    {
        public class ReqRechargeStatistics
        {
            /// <summary>
            /// x轴点集合
            /// </summary>
            public List<int> Xvalues { get; set; }
            /// <summary>
            /// y轴点集合
            /// </summary>
            public List<float> Yvalues { get; set; }
            /// <summary>
            /// 总充值金额 
            /// </summary>
            public float TotalMoney { get; set; }
            /// <summary>
            /// 最高单笔充值 
            /// </summary>
            public float MaxSingleMoney { get; set; }
            /// <summary>
            /// 充值人数 
            /// </summary>
            public int UserCount { get; set; }
            /// <summary>
            /// 环比-总充值金额 
            /// </summary>
            public float LTotalMoney { get; set; }
            /// <summary>
            /// 环比-最高单笔充值 
            /// </summary>
            public float LMaxSingleMoney { get; set; }
            /// <summary>
            /// 环比-充值人数 
            /// </summary>
            public int LUserCount { get; set; }

            public string LTotalMoneyPre
            {
                get
                {
                    var dif = TotalMoney - LTotalMoney;
                    var pre = (int)(dif * 1.0 / LTotalMoney * 100);
                    if (pre > 0) return "+" + pre + "%";
                    else if (pre < 0) return "-" + pre + "%";
                    else return pre + "%";
                }
            }
            public string LMaxSingleMoneyPre
            {
                get
                {
                    var dif = MaxSingleMoney - LMaxSingleMoney;
                    var pre = (int)(dif * 1.0 / LMaxSingleMoney * 100);
                    if (pre > 0) return "+" + pre + "%";
                    else if (pre < 0) return "-" + pre + "%";
                    else return pre + "%";
                }
            }

            public string LUserCountPre
            {
                get
                {
                    var dif = UserCount - LUserCount;
                    var pre = (int)(dif * 1.0 / LUserCount * 100);
                    if (pre > 0) return "+" + pre + "%";
                    else if (pre < 0) return "-" + pre + "%";
                    else return pre + "%";
                }
            }

            public ReqRechargeStatistics(StatisticsType type)
            {
                Xvalues = new List<int>();
                Yvalues = new List<float>();
                var start = 0;
                var end = 1;
                switch (type)
                {
                    case StatisticsType.Day:
                        start = 0;
                        end = 23;
                        break;
                    case StatisticsType.Month:
                        start = 1;
                        end = 31;
                        break;
                    case StatisticsType.Quarter:
                        start = 1;
                        end = 4;
                        break;
                    case StatisticsType.Year:
                        start = 1;
                        end = 12;
                        break;
                }
                for (int i = start; i <= end; i++)
                {
                    Xvalues.Add(i);
                    Yvalues.Add(0);
                }
            }
        }

        /// <summary>
        /// 获取日充值统计
        /// </summary>
        /// <param name="sellerId"></param>
        /// <param name="dateTime"></param>
        /// <returns></returns>
        public static ReqRechargeStatistics GetRechargeDateStatisticsList(int sellerId, DateTime dateTime)
        {
            var result = new ReqRechargeStatistics(StatisticsType.Day);
            var cmdText =
                @"select * from RechargeDateStatistics where SellerId=?SellerId and Year=?Year and Month=?Month and Day=?Day;select sum(money) totalmoney,max(money) maxmoney,count(DISTINCT userid) usercount from chargelog where money>0 and `Status` =10 and SellerId=?SellerId and CreateTime>?lStartTime and CreateTime<?lEndTime;select sum(money) totalmoney,max(money) maxmoney,count(DISTINCT userid) usercount from chargelog where money>0 and `Status` =10 and SellerId=?SellerId and CreateTime>?StartTime and CreateTime<?EndTime;";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?SellerId", sellerId));
            parameters.Add(new MySqlParameter("?Year", dateTime.Year));
            parameters.Add(new MySqlParameter("?Month", dateTime.Month));
            parameters.Add(new MySqlParameter("?Day", dateTime.Day));

            var lastDay = dateTime.AddDays(-1);
            parameters.Add(new MySqlParameter("?lStartTime", lastDay.Date));
            parameters.Add(new MySqlParameter("?lEndTime", lastDay.Date.AddDays(1).AddMilliseconds(-1)));

            parameters.Add(new MySqlParameter("?StartTime", dateTime.Date));
            parameters.Add(new MySqlParameter("?EndTime", dateTime.Date.AddDays(1).AddMilliseconds(-1)));

            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    DataSet dataSet = MySqlHelper.ExecuteDataset(conn, CommandType.Text, cmdText, parameters.ToArray());
                    if (dataSet.Tables.Count > 0 && dataSet.Tables[0].Rows.Count > 0)
                    {
                        result.Yvalues[0] = (float)dataSet.Tables[0].Rows[0]["Interval0"];
                        result.Yvalues[1] = (float)dataSet.Tables[0].Rows[0]["Interval1"];
                        result.Yvalues[2] = (float)dataSet.Tables[0].Rows[0]["Interval2"];
                        result.Yvalues[3] = (float)dataSet.Tables[0].Rows[0]["Interval3"];
                        result.Yvalues[4] = (float)dataSet.Tables[0].Rows[0]["Interval4"];
                        result.Yvalues[5] = (float)dataSet.Tables[0].Rows[0]["Interval5"];
                        result.Yvalues[6] = (float)dataSet.Tables[0].Rows[0]["Interval6"];
                        result.Yvalues[7] = (float)dataSet.Tables[0].Rows[0]["Interval7"];
                        result.Yvalues[8] = (float)dataSet.Tables[0].Rows[0]["Interval8"];
                        result.Yvalues[9] = (float)dataSet.Tables[0].Rows[0]["Interval9"];
                        result.Yvalues[10] = (float)dataSet.Tables[0].Rows[0]["Interval10"];
                        result.Yvalues[11] = (float)dataSet.Tables[0].Rows[0]["Interval11"];
                        result.Yvalues[12] = (float)dataSet.Tables[0].Rows[0]["Interval12"];
                        result.Yvalues[13] = (float)dataSet.Tables[0].Rows[0]["Interval13"];
                        result.Yvalues[14] = (float)dataSet.Tables[0].Rows[0]["Interval14"];
                        result.Yvalues[15] = (float)dataSet.Tables[0].Rows[0]["Interval15"];
                        result.Yvalues[16] = (float)dataSet.Tables[0].Rows[0]["Interval16"];
                        result.Yvalues[17] = (float)dataSet.Tables[0].Rows[0]["Interval17"];
                        result.Yvalues[18] = (float)dataSet.Tables[0].Rows[0]["Interval18"];
                        result.Yvalues[19] = (float)dataSet.Tables[0].Rows[0]["Interval19"];
                        result.Yvalues[20] = (float)dataSet.Tables[0].Rows[0]["Interval20"];
                        result.Yvalues[21] = (float)dataSet.Tables[0].Rows[0]["Interval21"];
                        result.Yvalues[22] = (float)dataSet.Tables[0].Rows[0]["Interval22"];
                        result.Yvalues[23] = (float)dataSet.Tables[0].Rows[0]["Interval23"];
                    }
                    if (dataSet.Tables.Count > 1 && dataSet.Tables[1].Rows.Count > 0)
                    {
                        if (dataSet.Tables[1].Rows[0]["totalmoney"] != DBNull.Value)
                            result.LTotalMoney = (float)dataSet.Tables[1].Rows[0]["totalmoney"];
                        if (dataSet.Tables[1].Rows[0]["maxmoney"] != DBNull.Value)
                            result.LMaxSingleMoney = (float)dataSet.Tables[1].Rows[0]["maxmoney"];
                        if (dataSet.Tables[1].Rows[0]["usercount"] != DBNull.Value)
                            result.LUserCount = (int)dataSet.Tables[1].Rows[0]["usercount"];
                    }
                    if (dataSet.Tables.Count > 2 && dataSet.Tables[2].Rows.Count > 0)
                    {
                        if (dataSet.Tables[2].Rows[0]["totalmoney"] != DBNull.Value)
                            result.TotalMoney = (float)dataSet.Tables[2].Rows[0]["totalmoney"];
                        if (dataSet.Tables[2].Rows[0]["maxmoney"] != DBNull.Value)
                            result.LMaxSingleMoney = (float)dataSet.Tables[2].Rows[0]["maxmoney"];
                        if (dataSet.Tables[2].Rows[0]["usercount"] != DBNull.Value)
                            result.LUserCount = (int)dataSet.Tables[2].Rows[0]["usercount"];
                    }
                }

            }
            catch (System.Exception ex)
            {
                throw;
            }
            return result;
        }

        /// <summary>
        /// 获取月充值统计
        /// </summary>
        /// <param name="sellerId"></param>
        /// <param name="year"></param>
        /// <param name="month"></param>
        /// <returns></returns>
        public static ReqRechargeStatistics GetRechargeMonthStatisticsList(int sellerId, int year, int month)
        {
            var result = new ReqRechargeStatistics(StatisticsType.Month);
            var dateTime = new DateTime(year, month, 1);
            var cmdText =
                @"select * from RechargeDateStatistics where SellerId=?SellerId and Year=?Year and Month=?Month order by Day;select sum(money) totalmoney,max(money) maxmoney,count(DISTINCT userid) usercount from chargelog where money>0 and `Status` =10 and SellerId=?SellerId and CreateTime>?lStartTime and CreateTime<?lEndTime;select sum(money) totalmoney,max(money) maxmoney,count(DISTINCT userid) usercount from chargelog where money>0 and `Status` =10 and SellerId=?SellerId and CreateTime>?StartTime and CreateTime<?EndTime;";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?SellerId", sellerId));
            parameters.Add(new MySqlParameter("?Year", dateTime.Year));
            parameters.Add(new MySqlParameter("?Month", dateTime.Month));

            var lastMonth = dateTime.AddMonths(-1);
            parameters.Add(new MySqlParameter("?lStartTime", lastMonth.Date));
            parameters.Add(new MySqlParameter("?lEndTime", lastMonth.Date.AddMonths(1).AddMilliseconds(-1)));

            parameters.Add(new MySqlParameter("?StartTime", dateTime.Date));
            parameters.Add(new MySqlParameter("?EndTime", dateTime.Date.AddMonths(1).AddMilliseconds(-1)));

            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    DataSet dataSet = MySqlHelper.ExecuteDataset(conn, CommandType.Text, cmdText, parameters.ToArray());
                    if (dataSet.Tables.Count > 0 && dataSet.Tables[0].Rows.Count > 0)
                    {
                        var i = 0;
                        foreach (DataRow row in dataSet.Tables[0].Rows)
                        {
                            result.Yvalues[i] = (float)row["Total"];
                            i++;
                        }
                    }
                    if (dataSet.Tables.Count > 1 && dataSet.Tables[1].Rows.Count > 0)
                    {
                        if (dataSet.Tables[1].Rows[0]["totalmoney"] != DBNull.Value)
                            result.LTotalMoney = (float)dataSet.Tables[1].Rows[0]["totalmoney"];
                        if (dataSet.Tables[1].Rows[0]["maxmoney"] != DBNull.Value)
                            result.LMaxSingleMoney = (float)dataSet.Tables[1].Rows[0]["maxmoney"];
                        if (dataSet.Tables[1].Rows[0]["usercount"] != DBNull.Value)
                            result.LUserCount = (int)dataSet.Tables[1].Rows[0]["usercount"];
                    }
                    if (dataSet.Tables.Count > 2 && dataSet.Tables[2].Rows.Count > 0)
                    {
                        if (dataSet.Tables[2].Rows[0]["totalmoney"] != DBNull.Value)
                            result.TotalMoney = (float)dataSet.Tables[2].Rows[0]["totalmoney"];
                        if (dataSet.Tables[2].Rows[0]["maxmoney"] != DBNull.Value)
                            result.LMaxSingleMoney = (float)dataSet.Tables[2].Rows[0]["maxmoney"];
                        if (dataSet.Tables[2].Rows[0]["usercount"] != DBNull.Value)
                            result.LUserCount = (int)dataSet.Tables[2].Rows[0]["usercount"];
                    }
                }

            }
            catch (System.Exception ex)
            {
                throw;
            }
            return result;
        }

        /// <summary>
        /// 获取季度充值统计
        /// </summary>
        /// <param name="sellerId"></param>
        /// <param name="year"></param>
        /// <returns></returns>
        public static ReqRechargeStatistics GetRechargeQuarterStatisticsList(int sellerId, int year)
        {
            var result = new ReqRechargeStatistics(StatisticsType.Quarter);
            var dateTime = new DateTime(year, 1, 1);
            var cmdText =
                @"select * from RechargeMonthStatistics where SellerId=?SellerId and Year=?Year;select sum(money) totalmoney,max(money) maxmoney,count(DISTINCT userid) usercount from chargelog where money>0 and `Status` =10 and SellerId=?SellerId and CreateTime>?lStartTime and CreateTime<?lEndTime;select sum(money) totalmoney,max(money) maxmoney,count(DISTINCT userid) usercount from chargelog where money>0 and `Status` =10 and SellerId=?SellerId and CreateTime>?StartTime and CreateTime<?EndTime;";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?SellerId", sellerId));
            parameters.Add(new MySqlParameter("?Year", year));

            var lastYear = dateTime.AddYears(-1);
            parameters.Add(new MySqlParameter("?lStartTime", lastYear.Date));
            parameters.Add(new MySqlParameter("?lEndTime", lastYear.Date.AddYears(1).AddMilliseconds(-1)));

            parameters.Add(new MySqlParameter("?StartTime", dateTime.Date));
            parameters.Add(new MySqlParameter("?EndTime", dateTime.Date.AddYears(1).AddMilliseconds(-1)));
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    DataSet dataSet = MySqlHelper.ExecuteDataset(conn, CommandType.Text, cmdText, parameters.ToArray());
                    if (dataSet.Tables.Count > 0 && dataSet.Tables[0].Rows.Count > 0)
                    {
                        result.Yvalues[0] = (float)dataSet.Tables[0].Rows[0]["Month1"];
                        result.Yvalues[0] += (float)dataSet.Tables[0].Rows[0]["Month2"];
                        result.Yvalues[0] += (float)dataSet.Tables[0].Rows[0]["Month3"];

                        result.Yvalues[1] = (float)dataSet.Tables[0].Rows[0]["Month4"];
                        result.Yvalues[1] += (float)dataSet.Tables[0].Rows[0]["Month5"];
                        result.Yvalues[1] += (float)dataSet.Tables[0].Rows[0]["Month6"];

                        result.Yvalues[2] = (float)dataSet.Tables[0].Rows[0]["Month7"];
                        result.Yvalues[2] += (float)dataSet.Tables[0].Rows[0]["Month8"];
                        result.Yvalues[2] += (float)dataSet.Tables[0].Rows[0]["Month9"];

                        result.Yvalues[3] = (float)dataSet.Tables[0].Rows[0]["Month10"];
                        result.Yvalues[3] += (float)dataSet.Tables[0].Rows[0]["Month11"];
                        result.Yvalues[3] += (float)dataSet.Tables[0].Rows[0]["Month12"];
                    }
                    if (dataSet.Tables.Count > 1 && dataSet.Tables[1].Rows.Count > 0)
                    {
                        if (dataSet.Tables[1].Rows[0]["totalmoney"] != DBNull.Value)
                            result.LTotalMoney = (float)dataSet.Tables[1].Rows[0]["totalmoney"];
                        if (dataSet.Tables[1].Rows[0]["maxmoney"] != DBNull.Value)
                            result.LMaxSingleMoney = (float)dataSet.Tables[1].Rows[0]["maxmoney"];
                        if (dataSet.Tables[1].Rows[0]["usercount"] != DBNull.Value)
                            result.LUserCount = (int)dataSet.Tables[1].Rows[0]["usercount"];
                    }
                    if (dataSet.Tables.Count > 2 && dataSet.Tables[2].Rows.Count > 0)
                    {
                        if (dataSet.Tables[2].Rows[0]["totalmoney"] != DBNull.Value)
                            result.TotalMoney = (float)dataSet.Tables[2].Rows[0]["totalmoney"];
                        if (dataSet.Tables[2].Rows[0]["maxmoney"] != DBNull.Value)
                            result.LMaxSingleMoney = (float)dataSet.Tables[2].Rows[0]["maxmoney"];
                        if (dataSet.Tables[2].Rows[0]["usercount"] != DBNull.Value)
                            result.LUserCount = (int)dataSet.Tables[2].Rows[0]["usercount"];
                    }
                }

            }
            catch (System.Exception ex)
            {
                throw;
            }
            return result;
        }

        /// <summary>
        /// 获取年充值统计
        /// </summary>
        /// <param name="sellerId"></param>
        /// <param name="year"></param>
        /// <returns></returns>
        public static ReqRechargeStatistics GetRechargeYearStatisticsList(int sellerId, int year)
        {
            var result = new ReqRechargeStatistics(StatisticsType.Year);
            var dateTime = new DateTime(year, 1, 1);
            var cmdText =
                @"select * from RechargeMonthStatistics where SellerId=?SellerId and Year=?Year;select sum(money) totalmoney,max(money) maxmoney,count(DISTINCT userid) usercount from chargelog where money>0 and `Status` =10 and SellerId=?SellerId and CreateTime>?lStartTime and CreateTime<?lEndTime;select sum(money) totalmoney,max(money) maxmoney,count(DISTINCT userid) usercount from chargelog where money>0 and `Status` =10 and SellerId=?SellerId and CreateTime>?StartTime and CreateTime<?EndTime;";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?SellerId", sellerId));
            parameters.Add(new MySqlParameter("?Year", year));

            var lastYear = dateTime.AddYears(-1);
            parameters.Add(new MySqlParameter("?lStartTime", lastYear.Date));
            parameters.Add(new MySqlParameter("?lEndTime", lastYear.Date.AddYears(1).AddMilliseconds(-1)));

            parameters.Add(new MySqlParameter("?StartTime", dateTime.Date));
            parameters.Add(new MySqlParameter("?EndTime", dateTime.Date.AddYears(1).AddMilliseconds(-1)));
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    DataSet dataSet = MySqlHelper.ExecuteDataset(conn, CommandType.Text, cmdText, parameters.ToArray());
                    if (dataSet.Tables.Count > 0 && dataSet.Tables[0].Rows.Count > 0)
                    {
                        result.Yvalues[0] = (float)dataSet.Tables[0].Rows[0]["Month1"];
                        result.Yvalues[1] = (float)dataSet.Tables[0].Rows[0]["Month1"];
                        result.Yvalues[2] = (float)dataSet.Tables[0].Rows[0]["Month2"];
                        result.Yvalues[3] = (float)dataSet.Tables[0].Rows[0]["Month3"];
                        result.Yvalues[4] = (float)dataSet.Tables[0].Rows[0]["Month4"];
                        result.Yvalues[5] = (float)dataSet.Tables[0].Rows[0]["Month5"];
                        result.Yvalues[6] = (float)dataSet.Tables[0].Rows[0]["Month6"];
                        result.Yvalues[7] = (float)dataSet.Tables[0].Rows[0]["Month7"];
                        result.Yvalues[8] = (float)dataSet.Tables[0].Rows[0]["Month8"];
                        result.Yvalues[9] = (float)dataSet.Tables[0].Rows[0]["Month9"];
                        result.Yvalues[10] = (float)dataSet.Tables[0].Rows[0]["Month10"];
                        result.Yvalues[11] = (float)dataSet.Tables[0].Rows[0]["Month11"];
                    }
                    if (dataSet.Tables.Count > 1 && dataSet.Tables[1].Rows.Count > 0)
                    {
                        if (dataSet.Tables[1].Rows[0]["totalmoney"] != DBNull.Value)
                            result.LTotalMoney = (float)dataSet.Tables[1].Rows[0]["totalmoney"];
                        if (dataSet.Tables[1].Rows[0]["maxmoney"] != DBNull.Value)
                            result.LMaxSingleMoney = (float)dataSet.Tables[1].Rows[0]["maxmoney"];
                        if (dataSet.Tables[1].Rows[0]["usercount"] != DBNull.Value)
                            result.LUserCount = (int)dataSet.Tables[1].Rows[0]["usercount"];
                    }
                    if (dataSet.Tables.Count > 2 && dataSet.Tables[2].Rows.Count > 0)
                    {
                        if (dataSet.Tables[2].Rows[0]["totalmoney"] != DBNull.Value)
                            result.TotalMoney = (float)dataSet.Tables[2].Rows[0]["totalmoney"];
                        if (dataSet.Tables[2].Rows[0]["maxmoney"] != DBNull.Value)
                            result.LMaxSingleMoney = (float)dataSet.Tables[2].Rows[0]["maxmoney"];
                        if (dataSet.Tables[2].Rows[0]["usercount"] != DBNull.Value)
                            result.LUserCount = (int)dataSet.Tables[2].Rows[0]["usercount"];
                    }
                }

            }
            catch (System.Exception ex)
            {
                throw;
            }
            return result;
        }
    }
}