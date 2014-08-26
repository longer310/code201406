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
    public static class PaypalRecordHelper
    {
        /// <summary>
        /// 获取支付宝记录列表
        /// </summary>
        /// <returns></returns>
        public static PagResults<PaypalRecord> GetList(int start, int limit)
        {
            var result = new PagResults<PaypalRecord>();
            result.Results = new List<PaypalRecord>();
            string limitsql = limit != 0 ? " LIMIT ?start,?limit" : string.Empty;
            var cmdText = @"select * from PaypalRecord " + limitsql;
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            if (!string.IsNullOrEmpty(limitsql))
            {
                parameters.Add(new MySqlParameter("?start", start));
                parameters.Add(new MySqlParameter("?limit", limit));
            }
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText, parameters.ToArray());
                    while (reader.Read())
                    {
                        PaypalRecord paypalRecord = new PaypalRecord();
                        paypalRecord.Id = reader.GetInt32(0);
                        paypalRecord.Status = reader["Status"].ToString();
                        paypalRecord.Trade_no = reader["Trade_no"].ToString();
                        paypalRecord.OrderId = (int)reader["OrderId"];

                        result.Results.Add(paypalRecord);
                    }

                    //一个函数有两次连接数据库 先把连接断开 然后重连
                    conn.Close();
                    conn.Dispose();
                    conn.Open();

                    cmdText = string.Format("select count(*) from PaypalRecord;");
                    reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText);
                    if (reader.HasRows)
                    {
                        if (reader.Read())
                        {
                            result.TotalCount = reader.GetInt32(0);
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
        /// 删除支付宝记录列表
        /// </summary>
        /// <param name="ids"></param>
        /// <returns></returns>
        public static bool DelPaypalRecordList(string ids)
        {
            var cmdText = @"delete from PaypalRecord where find_in_set(`Id`,?Id)";
            var parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?Id", ids));
            try
            {
                return
                    MySqlHelper.ExecuteNonQuery(Utility._gameDbConn, CommandType.Text, cmdText, parameters.ToArray()) >
                    0;
            }
            catch (System.Exception ex)
            {
                throw;
            }
        }
        /// <summary>
        /// 新增支付宝记录列表
        /// </summary>
        /// <param name="paypalRecord"></param>
        /// <returns></returns>
        public static bool AddPaypalRecord(PaypalRecord paypalRecord)
        {
            var cmdText = @"insert into PaypalRecord (Status,OrderId,Trade_no) values(?Status,?OrderId,?Trade_no)";
            var parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?Status", paypalRecord.Status));
            parameters.Add(new MySqlParameter("?Trade_no", paypalRecord.Trade_no));
            parameters.Add(new MySqlParameter("?OrderId", paypalRecord.OrderId));
            try
            {
                return
                    MySqlHelper.ExecuteNonQuery(Utility._gameDbConn, CommandType.Text, cmdText, parameters.ToArray()) >
                    0;
            }
            catch (System.Exception ex)
            {
                throw;
            }
        }
    }
}