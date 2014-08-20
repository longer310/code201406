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
    public static class MerchantTypeHelper
    {
        /// <summary>
        /// 获取商户类型列表
        /// </summary>
        /// <returns></returns>
        public static List<MerchantType> GetList()
        {
            var result = new List<MerchantType>();
            var cmdText = @"select * from MerchantType;";
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText);
                    while (reader.Read())
                    {
                        MerchantType merchantType = new MerchantType();
                        merchantType.Id = reader.GetInt32(0);
                        merchantType.Name = reader["Name"].ToString();
                        merchantType.Count = (int)reader["Count"];
                        merchantType.TypeId = (int)reader["TypeId"];

                        result.Add(merchantType);
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
        /// 删除商户类型列表
        /// </summary>
        /// <param name="ids"></param>
        /// <returns></returns>
        public static bool DelMerchantTypeList(string ids)
        {
            var cmdText = @"delete from MerchantType where find_in_set(`Id`,?Id)";
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
        /// 新增商户类型列表
        /// </summary>
        /// <param name="merchantType"></param>
        /// <returns></returns>
        public static bool AddMerchantType(MerchantType merchantType)
        {
            var cmdText = @"insert into MerchantType (Count,Name,TypeId) values(?Count,?Name,?TypeId)";
            var parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?Count", merchantType.Count));
            parameters.Add(new MySqlParameter("?Name", merchantType.Name));
            parameters.Add(new MySqlParameter("?TypeId", merchantType.TypeId));
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