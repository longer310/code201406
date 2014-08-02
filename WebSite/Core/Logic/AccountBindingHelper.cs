using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using Backstage.Core.Entity;
using MySql.Data.MySqlClient;

namespace Backstage.Core.Logic
{
    public static class AccountBindingHelper
    {
        /// <summary>
        /// 根据我方id获取
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static AccountBinding GetAccountBinding(int id)
        {
            var cmdText = string.Format("select * from AccountBinding where Id={0} limit 1;", id);
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText);
                    if (reader.HasRows)
                    {
                        if (reader.Read())
                        {
                            AccountBinding accountBinding = new AccountBinding();
                            accountBinding.Id = reader.GetInt32(0);
                            accountBinding.UserIdentity = reader["UserIdentity"].ToString();
                            accountBinding.AccountType = (AccountType)reader["AccountType"];
                            return accountBinding;
                        }
                    }
                }
            }
            catch (System.Exception ex)
            {
                throw;
            }
            return null;
        }
        /// <summary>
        /// 根据第三方账号id获取绑定实体
        /// </summary>
        /// <param name="userIdentity"></param>
        /// <returns></returns>
        public static AccountBinding GetAccountBindingByIdentity(string userIdentity)
        {
            var cmdText = string.Format("select * from AccountBinding where UserIdentity='{0}' limit 0,1;", userIdentity);
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText);
                    if (reader.HasRows)
                    {
                        if (reader.Read())
                        {
                            AccountBinding accountBinding = new AccountBinding();
                            accountBinding.Id = reader.GetInt32(0);
                            accountBinding.UserIdentity = reader["UserIdentity"].ToString();
                            accountBinding.AccountType = (AccountType)reader["AccountType"];
                            return accountBinding;
                        }
                    }
                }
            }
            catch (System.Exception ex)
            {
                throw;
            }
            return null;
        }

        /// <summary>
        /// 保存绑定账号
        /// </summary>
        /// <param name="accountBinding"></param>
        /// <returns></returns>
        public static bool AddAccountBinding(AccountBinding accountBinding)
        {
            var cmdText = string.Empty;
            List<MySqlParameter> parameters = new List<MySqlParameter>();

            cmdText = @"insert into AccountBinding(Id,UserIdentity,AccountType) values (?Id,?UserIdentity,?AccountType)";
            parameters.Add(new MySqlParameter("?Id", accountBinding.Id));
            parameters.Add(new MySqlParameter("?UserIdentity", accountBinding.UserIdentity));
            parameters.Add(new MySqlParameter("?AccountType", accountBinding.AccountType));
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