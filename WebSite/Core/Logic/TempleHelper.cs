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
    public static class TempleHelper
    {
        /// <summary>
        /// 获取模板列表
        /// </summary>
        /// <returns></returns>
        public static PagResults<Temple> GetList(int mid, int start, int limit)
        {
            var result = new PagResults<Temple>();
            result.Results = new List<Temple>();
            string limitsql = limit != 0 ? " LIMIT ?start,?limit" : string.Empty;
            var cmdText = @"select * from Temple where TypeId=?TypeId " + limitsql;
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?TypeId", mid));
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
                        Temple temple = new Temple();
                        temple.Id = reader.GetInt32(0);
                        temple.Name = reader["Name"].ToString();
                        temple.LogoUrl = reader["LogoUrl"].ToString();
                        temple.TypeId = (int)reader["TypeId"];

                        result.Results.Add(temple);
                    }

                    //一个函数有两次连接数据库 先把连接断开 然后重连
                    conn.Close();
                    conn.Dispose();
                    conn.Open();

                    cmdText = string.Format("select count(*) from Temple where TypeId={0}", mid);
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
        /// 获取模板
        /// </summary>
        /// <returns></returns>
        public static Temple GetTemple(int id)
        {
            var temple = new Temple();
            var cmdText = @"select * from Temple where Id=?Id;";
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?Id", id));
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText, parameters.ToArray());
                    if (reader.HasRows)
                    {
                        if (reader.Read())
                        {
                            temple.Id = reader.GetInt32(0);
                            temple.Name = reader["Name"].ToString();
                            temple.LogoUrl = reader["LogoUrl"].ToString();
                            temple.TypeId = (int)reader["TypeId"];
                        }
                    }
                }
            }
            catch (System.Exception ex)
            {
                throw;
            }
            return temple;
        }
        /// <summary>
        /// 删除模板列表
        /// </summary>
        /// <param name="ids"></param>
        /// <returns></returns>
        public static bool DelTempleList(string ids)
        {
            var cmdText = @"delete from Temple where find_in_set(`Id`,?Id)";
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
        /// 新增模板列表
        /// </summary>
        /// <param name="temple"></param>
        /// <returns></returns>
        public static bool AddTemple(Temple temple)
        {
            var cmdText = @"insert into Temple (Name,LogoUrl,TypeId) values(?Name,?LogoUrl,?TypeId)";
            var parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?Name", temple.Name));
            parameters.Add(new MySqlParameter("?LogoUrl", temple.LogoUrl));
            parameters.Add(new MySqlParameter("?TypeId", temple.TypeId));
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
        /// 更新模板列表
        /// </summary>
        /// <param name="temple"></param>
        /// <returns></returns>
        public static bool UpdateTemple(Temple temple)
        {
            if (temple.Id == 0) return false;
            var cmdText = @"update Temple set Name=?Name,LogoUrl=?LogoUrl,TypeId=?TypeId where Id=?Id;";
            var parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?Name", temple.Name));
            parameters.Add(new MySqlParameter("?LogoUrl", temple.LogoUrl));
            parameters.Add(new MySqlParameter("?TypeId", temple.TypeId));
            parameters.Add(new MySqlParameter("?Id", temple.Id));
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