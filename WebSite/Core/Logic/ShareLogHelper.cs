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
    public static class ShareLogHelper
    {
        /// <summary>
        /// 保存分享记录
        /// </summary>
        /// <param name="shareLog"></param>
        /// <returns></returns>
        public static bool AddShareLog(ShareLog shareLog)
        {
            var cmdText = string.Empty;
            List<MySqlParameter> parameters = new List<MySqlParameter>();

            cmdText = @"insert into ShareLog
                                        (
                                        UserId,
                                        Type,
                                        TypeId,
                                        Content,
                                        CreateTime
                                        ) 
                                        values 
                                        (
                                        ?UserId,
                                        ?Type,
                                        ?TypeId,
                                        ?Content,
                                        ?CreateTime
                                        )";
            parameters.Add(new MySqlParameter("UserId    ", shareLog.UserId));
            parameters.Add(new MySqlParameter("Type    ", shareLog.Type));
            parameters.Add(new MySqlParameter("TypeId    ", shareLog.TypeId));
            parameters.Add(new MySqlParameter("Content    ", shareLog.Content));
            parameters.Add(new MySqlParameter("CreateTime    ", shareLog.CreateTime));
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

        /// <summary>
        /// 
        /// </summary>
        /// <param name="type"></param>
        /// <param name="typeId"></param>
        /// <param name="userId"></param>
        /// <returns></returns>
        public static bool JudgeTypeShare(ShareType type, int typeId, int userId)
        {
            var sql = @"select * from ShareLog where Type=?Type and TypeId=?TypeId and UserId=?UserId limit 1;";
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?Type", type));
            parameters.Add(new MySqlParameter("?TypeId", typeId));
            parameters.Add(new MySqlParameter("?UserId", userId));
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, sql, parameters.ToArray());
                    return reader.HasRows;
                }
            }
            catch (System.Exception ex)
            {
                throw;
            }
            return false;
        }
    }
}