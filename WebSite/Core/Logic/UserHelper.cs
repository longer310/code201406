using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Security.Principal;
using System.Text;
using System.Web;
using System.Web.Security;
using MySql.Data.MySqlClient;

namespace Backstage.Core
{
    public static class UserHelper
    {
        public static List<User> GetUserList(int pageIndex, int pageSize, out int totalnum)
        {
            List<User> list = new List<User>();
            int skipnum = pageSize * pageIndex;
            totalnum = 0;
            var sql = String.Format("select * from account where roletype=2 or roletype = 3 LIMIT {0},{1};", skipnum,
                pageSize);
            try
            {
                MySqlDataReader reader = MySqlHelper.ExecuteReader(Utility._gameDbConn, CommandType.Text, sql);
                while (reader.Read())
                {
                    User user = new User();
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