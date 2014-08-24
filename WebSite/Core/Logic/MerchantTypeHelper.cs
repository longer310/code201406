using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using Backstage.Core.Entity;
using Backstage.Handler;
using Backstage.Model;
using MySql.Data.MySqlClient;

namespace Backstage.Core.Logic
{
    public static class MerchantTypeHelper
    {
        /// <summary>
        /// 获取商户类型
        /// </summary>
        /// <returns></returns>
        public static MerchantType GetMerchantType(int id)
        {
            MerchantType merchantType = new MerchantType();
            var cmdText = string.Format("select * from MerchantType where id={0}", id);
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText);
                    if (reader.HasRows)
                    {
                        if (reader.Read())
                        {
                            merchantType.Id = reader.GetInt32(0);
                            merchantType.Name = reader["Name"].ToString();
                            merchantType.Count = (int) reader["Count"];
                            merchantType.TypeId = (int) reader["TypeId"];
                        }
                    }
                }
            }
            catch (System.Exception ex)
            {
                throw;
            }
            return merchantType;
        }
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

        /// <summary>
        /// 更改商户分类商户个数——事物处理
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        public static bool UpdateMerchantCount(List<GoodsHandler.ChangeCountItem> data)
        {
            var cmdText = string.Empty;
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            cmdText = "begin;";
            foreach (var changeitem in data)
            {
                var tempcmdText = @"UPDATE MerchantType SET
                                        `Count`        = `Count` + (?Count)
                                    WHERE
                                        Id = ?Id;";
                string newStr = string.Format("?{0}", changeitem.Id);
                tempcmdText = tempcmdText.Replace("?", newStr);
                cmdText += tempcmdText;
                parameters.Add(new MySqlParameter(newStr + "Id", changeitem.Id));
                parameters.Add(new MySqlParameter(newStr + "Count", changeitem.Change));
            }
            cmdText += "commit;";
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
        /// 保存商户分类
        /// </summary>
        /// <param name="merchantType"></param>
        /// <returns></returns>
        public static bool SaveMerchantTypeList(List<MerchantType> merchantTypeList)
        {
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            var cmdText = "begin;";
            foreach (var merchantType in merchantTypeList)
            {
                var tempcmdText = @"UPDATE MerchantType SET
                                        Name        = ?Name
                                    WHERE
                                        Id = ?Id;";
                string newStr = string.Format("?{0}", merchantType.Id);
                tempcmdText = tempcmdText.Replace("?", newStr);
                cmdText += tempcmdText;
                parameters.Add(new MySqlParameter(newStr + "Id", merchantType.Id));
                parameters.Add(new MySqlParameter(newStr + "Name", merchantType.Name));
            }
            cmdText += "commit;";
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