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
        public static List<Temple> GetList()
        {
            var results = new List<Temple>();
            var cmdText = @"select * from Temple;";
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText);
                    while (reader.Read())
                    {
                        Temple temple = new Temple();
                        temple.Id = reader.GetInt32(0);
                        temple.Name = reader["Name"].ToString();
                        temple.LogoUrl = reader["LogoUrl"].ToString();
                        temple.TypeId = (int)reader["TypeId"];

                        results.Add(temple);
                    }
                }
            }
            catch (System.Exception ex)
            {
                throw;
            }
            return results;
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
    }
}