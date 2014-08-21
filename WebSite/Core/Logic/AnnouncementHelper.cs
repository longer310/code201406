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
    public static class AnnouncementHelper
    {
        /// <summary>
        /// 获取公告列表
        /// </summary>
        /// <returns></returns>
        public static PagResults<Announcement> GetList(int start, int limit)
        {
            var result = new PagResults<Announcement>();
            result.Results = new List<Announcement>();
            string limitsql = limit != 0 ? " LIMIT ?start,?limit" : string.Empty;
            var cmdText = @"select * from Announcement " + limitsql;
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
                        Announcement announcement = new Announcement();
                        announcement.Id = reader.GetInt32(0);
                        announcement.Content = reader["Content"].ToString();
                        announcement.CreateTime = (DateTime)reader["CreateTime"];

                        result.Results.Add(announcement);
                    }

                    //一个函数有两次连接数据库 先把连接断开 然后重连
                    conn.Close();
                    conn.Dispose();
                    conn.Open();

                    cmdText = string.Format("select count(*) from Announcement;");
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
        /// 删除公告列表
        /// </summary>
        /// <param name="ids"></param>
        /// <returns></returns>
        public static bool DelAnnouncementList(string ids)
        {
            var cmdText = @"delete from Announcement where find_in_set(`Id`,?Id)";
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
        /// 新增公告列表
        /// </summary>
        /// <param name="announcement"></param>
        /// <returns></returns>
        public static bool AddAnnouncement(Announcement announcement)
        {
            var cmdText = @"insert into Announcement (Content,CreateTime) values(?Content,?CreateTime)";
            var parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?Content", announcement.Content));
            parameters.Add(new MySqlParameter("?CreateTime", announcement.CreateTime));
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