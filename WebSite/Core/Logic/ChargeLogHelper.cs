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
        public static PagResults<ChargeLog> GetChargeLogList(int sellerId, int userId, int start = 0, int limit = 0,int ifgetcount = 0)
        {
            var result = new PagResults<ChargeLog>();
            string limitsql = start != 0 ? " LIMIT ?start,?limit" : string.Empty;
            var cmdText = @"select * from ChargeLog where SellerId=?SellerId and UserId=?UserId and order by createtime desc " + limitsql;

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            if (start != 0)
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

                        result.Results.Add(ChargeLog);
                    }
                    //一个函数有两次连接数据库 先把连接断开 然后重连
                    conn.Close();
                    conn.Dispose();
                    conn.Open();

                    if (ifgetcount > 0)
                    {
                        cmdText = cmdText = @"select count(*) from ChargeLog where SellerId=?SellerId and UserId=?UserId;";
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
        /// 保存充值记录
        /// </summary>
        /// <param name="chargeLog"></param>
        /// <returns></returns>
        public static bool AddChargeLog(ChargeLog chargeLog)
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
                                        PayName
                                        ) 
                                        values 
                                        (
                                        ?UserId,
                                        ?Money,
                                        ?Pid,
                                        ?OrderId,
                                        ?SellerId,
                                        ?PayName
                                        )";
            parameters.Add(new MySqlParameter("?UserId", chargeLog.UserId));
            parameters.Add(new MySqlParameter("?Money", chargeLog.Money));
            parameters.Add(new MySqlParameter("?Pid", chargeLog.Pid));
            parameters.Add(new MySqlParameter("?OrderId", chargeLog.OrderId));
            parameters.Add(new MySqlParameter("?SellerId", chargeLog.SellerId));
            parameters.Add(new MySqlParameter("?PayName", chargeLog.PayName));
            try
            {
                var num = MySqlHelper.ExecuteNonQuery(Utility._gameDbConn, CommandType.Text, cmdText, parameters.ToArray());
                return num > 0;
            }
            catch (System.Exception ex)
            {
                throw;
            }
            return false;
        }
    }
}