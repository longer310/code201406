using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using Backstage.Core.Entity;
using MySql.Data.MySqlClient;

namespace Backstage.Core.Logic
{
    public static class VerificationCodeHelper
    {
        public static VerificationCode GetVerificationCode(int sellerId, string phone = "", int uid = 0)
        {
            string wheresql = string.Empty;
            if (phone.Length > 0) wheresql = " and Phone =?Phone ";
            if (uid > 0) wheresql = " and UserId=?UserId ";
            var cmdText = @"select * from VerificationCode where SellerId=?SellerId  limit 1;";
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?SellerId", sellerId));
            if (phone.Length > 0) parameters.Add(new MySqlParameter("?Phone", phone));
            if (uid > 0) parameters.Add(new MySqlParameter("?UserId", uid));
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText, parameters.ToArray());
                    if (reader.HasRows)
                    {
                        if (reader.Read())
                        {
                            VerificationCode verificationCode = new VerificationCode();
                            verificationCode.Id = reader.GetInt32(0);
                            verificationCode.SellerId = (int)reader["SellerId"];
                            verificationCode.Phone = reader["Phone"].ToString();
                            verificationCode.Code = reader["Code"].ToString();
                            verificationCode.ExpiredTime = (DateTime)reader["ExpiredTime"];
                            return verificationCode;
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

        public static bool JudgyVerificationCode(int sellerId, string phone, string code)
        {
            var cmdText = @"select * from VerificationCode where SellerId=?SellerId and Phone =?Phone and Code =?Code and ExpiredTime>?ExpiredTime limit 1;";
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?SellerId", sellerId));
            parameters.Add(new MySqlParameter("?Phone", phone));
            parameters.Add(new MySqlParameter("?Code", code));
            parameters.Add(new MySqlParameter("?ExpiredTime", DateTime.Now));
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText, parameters.ToArray());
                    return reader.HasRows;
                }
            }
            catch (System.Exception ex)
            {
                throw;
            }
            return false;
        }

        public static VerificationCode GetVerificationCodeByUid(int sellerId, int userId)
        {
            var cmdText = @"select * from VerificationCode where SellerId=?SellerId and UserId =?UserId and ExpiredTime>?ExpiredTime limit 1;";
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?SellerId", sellerId));
            parameters.Add(new MySqlParameter("?UserId", userId));
            parameters.Add(new MySqlParameter("?ExpiredTime", DateTime.Now));
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText, parameters.ToArray());
                    if (reader.HasRows)
                    {
                        if (reader.Read())
                        {
                            VerificationCode verificationCode = new VerificationCode();
                            verificationCode.Id = reader.GetInt32(0);
                            verificationCode.SellerId = (int)reader["SellerId"];
                            verificationCode.Phone = reader["Phone"].ToString();
                            verificationCode.Code = reader["Code"].ToString();
                            verificationCode.ExpiredTime = (DateTime)reader["ExpiredTime"];
                            return verificationCode;
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
        /// 保存验证码
        /// </summary>
        /// <param name="verificationCode"></param>
        /// <returns></returns>
        public static bool SaveVerificationCode(VerificationCode verificationCode)
        {
            var cmdText = string.Empty;
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            if (verificationCode.Id > 0)
            {
                cmdText = @"update VerificationCode set 
                                            ExpiredTime=?ExpiredTime, 
                                            Code=?Code, 
                                            UserId=?UserId
                                        where 
                                            Id=?Id;";
                parameters.Add(new MySqlParameter("?Id", verificationCode.Id));
                parameters.Add(new MySqlParameter("?ExpiredTime", verificationCode.ExpiredTime));
                parameters.Add(new MySqlParameter("?Code", verificationCode.Code));
                parameters.Add(new MySqlParameter("?UserId", verificationCode.UserId));
            }
            else
            {
                cmdText = @"insert into VerificationCode
                                                    (
                                                    ExpiredTime,
                                                    Code,
                                                    SellerId,
                                                    UserId,
                                                    Phone
                                                    ) 
                                                    values 
                                                    (
                                                   ?ExpiredTime,
                                                   ?Code,
                                                   ?SellerId,
                                                   ?UserId,
                                                   ?Phone
                                                    );";
                parameters.Add(new MySqlParameter("?ExpiredTime", verificationCode.ExpiredTime));
                parameters.Add(new MySqlParameter("?Code", verificationCode.Code));
                parameters.Add(new MySqlParameter("?SellerId", verificationCode.SellerId));
                parameters.Add(new MySqlParameter("?Phone", verificationCode.Phone));
                parameters.Add(new MySqlParameter("?UserId", verificationCode.UserId));
            }
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