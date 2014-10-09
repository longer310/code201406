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
 //   select sum(abs(money)) totalmoney,sum(num) totalnum,count(*) total,count(DISTINCT userid) totaluser
 //from chargelog where Money<0 and `Status`=10 and OrderId>0;
    public static class ConsumeStatisticsHelper
    {
        public class ReqConsumeStatistics
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
            /// 总消费金额 
            /// </summary>
            public double TotalMoney { get; set; }
            /// <summary>
            /// 销售商品总数 
            /// </summary>
            public int TotalGoodsNum { get; set; }
            /// <summary>
            /// 消费人数 
            /// </summary>
            public int UserCount { get; set; }
            /// <summary>
            /// 订单数量 
            /// </summary>
            public int OrdersNum { get; set; }
            /// <summary>
            /// 总消费金额 
            /// </summary>
            public double LTotalMoney { get; set; }
            /// <summary>
            /// 销售商品总数 
            /// </summary>
            public int LTotalGoodsNum { get; set; }
            /// <summary>
            /// 消费人数 
            /// </summary>
            public int LUserCount { get; set; }
            /// <summary>
            /// 订单数量 
            /// </summary>
            public int LOrdersNum { get; set; }

            public string LTotalMoneyPre
            {
                get
                {
                    if (LTotalMoney <= 0 || TotalMoney <= 0) return "0%";
                    var dif = TotalMoney - LTotalMoney;
                    var pre = (int)(dif * 1.0 / LTotalMoney * 100);
                    if (pre > 0) return "+" + pre + "%";
                    else if (pre < 0) return "-" + pre + "%";
                    else return pre + "%";
                }
            }

            public string LTotalGoodsNumPre
            {
                get
                {
                    if (LTotalGoodsNum <= 0 || TotalGoodsNum <= 0) return "0%";
                    var dif = TotalGoodsNum - LTotalGoodsNum;
                    var pre = (int)(dif * 1.0 / LTotalGoodsNum * 100);
                    if (pre > 0) return "+" + pre + "%";
                    else if (pre < 0) return "-" + pre + "%";
                    else return pre + "%";
                }
            }

            public string LUserCountPre
            {
                get
                {
                    if (LUserCount <= 0 || UserCount <= 0) return "0%";
                    var dif = UserCount - LUserCount;
                    var pre = (int)(dif * 1.0 / LUserCount * 100);
                    if (pre > 0) return "+" + pre + "%";
                    else if (pre < 0) return "-" + pre + "%";
                    else return pre + "%";
                }
            }

            public string LOrdersNumPre
            {
                get
                {
                    if (LOrdersNum <= 0 || OrdersNum <= 0) return "0%";
                    var dif = OrdersNum - LOrdersNum;
                    var pre = (int)(dif * 1.0 / LUserCount * 100);
                    if (pre > 0) return "+" + pre + "%";
                    else if (pre < 0) return "-" + pre + "%";
                    else return pre + "%";
                }
            }

            public ReqConsumeStatistics(StatisticsType type)
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
        /// 获取日消费统计
        /// </summary>
        /// <param name="sellerId"></param>
        /// <param name="dateTime"></param>
        /// <returns></returns>
        public static ReqConsumeStatistics GetConsumeDateStatisticsList(int sellerId, DateTime dateTime)
        {
            var result = new ReqConsumeStatistics(StatisticsType.Day);
            var cmdText =
                @"select * from ConsumeDateStatistics where SellerId=?SellerId and Year=?Year and Month=?Month and Day=?Day;select sum(abs(money)) totalmoney,sum(num) totalgoodsnum,count(*) ordersnum,count(DISTINCT userid) usercount from chargelog where money<0 and orderId>0 and `Status` =10 and SellerId=?SellerId and CreateTime>?lStartTime and CreateTime<?lEndTime;select sum(abs(money)) totalmoney,sum(num) totalgoodsnum,count(*) ordersnum,count(DISTINCT userid) usercount from chargelog where money<0 and orderId>0 and `Status` =10 and SellerId=?SellerId and CreateTime>?StartTime and CreateTime<?EndTime;";

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
                            result.LTotalMoney = Convert.ToDouble(dataSet.Tables[1].Rows[0]["totalmoney"]);
                        if (dataSet.Tables[1].Rows[0]["totalgoodsnum"] != DBNull.Value)
                            result.LTotalGoodsNum = Convert.ToInt32(dataSet.Tables[1].Rows[0]["totalgoodsnum"]);
                        if (dataSet.Tables[1].Rows[0]["usercount"] != DBNull.Value)
                            result.LUserCount = Convert.ToInt32(dataSet.Tables[1].Rows[0]["usercount"]);
                        if (dataSet.Tables[1].Rows[0]["ordersnum"] != DBNull.Value)
                            result.LOrdersNum = Convert.ToInt32(dataSet.Tables[1].Rows[0]["ordersnum"]);
                    }
                    if (dataSet.Tables.Count > 2 && dataSet.Tables[2].Rows.Count > 0)
                    {
                        if (dataSet.Tables[2].Rows[0]["totalmoney"] != DBNull.Value)
                            result.TotalMoney = Convert.ToDouble(dataSet.Tables[2].Rows[0]["totalmoney"]);
                        if (dataSet.Tables[2].Rows[0]["totalgoodsnum"] != DBNull.Value)
                            result.TotalGoodsNum = Convert.ToInt32(dataSet.Tables[2].Rows[0]["totalgoodsnum"]);
                        if (dataSet.Tables[2].Rows[0]["usercount"] != DBNull.Value)
                            result.UserCount = Convert.ToInt32(dataSet.Tables[2].Rows[0]["usercount"]);
                        if (dataSet.Tables[2].Rows[0]["ordersnum"] != DBNull.Value)
                            result.OrdersNum = Convert.ToInt32(dataSet.Tables[2].Rows[0]["ordersnum"]);
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
        /// 获取月消费统计
        /// </summary>
        /// <param name="sellerId"></param>
        /// <param name="year"></param>
        /// <param name="month"></param>
        /// <returns></returns>
        public static ReqConsumeStatistics GetConsumeMonthStatisticsList(int sellerId, int year, int month)
        {
            var result = new ReqConsumeStatistics(StatisticsType.Month);
            var dateTime = new DateTime(year, month, 1);
            var cmdText =
                @"select * from ConsumeDateStatistics where SellerId=?SellerId and Year=?Year and Month=?Month order by Day;select sum(abs(money)) totalmoney,sum(num) totalgoodsnum,count(*) ordersnum,count(DISTINCT userid) usercount from chargelog where money<0 and orderId>0 and `Status` =10 and SellerId=?SellerId and CreateTime>?lStartTime and CreateTime<?lEndTime;select sum(abs(money)) totalmoney,sum(num) totalgoodsnum,count(*) ordersnum,count(DISTINCT userid) usercount from chargelog where money<0 and orderId>0 and `Status` =10 and SellerId=?SellerId and CreateTime>?StartTime and CreateTime<?EndTime;";

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
                            result.LTotalMoney = Convert.ToDouble(dataSet.Tables[1].Rows[0]["totalmoney"]);
                        if (dataSet.Tables[1].Rows[0]["totalgoodsnum"] != DBNull.Value)
                            result.LTotalGoodsNum = Convert.ToInt32(dataSet.Tables[1].Rows[0]["totalgoodsnum"]);
                        if (dataSet.Tables[1].Rows[0]["usercount"] != DBNull.Value)
                            result.LUserCount = Convert.ToInt32(dataSet.Tables[1].Rows[0]["usercount"]);
                        if (dataSet.Tables[1].Rows[0]["ordersnum"] != DBNull.Value)
                            result.LOrdersNum = Convert.ToInt32(dataSet.Tables[1].Rows[0]["ordersnum"]);
                    }
                    if (dataSet.Tables.Count > 2 && dataSet.Tables[2].Rows.Count > 0)
                    {
                        if (dataSet.Tables[2].Rows[0]["totalmoney"] != DBNull.Value)
                            result.TotalMoney = Convert.ToDouble(dataSet.Tables[2].Rows[0]["totalmoney"]);
                        if (dataSet.Tables[2].Rows[0]["totalgoodsnum"] != DBNull.Value)
                            result.TotalGoodsNum = Convert.ToInt32(dataSet.Tables[2].Rows[0]["totalgoodsnum"]);
                        if (dataSet.Tables[2].Rows[0]["usercount"] != DBNull.Value)
                            result.UserCount = Convert.ToInt32(dataSet.Tables[2].Rows[0]["usercount"]);
                        if (dataSet.Tables[2].Rows[0]["ordersnum"] != DBNull.Value)
                            result.OrdersNum = Convert.ToInt32(dataSet.Tables[2].Rows[0]["ordersnum"]);
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
        /// 获取季度消费统计
        /// </summary>
        /// <param name="sellerId"></param>
        /// <param name="year"></param>
        /// <returns></returns>
        public static ReqConsumeStatistics GetConsumeQuarterStatisticsList(int sellerId, int year)
        {
            var result = new ReqConsumeStatistics(StatisticsType.Quarter);
            var dateTime = new DateTime(year, 1, 1);
            var cmdText =
                @"select * from ConsumeMonthStatistics where SellerId=?SellerId and Year=?Year;select sum(abs(money)) totalmoney,sum(num) totalgoodsnum,count(*) ordersnum,count(DISTINCT userid) usercount from chargelog where money<0 and orderId>0 and `Status` =10 and SellerId=?SellerId and CreateTime>?lStartTime and CreateTime<?lEndTime;select sum(abs(money)) totalmoney,sum(num) totalgoodsnum,count(*) ordersnum,count(DISTINCT userid) usercount from chargelog where money<0 and orderId>0 and `Status` =10 and SellerId=?SellerId and CreateTime>?StartTime and CreateTime<?EndTime;";

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
                            result.LTotalMoney = Convert.ToDouble(dataSet.Tables[1].Rows[0]["totalmoney"]);
                        if (dataSet.Tables[1].Rows[0]["totalgoodsnum"] != DBNull.Value)
                            result.LTotalGoodsNum = Convert.ToInt32(dataSet.Tables[1].Rows[0]["totalgoodsnum"]);
                        if (dataSet.Tables[1].Rows[0]["usercount"] != DBNull.Value)
                            result.LUserCount = Convert.ToInt32(dataSet.Tables[1].Rows[0]["usercount"]);
                        if (dataSet.Tables[1].Rows[0]["ordersnum"] != DBNull.Value)
                            result.LOrdersNum = Convert.ToInt32(dataSet.Tables[1].Rows[0]["ordersnum"]);
                    }
                    if (dataSet.Tables.Count > 2 && dataSet.Tables[2].Rows.Count > 0)
                    {
                        if (dataSet.Tables[2].Rows[0]["totalmoney"] != DBNull.Value)
                            result.TotalMoney = Convert.ToDouble(dataSet.Tables[2].Rows[0]["totalmoney"]);
                        if (dataSet.Tables[2].Rows[0]["totalgoodsnum"] != DBNull.Value)
                            result.TotalGoodsNum = Convert.ToInt32(dataSet.Tables[2].Rows[0]["totalgoodsnum"]);
                        if (dataSet.Tables[2].Rows[0]["usercount"] != DBNull.Value)
                            result.UserCount = Convert.ToInt32(dataSet.Tables[2].Rows[0]["usercount"]);
                        if (dataSet.Tables[2].Rows[0]["ordersnum"] != DBNull.Value)
                            result.OrdersNum = Convert.ToInt32(dataSet.Tables[2].Rows[0]["ordersnum"]);
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
        /// 获取年消费统计
        /// </summary>
        /// <param name="sellerId"></param>
        /// <param name="year"></param>
        /// <returns></returns>
        public static ReqConsumeStatistics GetConsumeYearStatisticsList(int sellerId, int year)
        {
            var result = new ReqConsumeStatistics(StatisticsType.Year);
            var dateTime = new DateTime(year, 1, 1);
            var cmdText =
                @"select * from ConsumeMonthStatistics where SellerId=?SellerId and Year=?Year;select sum(abs(money)) totalmoney,sum(num) totalgoodsnum,count(*) ordersnum,count(DISTINCT userid) usercount from chargelog where money<0 and orderId>0 and `Status` =10 and SellerId=?SellerId and CreateTime>?lStartTime and CreateTime<?lEndTime;select sum(abs(money)) totalmoney,sum(num) totalgoodsnum,count(*) ordersnum,count(DISTINCT userid) usercount from chargelog where money<0 and orderId>0 and `Status` =10 and SellerId=?SellerId and CreateTime>?StartTime and CreateTime<?EndTime;";

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
                            result.LTotalMoney = Convert.ToDouble(dataSet.Tables[1].Rows[0]["totalmoney"]);
                        if (dataSet.Tables[1].Rows[0]["totalgoodsnum"] != DBNull.Value)
                            result.LTotalGoodsNum = Convert.ToInt32(dataSet.Tables[1].Rows[0]["totalgoodsnum"]);
                        if (dataSet.Tables[1].Rows[0]["usercount"] != DBNull.Value)
                            result.LUserCount = Convert.ToInt32(dataSet.Tables[1].Rows[0]["usercount"]);
                        if (dataSet.Tables[1].Rows[0]["ordersnum"] != DBNull.Value)
                            result.LOrdersNum = Convert.ToInt32(dataSet.Tables[1].Rows[0]["ordersnum"]);
                    }
                    if (dataSet.Tables.Count > 2 && dataSet.Tables[2].Rows.Count > 0)
                    {
                        if (dataSet.Tables[2].Rows[0]["totalmoney"] != DBNull.Value)
                            result.TotalMoney = Convert.ToDouble(dataSet.Tables[2].Rows[0]["totalmoney"]);
                        if (dataSet.Tables[2].Rows[0]["totalgoodsnum"] != DBNull.Value)
                            result.TotalGoodsNum = Convert.ToInt32(dataSet.Tables[2].Rows[0]["totalgoodsnum"]);
                        if (dataSet.Tables[2].Rows[0]["usercount"] != DBNull.Value)
                            result.UserCount = Convert.ToInt32(dataSet.Tables[2].Rows[0]["usercount"]);
                        if (dataSet.Tables[2].Rows[0]["ordersnum"] != DBNull.Value)
                            result.OrdersNum = Convert.ToInt32(dataSet.Tables[2].Rows[0]["ordersnum"]);
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
        /// 获取日统计数据
        /// </summary>
        /// <param name="sellerId"></param>
        /// <param name="cTime"></param>
        /// <returns></returns>
        public static ConsumeDateStatistics GetConsumeDateStatistics(int sellerId, DateTime cTime)
        {
            var sql = @"select * from ConsumeDateStatistics where SellerId=?SellerId and Year=?Year and Month=?Month and Day=?Day;";
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?SellerId", sellerId));
            parameters.Add(new MySqlParameter("?Year", cTime.Year));
            parameters.Add(new MySqlParameter("?Month", cTime.Month));
            parameters.Add(new MySqlParameter("?Day", cTime.Day));
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, sql, parameters.ToArray());
                    if (reader.HasRows)
                    {
                        if (reader.Read())
                        {
                            ConsumeDateStatistics rechargeDateStatistics = new ConsumeDateStatistics();
                            rechargeDateStatistics.Id = reader.GetInt32(0);
                            rechargeDateStatistics.SellerId = (int)reader["SellerId"];
                            rechargeDateStatistics.Year = (int)reader["Year"];
                            rechargeDateStatistics.Month = (int)reader["Month"];
                            rechargeDateStatistics.Day = (int)reader["Day"];
                            rechargeDateStatistics.Total = (float)reader["Total"];
                            rechargeDateStatistics.Interval0 = (float)reader["Interval0"];
                            rechargeDateStatistics.Interval1 = (float)reader["Interval1"];
                            rechargeDateStatistics.Interval2 = (float)reader["Interval2"];
                            rechargeDateStatistics.Interval3 = (float)reader["Interval3"];
                            rechargeDateStatistics.Interval4 = (float)reader["Interval4"];
                            rechargeDateStatistics.Interval5 = (float)reader["Interval5"];
                            rechargeDateStatistics.Interval6 = (float)reader["Interval6"];
                            rechargeDateStatistics.Interval7 = (float)reader["Interval7"];
                            rechargeDateStatistics.Interval8 = (float)reader["Interval8"];
                            rechargeDateStatistics.Interval9 = (float)reader["Interval9"];
                            rechargeDateStatistics.Interval10 = (float)reader["Interval10"];
                            rechargeDateStatistics.Interval11 = (float)reader["Interval11"];
                            rechargeDateStatistics.Interval12 = (float)reader["Interval12"];
                            rechargeDateStatistics.Interval13 = (float)reader["Interval13"];
                            rechargeDateStatistics.Interval14 = (float)reader["Interval14"];
                            rechargeDateStatistics.Interval15 = (float)reader["Interval15"];
                            rechargeDateStatistics.Interval16 = (float)reader["Interval16"];
                            rechargeDateStatistics.Interval17 = (float)reader["Interval17"];
                            rechargeDateStatistics.Interval18 = (float)reader["Interval18"];
                            rechargeDateStatistics.Interval19 = (float)reader["Interval19"];
                            rechargeDateStatistics.Interval20 = (float)reader["Interval20"];
                            rechargeDateStatistics.Interval21 = (float)reader["Interval21"];
                            rechargeDateStatistics.Interval22 = (float)reader["Interval22"];
                            rechargeDateStatistics.Interval23 = (float)reader["Interval23"];

                            return rechargeDateStatistics;
                        }
                    }
                }
            }
            catch (System.Exception ex)
            {
                throw;
            }
            return null;
        }

        /// <summary>
        /// 保存日统计数据
        /// </summary>
        /// <param name="rechargeDateStatistics"></param>
        /// <returns></returns>
        public static int SaveConsumeDateStatistics(ConsumeDateStatistics rechargeDateStatistics)
        {
            var cmdText = string.Empty;
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            if (rechargeDateStatistics.Id > 0)
            {
                cmdText = @"UPDATE ConsumeDateStatistics SET
                                        Total                  = ?Total     ,
                                        Interval0              = ?Interval0 ,
                                        Interval1              = ?Interval1 ,
                                        Interval2              = ?Interval2 ,
                                        Interval3              = ?Interval3 ,
                                        Interval4              = ?Interval4 ,
                                        Interval5              = ?Interval5 ,
                                        Interval6              = ?Interval6 ,
                                        Interval7              = ?Interval7 ,
                                        Interval8              = ?Interval8 ,
                                        Interval9              = ?Interval9 ,
                                        Interval10             = ?Interval10,
                                        Interval11             = ?Interval11,
                                        Interval12             = ?Interval12,
                                        Interval13             = ?Interval13,
                                        Interval14             = ?Interval14,
                                        Interval15             = ?Interval15,
                                        Interval16             = ?Interval16,
                                        Interval17             = ?Interval17,
                                        Interval18             = ?Interval18,
                                        Interval19             = ?Interval19,
                                        Interval20             = ?Interval20,
                                        Interval21             = ?Interval21,
                                        Interval22             = ?Interval22,
                                        Interval23             = ?Interval23
                                    WHERE
                                        Id = ?Id";
                parameters.Add(new MySqlParameter("?Id", rechargeDateStatistics.Id));
                parameters.Add(new MySqlParameter("?Total", rechargeDateStatistics.Total));
                parameters.Add(new MySqlParameter("?Interval0", rechargeDateStatistics.Interval0));
                parameters.Add(new MySqlParameter("?Interval1", rechargeDateStatistics.Interval1));
                parameters.Add(new MySqlParameter("?Interval2", rechargeDateStatistics.Interval2));
                parameters.Add(new MySqlParameter("?Interval3", rechargeDateStatistics.Interval3));
                parameters.Add(new MySqlParameter("?Interval4", rechargeDateStatistics.Interval4));
                parameters.Add(new MySqlParameter("?Interval5", rechargeDateStatistics.Interval5));
                parameters.Add(new MySqlParameter("?Interval6", rechargeDateStatistics.Interval6));
                parameters.Add(new MySqlParameter("?Interval7", rechargeDateStatistics.Interval7));
                parameters.Add(new MySqlParameter("?Interval8", rechargeDateStatistics.Interval8));
                parameters.Add(new MySqlParameter("?Interval9", rechargeDateStatistics.Interval9));
                parameters.Add(new MySqlParameter("?Interval10", rechargeDateStatistics.Interval10));
                parameters.Add(new MySqlParameter("?Interval11", rechargeDateStatistics.Interval11));
                parameters.Add(new MySqlParameter("?Interval12", rechargeDateStatistics.Interval12));
                parameters.Add(new MySqlParameter("?Interval13", rechargeDateStatistics.Interval13));
                parameters.Add(new MySqlParameter("?Interval14", rechargeDateStatistics.Interval14));
                parameters.Add(new MySqlParameter("?Interval15", rechargeDateStatistics.Interval15));
                parameters.Add(new MySqlParameter("?Interval16", rechargeDateStatistics.Interval16));
                parameters.Add(new MySqlParameter("?Interval17", rechargeDateStatistics.Interval17));
                parameters.Add(new MySqlParameter("?Interval18", rechargeDateStatistics.Interval18));
                parameters.Add(new MySqlParameter("?Interval19", rechargeDateStatistics.Interval19));
                parameters.Add(new MySqlParameter("?Interval20", rechargeDateStatistics.Interval20));
                parameters.Add(new MySqlParameter("?Interval21", rechargeDateStatistics.Interval21));
                parameters.Add(new MySqlParameter("?Interval22", rechargeDateStatistics.Interval22));
                parameters.Add(new MySqlParameter("?Interval23", rechargeDateStatistics.Interval23));
            }
            else
            {
                cmdText = @"insert into ConsumeDateStatistics
                                        (
                                        SellerId          ,
                                        Year              ,
                                        Month             ,
                                        Day               ,
                                        Total             ,
                                        Interval0         ,
                                        Interval1         ,
                                        Interval2         ,
                                        Interval3         ,
                                        Interval4         ,
                                        Interval5         ,
                                        Interval6         ,
                                        Interval7         ,
                                        Interval8         ,
                                        Interval9         ,
                                        Interval10        ,
                                        Interval11        ,
                                        Interval12        ,
                                        Interval13        ,
                                        Interval14        ,
                                        Interval15        ,
                                        Interval16        ,
                                        Interval17        ,
                                        Interval18        ,
                                        Interval19        ,
                                        Interval20        ,
                                        Interval21        ,
                                        Interval22        ,
                                        Interval23       
                                        ) 
                                        values
                                        (
                                        ?SellerId          ,
                                        ?Year              ,
                                        ?Month             ,
                                        ?Day               ,
                                        ?Total             ,
                                        ?Interval0         ,
                                        ?Interval1         ,
                                        ?Interval2         ,
                                        ?Interval3         ,
                                        ?Interval4         ,
                                        ?Interval5         ,
                                        ?Interval6         ,
                                        ?Interval7         ,
                                        ?Interval8         ,
                                        ?Interval9         ,
                                        ?Interval10        ,
                                        ?Interval11        ,
                                        ?Interval12        ,
                                        ?Interval13        ,
                                        ?Interval14        ,
                                        ?Interval15        ,
                                        ?Interval16        ,
                                        ?Interval17        ,
                                        ?Interval18        ,
                                        ?Interval19        ,
                                        ?Interval20        ,
                                        ?Interval21        ,
                                        ?Interval22        ,
                                        ?Interval23       
                                        )";
                parameters.Add(new MySqlParameter("?SellerId", rechargeDateStatistics.SellerId));
                parameters.Add(new MySqlParameter("?Year", rechargeDateStatistics.Year));
                parameters.Add(new MySqlParameter("?Month", rechargeDateStatistics.Month));
                parameters.Add(new MySqlParameter("?Day", rechargeDateStatistics.Day));
                parameters.Add(new MySqlParameter("?Total", rechargeDateStatistics.Total));
                parameters.Add(new MySqlParameter("?Interval0", rechargeDateStatistics.Interval0));
                parameters.Add(new MySqlParameter("?Interval1", rechargeDateStatistics.Interval1));
                parameters.Add(new MySqlParameter("?Interval2", rechargeDateStatistics.Interval2));
                parameters.Add(new MySqlParameter("?Interval3", rechargeDateStatistics.Interval3));
                parameters.Add(new MySqlParameter("?Interval4", rechargeDateStatistics.Interval4));
                parameters.Add(new MySqlParameter("?Interval5", rechargeDateStatistics.Interval5));
                parameters.Add(new MySqlParameter("?Interval6", rechargeDateStatistics.Interval6));
                parameters.Add(new MySqlParameter("?Interval7", rechargeDateStatistics.Interval7));
                parameters.Add(new MySqlParameter("?Interval8", rechargeDateStatistics.Interval8));
                parameters.Add(new MySqlParameter("?Interval9", rechargeDateStatistics.Interval9));
                parameters.Add(new MySqlParameter("?Interval10", rechargeDateStatistics.Interval10));
                parameters.Add(new MySqlParameter("?Interval11", rechargeDateStatistics.Interval11));
                parameters.Add(new MySqlParameter("?Interval12", rechargeDateStatistics.Interval12));
                parameters.Add(new MySqlParameter("?Interval13", rechargeDateStatistics.Interval13));
                parameters.Add(new MySqlParameter("?Interval14", rechargeDateStatistics.Interval14));
                parameters.Add(new MySqlParameter("?Interval15", rechargeDateStatistics.Interval15));
                parameters.Add(new MySqlParameter("?Interval16", rechargeDateStatistics.Interval16));
                parameters.Add(new MySqlParameter("?Interval17", rechargeDateStatistics.Interval17));
                parameters.Add(new MySqlParameter("?Interval18", rechargeDateStatistics.Interval18));
                parameters.Add(new MySqlParameter("?Interval19", rechargeDateStatistics.Interval19));
                parameters.Add(new MySqlParameter("?Interval20", rechargeDateStatistics.Interval20));
                parameters.Add(new MySqlParameter("?Interval21", rechargeDateStatistics.Interval21));
                parameters.Add(new MySqlParameter("?Interval22", rechargeDateStatistics.Interval22));
                parameters.Add(new MySqlParameter("?Interval23", rechargeDateStatistics.Interval23));
            }
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    var num = MySqlHelper.ExecuteNonQuery(conn, CommandType.Text, cmdText, parameters.ToArray());
                    return num;
                }
            }
            catch (System.Exception ex)
            {
                throw;
            }
        }

        /// <summary>
        /// 获取月统计数据
        /// </summary>
        /// <param name="sellerId"></param>
        /// <param name="cTime"></param>
        /// <returns></returns>
        public static ConsumeMonthStatistics GetConsumeMonthStatistics(int sellerId, DateTime cTime)
        {
            var sql = @"select * from ConsumeMonthStatistics where SellerId=?SellerId and Year=?Year;";
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?SellerId", sellerId));
            parameters.Add(new MySqlParameter("?Year", cTime.Year));
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, sql, parameters.ToArray());
                    if (reader.HasRows)
                    {
                        if (reader.Read())
                        {
                            ConsumeMonthStatistics rechargeMonthStatistics = new ConsumeMonthStatistics();
                            rechargeMonthStatistics.Id = reader.GetInt32(0);
                            rechargeMonthStatistics.SellerId = (int)reader["SellerId"];
                            rechargeMonthStatistics.Year = (int)reader["Year"];
                            rechargeMonthStatistics.Total = (float)reader["Total"];
                            rechargeMonthStatistics.Month1 = (float)reader["Month1"];
                            rechargeMonthStatistics.Month2 = (float)reader["Month2"];
                            rechargeMonthStatistics.Month3 = (float)reader["Month3"];
                            rechargeMonthStatistics.Month4 = (float)reader["Month4"];
                            rechargeMonthStatistics.Month5 = (float)reader["Month5"];
                            rechargeMonthStatistics.Month6 = (float)reader["Month6"];
                            rechargeMonthStatistics.Month7 = (float)reader["Month7"];
                            rechargeMonthStatistics.Month8 = (float)reader["Month8"];
                            rechargeMonthStatistics.Month9 = (float)reader["Month9"];
                            rechargeMonthStatistics.Month10 = (float)reader["Month10"];
                            rechargeMonthStatistics.Month11 = (float)reader["Month11"];
                            rechargeMonthStatistics.Month12 = (float)reader["Month12"];

                            return rechargeMonthStatistics;
                        }
                    }
                }
            }
            catch (System.Exception ex)
            {
                throw;
            }
            return null;
        }

        /// <summary>
        /// 保存月统计数据
        /// </summary>
        /// <param name="rechargeMonthStatistics"></param>
        /// <returns></returns>
        public static int SaveConsumeMonthStatistics(ConsumeMonthStatistics rechargeMonthStatistics)
        {
            var cmdText = string.Empty;
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            if (rechargeMonthStatistics.Id > 0)
            {
                cmdText = @"UPDATE ConsumeMonthStatistics SET
                                        Total                  = ?Total     ,
                                        Month1              = ?Month1 ,
                                        Month2              = ?Month2 ,
                                        Month3              = ?Month3 ,
                                        Month4              = ?Month4 ,
                                        Month5              = ?Month5 ,
                                        Month6              = ?Month6 ,
                                        Month7              = ?Month7 ,
                                        Month8              = ?Month8 ,
                                        Month9              = ?Month9 ,
                                        Month10             = ?Month10,
                                        Month11             = ?Month11,
                                        Month12             = ?Month12
                                    WHERE
                                        Id = ?Id";
                parameters.Add(new MySqlParameter("?Id", rechargeMonthStatistics.Id));
                parameters.Add(new MySqlParameter("?Total", rechargeMonthStatistics.Total));
                parameters.Add(new MySqlParameter("?Month1", rechargeMonthStatistics.Month1));
                parameters.Add(new MySqlParameter("?Month2", rechargeMonthStatistics.Month2));
                parameters.Add(new MySqlParameter("?Month3", rechargeMonthStatistics.Month3));
                parameters.Add(new MySqlParameter("?Month4", rechargeMonthStatistics.Month4));
                parameters.Add(new MySqlParameter("?Month5", rechargeMonthStatistics.Month5));
                parameters.Add(new MySqlParameter("?Month6", rechargeMonthStatistics.Month6));
                parameters.Add(new MySqlParameter("?Month7", rechargeMonthStatistics.Month7));
                parameters.Add(new MySqlParameter("?Month8", rechargeMonthStatistics.Month8));
                parameters.Add(new MySqlParameter("?Month9", rechargeMonthStatistics.Month9));
                parameters.Add(new MySqlParameter("?Month10", rechargeMonthStatistics.Month10));
                parameters.Add(new MySqlParameter("?Month11", rechargeMonthStatistics.Month11));
                parameters.Add(new MySqlParameter("?Month12", rechargeMonthStatistics.Month12));
            }
            else
            {
                cmdText = @"insert into ConsumeDateStatistics
                                        (
                                        SellerId          ,
                                        Year              ,
                                        Total             ,
                                        Month1         ,
                                        Month2         ,
                                        Month3         ,
                                        Month4         ,
                                        Month5         ,
                                        Month6         ,
                                        Month7         ,
                                        Month8         ,
                                        Month9         ,
                                        Month10        ,
                                        Month11        ,
                                        Month12        
                                        ) 
                                        values
                                        (
                                        ?SellerId          ,
                                        ?Year              ,
                                        ?Total             ,
                                        ?Month0         ,
                                        ?Month1         ,
                                        ?Month2         ,
                                        ?Month3         ,
                                        ?Month4         ,
                                        ?Month5         ,
                                        ?Month6         ,
                                        ?Month7         ,
                                        ?Month8         ,
                                        ?Month9         ,
                                        ?Month10        ,
                                        ?Month11        ,
                                        ?Month12        
                                        )";
                parameters.Add(new MySqlParameter("?SellerId", rechargeMonthStatistics.SellerId));
                parameters.Add(new MySqlParameter("?Year", rechargeMonthStatistics.Year));
                parameters.Add(new MySqlParameter("?Total", rechargeMonthStatistics.Total));
                parameters.Add(new MySqlParameter("?Month1", rechargeMonthStatistics.Month1));
                parameters.Add(new MySqlParameter("?Month2", rechargeMonthStatistics.Month2));
                parameters.Add(new MySqlParameter("?Month3", rechargeMonthStatistics.Month3));
                parameters.Add(new MySqlParameter("?Month4", rechargeMonthStatistics.Month4));
                parameters.Add(new MySqlParameter("?Month5", rechargeMonthStatistics.Month5));
                parameters.Add(new MySqlParameter("?Month6", rechargeMonthStatistics.Month6));
                parameters.Add(new MySqlParameter("?Month7", rechargeMonthStatistics.Month7));
                parameters.Add(new MySqlParameter("?Month8", rechargeMonthStatistics.Month8));
                parameters.Add(new MySqlParameter("?Month9", rechargeMonthStatistics.Month9));
                parameters.Add(new MySqlParameter("?Month10", rechargeMonthStatistics.Month10));
                parameters.Add(new MySqlParameter("?Month11", rechargeMonthStatistics.Month11));
                parameters.Add(new MySqlParameter("?Month12", rechargeMonthStatistics.Month12));
            }
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    var num = MySqlHelper.ExecuteNonQuery(conn, CommandType.Text, cmdText, parameters.ToArray());
                    return num;
                }
            }
            catch (System.Exception ex)
            {
                throw;
            }
        }

        /// <summary>
        /// 添加消费到统计表
        /// </summary>
        /// <param name="money"></param>
        /// <param name="sellerId"></param>
        /// <param name="cTime"></param>
        public static void AddConsumeStatistics(int sellerId, float money, DateTime cTime)
        {
            var year = cTime.Year;
            var month = cTime.Month;
            var day = cTime.Day;
            var hour = cTime.Hour;

            //保存日统计
            var rechargeDateStatistics = GetConsumeDateStatistics(sellerId, cTime);
            if (rechargeDateStatistics == null)
                rechargeDateStatistics = new ConsumeDateStatistics();
            rechargeDateStatistics.Total += money;
            switch (hour)
            {
                case 0: rechargeDateStatistics.Interval0 += money; break;
                case 1: rechargeDateStatistics.Interval1 += money; break;
                case 2: rechargeDateStatistics.Interval2 += money; break;
                case 3: rechargeDateStatistics.Interval3 += money; break;
                case 4: rechargeDateStatistics.Interval4 += money; break;
                case 5: rechargeDateStatistics.Interval5 += money; break;
                case 6: rechargeDateStatistics.Interval6 += money; break;
                case 7: rechargeDateStatistics.Interval7 += money; break;
                case 8: rechargeDateStatistics.Interval8 += money; break;
                case 9: rechargeDateStatistics.Interval9 += money; break;
                case 10: rechargeDateStatistics.Interval10 += money; break;
                case 11: rechargeDateStatistics.Interval11 += money; break;
                case 12: rechargeDateStatistics.Interval12 += money; break;
                case 13: rechargeDateStatistics.Interval13 += money; break;
                case 14: rechargeDateStatistics.Interval14 += money; break;
                case 15: rechargeDateStatistics.Interval15 += money; break;
                case 16: rechargeDateStatistics.Interval16 += money; break;
                case 17: rechargeDateStatistics.Interval17 += money; break;
                case 18: rechargeDateStatistics.Interval18 += money; break;
                case 19: rechargeDateStatistics.Interval19 += money; break;
                case 20: rechargeDateStatistics.Interval20 += money; break;
                case 21: rechargeDateStatistics.Interval21 += money; break;
                case 22: rechargeDateStatistics.Interval22 += money; break;
                case 23: rechargeDateStatistics.Interval23 += money; break;
            }
            SaveConsumeDateStatistics(rechargeDateStatistics);

            //保存月统计
            var rechargeMonthStatistics = GetConsumeMonthStatistics(sellerId, cTime);
            rechargeMonthStatistics.Total += money;
            switch (month)
            {                                         
                case  1: rechargeMonthStatistics.Month1 += money; break;
                case  2: rechargeMonthStatistics.Month2 += money; break;
                case  3: rechargeMonthStatistics.Month3 += money; break;
                case  4: rechargeMonthStatistics.Month4 += money; break;
                case  5: rechargeMonthStatistics.Month5 += money; break;
                case  6: rechargeMonthStatistics.Month6 += money; break;
                case  7: rechargeMonthStatistics.Month7 += money; break;
                case  8: rechargeMonthStatistics.Month8 += money; break;
                case  9: rechargeMonthStatistics.Month9 += money; break;
                case 10: rechargeMonthStatistics.Month10 += money; break;
                case 11: rechargeMonthStatistics.Month11 += money; break;
                case 12: rechargeMonthStatistics.Month12 += money; break;
            }
            SaveConsumeMonthStatistics(rechargeMonthStatistics);
        }
    }
}