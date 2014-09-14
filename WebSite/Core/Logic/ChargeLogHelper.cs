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
    public static class ChargeLogHelper
    {
        public static PagResults<ChargeLog> GetChargeLogList(int sellerId, int userId, int start = 0, int limit = 0,
            int ifgetcount = 0)
        {
            var result = new PagResults<ChargeLog>();
            result.Results = new List<ChargeLog>();
            string limitsql = start != 0 ? " LIMIT ?start,?limit" : string.Empty;
            var cmdText =
                @"select * from ChargeLog where SellerId=?SellerId and UserId=?UserId order by createtime desc " +
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
                                        UpdateStatusTime
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
                                        ?UpdateStatusTime
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
        /// <param name="status"></param>
        /// <param name="id"></param>
        /// <param name="orderId"></param>
        /// <returns></returns>
        public static bool UpdateStatus(RechargeStatus status, int id,string orderId)
        {
            var cmdText = string.Empty;
            List<MySqlParameter> parameters = new List<MySqlParameter>();

            cmdText = @"update ChargeLog set Status=?Status,UpdateStatusTime=?UpdateStatusTime,OrderId=?OrderId where Id=?Id;";

            parameters.Add(new MySqlParameter("?Status", status));
            parameters.Add(new MySqlParameter("?UpdateStatusTime", DateTime.Now));
            parameters.Add(new MySqlParameter("?OrderId", orderId));
            parameters.Add(new MySqlParameter("?Id", id));

            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    return MySqlHelper.ExecuteNonQuery(conn, CommandType.Text, cmdText,
                        parameters.ToArray()) > 0;
                }
            }
            catch (Exception e)
            {

            }

            return false;
        }
    }
}