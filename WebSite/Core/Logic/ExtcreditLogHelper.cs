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
    public static class ExtcreditLogHelper
    {
        public static PagResults<ExtcreditLog> GetExtcreditLogList(int sellerId, int userId, int start = 0, int limit = 0,int ifgetcount = 0)
        {
            var result = new PagResults<ExtcreditLog>();
            string limitsql = start != 0 ? " LIMIT ?start,?limit" : string.Empty;
            var cmdText = @"select * from ExtcreditLog where SellerId=?SellerId and UserId=?UserId and order by createtime desc " + limitsql;

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
                        ExtcreditLog extcreditLog = new ExtcreditLog();
                        extcreditLog.Id             = reader.GetInt32(0);
                        extcreditLog.SellerId       = (int)reader["SellerId"];
                        extcreditLog.UserId         = (int)reader["UserId"];
                        extcreditLog.SourceId       = (int)reader["SourceId"];
                        extcreditLog.Extcredit      = (int)reader["Extcredit"];
                        extcreditLog.Type           = (ExtcreditSourceType)reader["Type"];
                        extcreditLog.CreateTime     = (DateTime)reader["CreateTime"];

                        result.Results.Add(extcreditLog);
                    }
                    //一个函数有两次连接数据库 先把连接断开 然后重连
                    conn.Close();
                    conn.Dispose();
                    conn.Open();

                    if (ifgetcount > 0)
                    {
                        cmdText = cmdText = @"select count(*) from ExtcreditLog where SellerId=?SellerId and UserId=?UserId;";
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
        /// 保存积分消费及获取记录
        /// </summary>
        /// <param name="extcreditLog"></param>
        /// <returns></returns>
        public static bool AddExtcreditLog(ExtcreditLog extcreditLog)
        {
            var cmdText = string.Empty;
            List<MySqlParameter> parameters = new List<MySqlParameter>();

            cmdText = @"insert into ExtcreditLog
                                        (
                                        SellerId  ,
                                        UserId    ,
                                        SourceId  ,
                                        Extcredit ,
                                        Type      ,
                                        CreateTime
                                        ) 
                                        values 
                                        (
                                        ?SellerId  ,
                                        ?UserId    ,
                                        ?SourceId  ,
                                        ?Extcredit ,
                                        ?Type      ,
                                        ?CreateTime
                                        )";
            parameters.Add(new MySqlParameter("?SellerId  ,    ", extcreditLog.SellerId    ));
            parameters.Add(new MySqlParameter("?UserId    ,    ", extcreditLog.UserId      ));
            parameters.Add(new MySqlParameter("?SourceId  ,    ", extcreditLog.SourceId    ));
            parameters.Add(new MySqlParameter("?Extcredit ,    ", extcreditLog.Extcredit   ));
            parameters.Add(new MySqlParameter("?Type      ,    ", extcreditLog.Type        ));
            parameters.Add(new MySqlParameter("?CreateTime    ",  extcreditLog.CreateTime  ));
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