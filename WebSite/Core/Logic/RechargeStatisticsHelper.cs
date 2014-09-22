using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
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
                @"select * from RechargeDateStatistics where SellerId=?SellerId and Year=?Year and Month=?Month and Day=?Day;";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?SellerId", sellerId));
            parameters.Add(new MySqlParameter("?Year", dateTime.Year));
            parameters.Add(new MySqlParameter("?Month", dateTime.Month));
            parameters.Add(new MySqlParameter("?Day", dateTime.Day));
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText,
                        parameters.ToArray());
                    if (reader.HasRows)
                    {
                        if (reader.Read())
                        {
                            var id = reader.GetInt32(0);
                            result.Yvalues[0] = (float)reader["Interval0"];
                            result.Yvalues[1] = (float)reader["Interval1"];
                            result.Yvalues[2] = (float)reader["Interval2"];
                            result.Yvalues[3] = (float)reader["Interval3"];
                            result.Yvalues[4] = (float)reader["Interval4"];
                            result.Yvalues[5] = (float)reader["Interval5"];
                            result.Yvalues[6] = (float)reader["Interval6"];
                            result.Yvalues[7] = (float)reader["Interval7"];
                            result.Yvalues[8] = (float)reader["Interval8"];
                            result.Yvalues[9] = (float)reader["Interval9"];
                            result.Yvalues[10] = (float)reader["Interval10"];
                            result.Yvalues[11] = (float)reader["Interval11"];
                            result.Yvalues[12] = (float)reader["Interval12"];
                            result.Yvalues[13] = (float)reader["Interval13"];
                            result.Yvalues[14] = (float)reader["Interval14"];
                            result.Yvalues[15] = (float)reader["Interval15"];
                            result.Yvalues[16] = (float)reader["Interval16"];
                            result.Yvalues[17] = (float)reader["Interval17"];
                            result.Yvalues[18] = (float)reader["Interval18"];
                            result.Yvalues[19] = (float)reader["Interval19"];
                            result.Yvalues[20] = (float)reader["Interval20"];
                            result.Yvalues[21] = (float)reader["Interval21"];
                            result.Yvalues[22] = (float)reader["Interval22"];
                            result.Yvalues[23] = (float)reader["Interval23"];
                        }
                    }

                    //一个函数有两次连接数据库 先把连接断开 然后重连
                    conn.Close();
                    conn.Dispose();
                    conn.Open();

                    cmdText = @"select sum(money) totalmoney,max(money) maxmoney,count(DISTINCT userid) usercount from chargelog where money>0 and CreateTime>?StartTime and CreateTime<?EndTime;";
                    parameters = new List<MySqlParameter>();
                    parameters.Add(new MySqlParameter("?SellerId", sellerId));
                    parameters.Add(new MySqlParameter("?StartTime", dateTime.Date));
                    parameters.Add(new MySqlParameter("?EndTime", dateTime.Date.AddDays(1).AddMilliseconds(-1)));
                    reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText, parameters.ToArray());
                    if (reader.HasRows)
                    {
                        if (reader.Read())
                        {
                            result.TotalMoney = reader.GetFloat(0);
                            result.MaxSingleMoney = (float)reader["maxmoney"];
                            result.UserCount = (int)reader["usercount"];
                        }
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
            var cmdText =
                @"select * from RechargeDateStatistics where SellerId=?SellerId and Year=?Year and Month=?Month order by Day;";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?SellerId", sellerId));
            parameters.Add(new MySqlParameter("?Year", year));
            parameters.Add(new MySqlParameter("?Month", month));
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText,
                        parameters.ToArray());
                    var i = 0;
                    while (reader.Read())
                    {
                        var id = reader.GetInt32(0);
                        result.Yvalues[i] = (float)reader["Total"];
                    }

                    //一个函数有两次连接数据库 先把连接断开 然后重连
                    conn.Close();
                    conn.Dispose();
                    conn.Open();

                    cmdText = @"select sum(money) totalmoney,max(money) maxmoney,count(DISTINCT userid) usercount from chargelog where money>0 and CreateTime>?StartTime and CreateTime<?EndTime;";
                    parameters = new List<MySqlParameter>();
                    parameters.Add(new MySqlParameter("?SellerId", sellerId));
                    var date = new DateTime(year, month, 1);
                    parameters.Add(new MySqlParameter("?StartTime", date.Date));
                    parameters.Add(new MySqlParameter("?EndTime", date.Date.AddMonths(1).AddMilliseconds(-1)));
                    reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText, parameters.ToArray());
                    if (reader.HasRows)
                    {
                        if (reader.Read())
                        {
                            result.TotalMoney = reader.GetFloat(0);
                            result.MaxSingleMoney = (float)reader["maxmoney"];
                            result.UserCount = (int)reader["usercount"];
                        }
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
            var cmdText =
                @"select * from RechargeMonthStatistics where SellerId=?SellerId and Year=?Year;";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?SellerId", sellerId));
            parameters.Add(new MySqlParameter("?Year", year));
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText,
                        parameters.ToArray());
                    var i = 0;
                    if (reader.HasRows)
                    {
                        if (reader.Read())
                        {
                            var id = reader.GetInt32(0);
                            result.Yvalues[0] = (float)reader["Month1"];
                            result.Yvalues[0] += (float)reader["Month2"];
                            result.Yvalues[0] += (float)reader["Month3"];

                            result.Yvalues[1] = (float)reader["Month4"];
                            result.Yvalues[1] += (float)reader["Month5"];
                            result.Yvalues[1] += (float)reader["Month6"];

                            result.Yvalues[2] = (float)reader["Month7"];
                            result.Yvalues[2] += (float)reader["Month8"];
                            result.Yvalues[2] += (float)reader["Month9"];

                            result.Yvalues[3] = (float)reader["Month10"];
                            result.Yvalues[3] += (float)reader["Month11"];
                            result.Yvalues[3] += (float)reader["Month12"];
                        }
                    }

                    //一个函数有两次连接数据库 先把连接断开 然后重连
                    conn.Close();
                    conn.Dispose();
                    conn.Open();

                    cmdText = @"select sum(money) totalmoney,max(money) maxmoney,count(DISTINCT userid) usercount from chargelog where money>0 and CreateTime>?StartTime and CreateTime<?EndTime;";
                    parameters = new List<MySqlParameter>();
                    parameters.Add(new MySqlParameter("?SellerId", sellerId));
                    var date = new DateTime(year, 1, 1);
                    parameters.Add(new MySqlParameter("?StartTime", date.Date));
                    parameters.Add(new MySqlParameter("?EndTime", date.Date.AddYears(1).AddMilliseconds(-1)));
                    reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText, parameters.ToArray());
                    if (reader.HasRows)
                    {
                        if (reader.Read())
                        {
                            result.TotalMoney = reader.GetFloat(0);
                            result.MaxSingleMoney = (float)reader["maxmoney"];
                            result.UserCount = (int)reader["usercount"];
                        }
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
            var cmdText =
                @"select * from RechargeMonthStatistics where SellerId=?SellerId and Year=?Year;";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?SellerId", sellerId));
            parameters.Add(new MySqlParameter("?Year", year));
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText,
                        parameters.ToArray());
                    var i = 0;
                    if (reader.HasRows)
                    {
                        if (reader.Read())
                        {
                            var id = reader.GetInt32(0);
                            result.Yvalues[0] = (float)reader["Month1"];
                            result.Yvalues[1] = (float)reader["Month1"];
                            result.Yvalues[2] = (float)reader["Month2"];
                            result.Yvalues[3] = (float)reader["Month3"];
                            result.Yvalues[4] = (float)reader["Month4"];
                            result.Yvalues[5] = (float)reader["Month5"];
                            result.Yvalues[6] = (float)reader["Month6"];
                            result.Yvalues[7] = (float)reader["Month7"];
                            result.Yvalues[8] = (float)reader["Month8"];
                            result.Yvalues[9] = (float)reader["Month9"];
                            result.Yvalues[10] = (float)reader["Month10"];
                            result.Yvalues[11] = (float)reader["Month11"];
                        }
                    }

                    //一个函数有两次连接数据库 先把连接断开 然后重连
                    conn.Close();
                    conn.Dispose();
                    conn.Open();

                    cmdText = @"select sum(money) totalmoney,max(money) maxmoney,count(DISTINCT userid) usercount from chargelog where money>0 and CreateTime>?StartTime and CreateTime<?EndTime;";
                    parameters = new List<MySqlParameter>();
                    parameters.Add(new MySqlParameter("?SellerId", sellerId));
                    var date = new DateTime(year, 1, 1);
                    parameters.Add(new MySqlParameter("?StartTime", date.Date));
                    parameters.Add(new MySqlParameter("?EndTime", date.Date.AddYears(1).AddMilliseconds(-1)));
                    reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText, parameters.ToArray());
                    if (reader.HasRows)
                    {
                        if (reader.Read())
                        {
                            result.TotalMoney = reader.GetFloat(0);
                            result.MaxSingleMoney = (float)reader["maxmoney"];
                            result.UserCount = (int)reader["usercount"];
                        }
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