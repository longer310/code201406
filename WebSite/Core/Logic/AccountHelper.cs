using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Security.Cryptography;
using System.Security.Principal;
using System.Text;
using System.Web;
using System.Web.Security;
using Backstage.Core.Entity;
using MySql.Data.MySqlClient;

namespace Backstage.Core
{
    public static class AccountHelper
    {
        public static List<Account> GetUserList(out int totalnum, string wheresql = "", string ordersql = "", int start = 0, int limit = 0)
        {
            totalnum = 0;
            List<Account> list = new List<Account>();
            var sql = "select * from account where 1=1 and ";
            if (wheresql != "") sql += " " + wheresql;
            if (ordersql != "") sql += " " + ordersql;
            else sql += " order by CreateTime desc";
            if (limit != 0) sql += String.Format(" limit {0},{1};", start, limit);
            try
            {
                MySqlDataReader reader = MySqlHelper.ExecuteReader(Utility._gameDbConn, CommandType.Text, sql);
                var dset = MySqlHelper.ExecuteDataset(Utility._gameDbConn, CommandType.Text, sql);
                DataTable dt = dset.Tables[0];
                while (reader.Read())
                {
                    Account user = new Account();
                    user.Id = reader.GetInt32(0);
                    user.UserName = reader.GetString(1);
                    user.Pwd = reader.GetString(2);
                    user.RoleType = (RoleType)reader.GetInt32(3);

                    list.Add(user);
                }

                sql = "select count(*) from account where roletype=2 or roletype = 3;";
                reader = MySqlHelper.ExecuteReader(Utility._gameDbConn, CommandType.Text, sql);
                if (reader.HasRows)
                {
                    if (reader.Read())
                    {
                        totalnum = reader.GetInt32(0);
                    }
                }
            }
            catch (System.Exception ex)
            {
                throw;
            }
            return list;
        }

        public static int UpdateUser(int id, string userName, string pwd, int roleType)
        {
            var sql = string.Empty;
            if (id > 0)
                sql = string.Format("update account set UserName='{0}',Pwd='{1}',RoleType={2} where Id={3}", userName, pwd,
                    roleType, id);
            else
            {
                sql = string.Format("insert account(UserName,Pwd,RoleType) values('{0}','{1}',{2})", userName, pwd,
                    roleType);
            }

            try
            {
                return MySqlHelper.ExecuteNonQuery(Utility._gameDbConn, CommandType.Text, sql);
            }
            catch (System.Exception ex)
            {
                return 0;
            }
        }

        public static int DelUser(int id)
        {
            var sql = string.Format("delete from account where Id={0}", id);

            try
            {
                return MySqlHelper.ExecuteNonQuery(Utility._gameDbConn, CommandType.Text, sql);
            }
            catch (System.Exception ex)
            {
                return 0;
            }
        }
    }
}