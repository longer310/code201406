﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using Backstage.Core.Entity;
using Backstage.Model;
using MySql.Data.MySqlClient;

namespace Backstage.Core.Logic
{
    public static class ChargeLogHelper
    {
        public static PagResults<ChargeLog> GetChargeLogList(int sellerId, int userId, int start = 0, int limit = 0,
            int ifgetcount = 0)
        {
            var result = new PagResults<ChargeLog>();
            result.Results = new List<ChargeLog>();
            string limitsql = start != 0 ? " LIMIT ?start,?limit" : string.Empty;
            var cmdText =
                @"select * from ChargeLog where SellerId=?SellerId and UserId=?UserId and Status=10 order by createtime desc " +
                limitsql;

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            if (limit != 0)
            {
                parameters.Add(new MySqlParameter("?start", start));
                parameters.Add(new MySqlParameter("?limit", limit));
            }
            parameters.Add(new MySqlParameter("?SellerId", sellerId));
            parameters.Add(new MySqlParameter("?UserId", userId));
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText,
                        parameters.ToArray());
                    while (reader.Read())
                    {
                        ChargeLog ChargeLog = new ChargeLog();
                        ChargeLog.Id = reader.GetInt32(0);
                        ChargeLog.SellerId = (int)reader["SellerId"];
                        ChargeLog.UserId = (int)reader["UserId"];
                        ChargeLog.Money = (float)reader["Money"];
                        ChargeLog.Pid = (int)reader["Pid"];
                        ChargeLog.PayName = reader["PayName"].ToString();
                        ChargeLog.OrderId = reader["OrderId"].ToString();
                        ChargeLog.CreateTime = (DateTime)reader["CreateTime"];
                        ChargeLog.Status = (RechargeStatus)reader["Status"];
                        ChargeLog.UpdateStatusTime = (DateTime)reader["UpdateStatusTime"];
                        ChargeLog.GidList = Utility.GetListint(reader["Gids"].ToString());
                        ChargeLog.NumList = Utility.GetListint(reader["Nums"].ToString());
                        ChargeLog.Num = (int)reader["Num"];

                        result.Results.Add(ChargeLog);
                    }

                    if (ifgetcount > 0)
                    {
                        //一个函数有两次连接数据库 先把连接断开 然后重连
                        conn.Close();
                        conn.Dispose();
                        conn.Open();

                        cmdText = @"select count(*) from ChargeLog where SellerId=?SellerId and UserId=?UserId;";
                        parameters = new List<MySqlParameter>();
                        parameters.Add(new MySqlParameter("?SellerId", sellerId));
                        parameters.Add(new MySqlParameter("?UserId", userId));
                        reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText, parameters.ToArray());
                        if (reader.HasRows)
                        {
                            if (reader.Read())
                            {
                                result.TotalCount = reader.GetInt32(0);
                            }
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

        public static PagResults<ChargeLog> GetChargeLogs(int sellerId, int start = 0, int limit = 0,
           int ifgetcount = 0)
        {
            var result = new PagResults<ChargeLog>();
            result.Results = new List<ChargeLog>();
            string limitsql = start != 0 ? " LIMIT ?start,?limit" : string.Empty;
            var cmdText =
                @"select * from ChargeLog where SellerId=?SellerId order by createtime desc " +
                limitsql;

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            if (limit != 0)
            {
                parameters.Add(new MySqlParameter("?start", start));
                parameters.Add(new MySqlParameter("?limit", limit));
            }
            parameters.Add(new MySqlParameter("?SellerId", sellerId));
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText,
                        parameters.ToArray());
                    while (reader.Read())
                    {
                        ChargeLog ChargeLog = new ChargeLog();
                        ChargeLog.Id = reader.GetInt32(0);
                        ChargeLog.SellerId = (int)reader["SellerId"];
                        ChargeLog.UserId = (int)reader["UserId"];
                        ChargeLog.Money = (float)reader["Money"];
                        ChargeLog.Pid = (int)reader["Pid"];
                        ChargeLog.PayName = reader["PayName"].ToString();
                        ChargeLog.OrderId = reader["OrderId"].ToString();
                        ChargeLog.CreateTime = (DateTime)reader["CreateTime"];
                        ChargeLog.Status = (RechargeStatus)reader["Status"];
                        ChargeLog.UpdateStatusTime = (DateTime)reader["UpdateStatusTime"];
                        ChargeLog.UpdateStatusTime = (DateTime)reader["UpdateStatusTime"];
                        ChargeLog.GidList = Utility.GetListint(reader["Gids"].ToString());
                        ChargeLog.NumList = Utility.GetListint(reader["Nums"].ToString());
                        ChargeLog.Num = (int)reader["Num"];

                        result.Results.Add(ChargeLog);
                    }

                    if (ifgetcount > 0)
                    {
                        //一个函数有两次连接数据库 先把连接断开 然后重连
                        conn.Close();
                        conn.Dispose();
                        conn.Open();

                        cmdText = @"select count(*) from ChargeLog where SellerId=?SellerId";
                        parameters = new List<MySqlParameter>();
                        parameters.Add(new MySqlParameter("?SellerId", sellerId));
                        reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText, parameters.ToArray());
                        if (reader.HasRows)
                        {
                            if (reader.Read())
                            {
                                result.TotalCount = reader.GetInt32(0);
                            }
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
        /// 获取充值记录
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static ChargeLog GetChargeLog(int id)
        {
            var result = new ChargeLog();
            var cmdText = @"select * from ChargeLog where Id=?Id;";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?Id", id));
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
                            result.Id = reader.GetInt32(0);
                            result.SellerId = (int)reader["SellerId"];
                            result.UserId = (int)reader["UserId"];
                            result.Money = (float)reader["Money"];
                            result.Pid = (int)reader["Pid"];
                            result.PayName = reader["PayName"].ToString();
                            result.OrderId = reader["OrderId"].ToString();
                            result.CreateTime = (DateTime)reader["CreateTime"];
                            result.Status = (RechargeStatus)reader["Status"];
                            result.UpdateStatusTime = (DateTime)reader["UpdateStatusTime"];
                            result.GidList = Utility.GetListint(reader["Gids"].ToString());
                            result.NumList = Utility.GetListint(reader["Nums"].ToString());
                            result.Num = (int)reader["Num"];
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
        /// 保存充值记录
        /// </summary>
        /// <param name="chargeLog"></param>
        /// <returns></returns>
        public static int AddChargeLog(ChargeLog chargeLog)
        {
            var cmdText = string.Empty;
            List<MySqlParameter> parameters = new List<MySqlParameter>();

            cmdText = @"insert into ChargeLog
                                        (
                                        UserId,
                                        Money,
                                        Pid,
                                        OrderId,
                                        SellerId,
                                        PayName,
                                        CreateTime,
                                        Status,
                                        UpdateStatusTime,
                                        Gids,
                                        Nums,
                                        Num
                                        ) 
                                        values 
                                        (
                                        ?UserId,
                                        ?Money,
                                        ?Pid,
                                        ?OrderId,
                                        ?SellerId,
                                        ?PayName,
                                        ?CreateTime,
                                        ?Status,
                                        ?UpdateStatusTime,
                                        ?Gids,
                                        ?Nums,
                                        ?Num
                                        )";
            parameters.Add(new MySqlParameter("?UserId", chargeLog.UserId));
            parameters.Add(new MySqlParameter("?Money", chargeLog.Money));
            parameters.Add(new MySqlParameter("?Pid", chargeLog.Pid));
            parameters.Add(new MySqlParameter("?OrderId", chargeLog.OrderId));
            parameters.Add(new MySqlParameter("?SellerId", chargeLog.SellerId));
            parameters.Add(new MySqlParameter("?PayName", chargeLog.PayName));
            parameters.Add(new MySqlParameter("?CreateTime", chargeLog.CreateTime));
            parameters.Add(new MySqlParameter("?Status", chargeLog.Status));
            parameters.Add(new MySqlParameter("?UpdateStatusTime", chargeLog.UpdateStatusTime));
            parameters.Add(new MySqlParameter("?Gids", Utility.GetString(chargeLog.GidList)));
            parameters.Add(new MySqlParameter("?Nums", Utility.GetString(chargeLog.NumList)));
            parameters.Add(new MySqlParameter("?Num", chargeLog.Num));
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    var num = MySqlHelper.ExecuteNonQuery(conn, CommandType.Text, cmdText,
                        parameters.ToArray());
                    if (num > 0)
                    {
                        cmdText = @"select LAST_INSERT_ID();";
                        var reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText);
                        if (reader.HasRows)
                        {
                            if (reader.Read())
                            {
                                num = reader.GetInt32(0);
                                return num;
                            }
                        }
                    }
                    return 0;
                }
            }
            catch (System.Exception ex)
            {
                throw;
            }
            return 0;
        }

        /// <summary>
        /// 更新充值状态
        /// </summary>
        /// <param name="chargeLog"></param>
        /// <param name="orderId"></param>
        /// <returns></returns>
        public static bool UpdateStatus(ChargeLog chargeLog, string orderId)
        {
            var cmdText = string.Empty;
            List<MySqlParameter> parameters = new List<MySqlParameter>();

            cmdText = @"update ChargeLog set Status=?Status,UpdateStatusTime=?UpdateStatusTime,OrderId=?OrderId where Id=?Id;";

            parameters.Add(new MySqlParameter("?Status", (int)chargeLog.Status));
            parameters.Add(new MySqlParameter("?UpdateStatusTime", DateTime.Now));
            parameters.Add(new MySqlParameter("?OrderId", orderId));
            parameters.Add(new MySqlParameter("?Id", chargeLog.Id));

            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    bool result = MySqlHelper.ExecuteNonQuery(conn, CommandType.Text, cmdText,
                        parameters.ToArray()) > 0;
                    if (result && chargeLog.Status == RechargeStatus.Success)
                    {
                        if (chargeLog.Money > 0)
                        {
                            //充值统计
                            RechargeStatisticsHelper.AddRechargeStatistics(chargeLog.SellerId, chargeLog.Money, chargeLog.CreateTime);
                        }
                        else if(chargeLog.Money < 0)
                        {
                            //消费统计
                            ConsumeStatisticsHelper.AddConsumeStatistics(chargeLog.SellerId, Math.Abs(chargeLog.Money), chargeLog.CreateTime);
                        }
                    }
                    return result;
                }
            }
            catch (Exception e)
            {

            }

            return false;
        }

        /// <summary>
        /// 获取统计充值记录列表信息
        /// </summary>
        /// <param name="sellerId"></param>
        /// <param name="startTime"></param>
        /// <param name="endTime"></param>
        /// <param name="start"></param>
        /// <param name="limit"></param>
        /// <returns></returns>
        public static List<ReqChargeStatItem> GetRechargeLogList(int sellerId, DateTime startTime, DateTime endTime, int start = 0, int limit = 0)
        {
            var result = new List<ReqChargeStatItem>();
            string limitsql = start != 0 ? " LIMIT ?start,?limit" : string.Empty;
            var cmdText =
                @"select sum(a.money) totalmoney,a.userid,b.UserName from chargelog a join account b on a.UserId=b.Id where a.SellerId=?SellerId and a.money>0 and a.`Status` =10 and a.CreateTime>=?StartTime and a.CreateTime<=?EndTime GROUP BY a.userid ORDER BY totalmoney desc; " +
                limitsql;

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            if (limit != 0)
            {
                parameters.Add(new MySqlParameter("?start", start));
                parameters.Add(new MySqlParameter("?limit", limit));
            }
            parameters.Add(new MySqlParameter("?SellerId", sellerId));
            parameters.Add(new MySqlParameter("?StartTime", startTime));
            parameters.Add(new MySqlParameter("?EndTime", endTime));
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText,
                        parameters.ToArray());
                    while (reader.Read())
                    {
                        ReqChargeStatItem item = new ReqChargeStatItem();
                        item.TotalMoney = reader.GetDouble(0);
                        item.UserId = (int)reader["UserId"];
                        item.UserName = reader["UserName"].ToString();

                        result.Add(item);
                    }

                    //一个函数有两次连接数据库 先把连接断开 然后重连
                    //conn.Close();
                    //conn.Dispose();
                    //conn.Open();

                    //cmdText = @"select count(*) from ChargeLog where SellerId=?SellerId and Money>0 and CreateTime>=?StartTime and EndTime<=?EndTime;";
                    //parameters = new List<MySqlParameter>();
                    //parameters.Add(new MySqlParameter("?SellerId", sellerId));
                    //parameters.Add(new MySqlParameter("?StartTime", startTime));
                    //parameters.Add(new MySqlParameter("?EndTime", endTime));
                    //reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText, parameters.ToArray());
                    //if (reader.HasRows)
                    //{
                    //    if (reader.Read())
                    //    {
                    //        result.TotalCount = reader.GetInt32(0);
                    //    }
                    //}
                }

            }
            catch (System.Exception ex)
            {
                throw;
            }
            return result;
        }

        /// <summary>
        /// 获取统计充值记录列表信息
        /// </summary>
        /// <param name="sellerId"></param>
        /// <param name="startTime"></param>
        /// <param name="endTime"></param>
        /// <param name="start"></param>
        /// <param name="limit"></param>
        /// <returns></returns>
        public static List<ChargeLog> GetChargeLogList(int sellerId, DateTime startTime, DateTime endTime, int start = 0, int limit = 0)
        {
            var result = new List<ChargeLog>();
            string limitsql = start != 0 ? " LIMIT ?start,?limit" : string.Empty;
            var cmdText =
                @"select * from chargelog where SellerId=?SellerId and money<0 and orderid>0 and `Status` =10 and CreateTime>=?StartTime and CreateTime<=?EndTime;" +
                limitsql;

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            if (limit != 0)
            {
                parameters.Add(new MySqlParameter("?start", start));
                parameters.Add(new MySqlParameter("?limit", limit));
            }
            parameters.Add(new MySqlParameter("?SellerId", sellerId));
            parameters.Add(new MySqlParameter("?StartTime", startTime));
            parameters.Add(new MySqlParameter("?EndTime", endTime));
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText,
                        parameters.ToArray());
                    while (reader.Read())
                    {
                        ChargeLog item = new ChargeLog();
                        item.Id = reader.GetInt32(0);
                        item.SellerId = (int)reader["SellerId"];
                        item.UserId = (int)reader["UserId"];
                        item.Money = (float)reader["Money"];
                        item.Pid = (int)reader["Pid"];
                        item.PayName = reader["PayName"].ToString();
                        item.OrderId = reader["OrderId"].ToString();
                        item.CreateTime = (DateTime)reader["CreateTime"];
                        item.Status = (RechargeStatus)reader["Status"];
                        item.UpdateStatusTime = (DateTime)reader["UpdateStatusTime"];
                        item.GidList = Utility.GetListint(reader["Gids"].ToString());
                        item.NumList = Utility.GetListint(reader["Nums"].ToString());
                        item.Num = (int)reader["Num"];

                        result.Add(item);
                    }

                    //一个函数有两次连接数据库 先把连接断开 然后重连
                    //conn.Close();
                    //conn.Dispose();
                    //conn.Open();

                    //cmdText = @"select count(*) from ChargeLog where SellerId=?SellerId and Money>0 and CreateTime>=?StartTime and EndTime<=?EndTime;";
                    //parameters = new List<MySqlParameter>();
                    //parameters.Add(new MySqlParameter("?SellerId", sellerId));
                    //parameters.Add(new MySqlParameter("?StartTime", startTime));
                    //parameters.Add(new MySqlParameter("?EndTime", endTime));
                    //reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText, parameters.ToArray());
                    //if (reader.HasRows)
                    //{
                    //    if (reader.Read())
                    //    {
                    //        result.TotalCount = reader.GetInt32(0);
                    //    }
                    //}
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