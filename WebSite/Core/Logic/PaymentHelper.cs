using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using Backstage.Core.Entity;
using MySql.Data.MySqlClient;

namespace Backstage.Core.Logic
{
    public static class PaymentHelper
    {
        /// <summary>
        /// 获取支付列表
        /// </summary>
        /// <returns></returns>
        public static List<Payment> GetList()
        {
            List<Payment> list = new List<Payment>();
            var cmdText = @"select * from Payment;";

            //List<MySqlParameter> parameters = new List<MySqlParameter>();
            //parameters.Add(new MySqlParameter("?SellerId", sellerId));
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText);
                    while (reader.Read())
                    {
                        Payment payment = new Payment();
                        payment.Id = reader.GetInt32(0);
                        payment.Description = reader["Description"].ToString();
                        payment.Name = reader["Name"].ToString();
                        payment.ImgUrl = reader["ImgUrl"].ToString();
                        payment.Account = reader["Account"].ToString();
                        payment.PrivateKey = reader["PrivateKey"].ToString();
                        payment.Pid = reader["Pid"].ToString();
                        payment.AccountType = (int)reader["AccountType"];
                        payment.Status = (int)reader["Status"];

                        list.Add(payment);
                    }
                }
            }
            catch (System.Exception ex)
            {
                throw;
            }
            return list;
        }
        /// <summary>
        /// 获取支付方式项
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static Payment GetPayment(int id)
        {
            var cmdText = string.Format("select * from Payment where Id={0} limit 1;", id);
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText);
                    if (reader.HasRows)
                    {
                        if (reader.Read())
                        {
                            Payment payment = new Payment();
                            payment.Id = reader.GetInt32(0);
                            payment.Description = reader["Description"].ToString();
                            payment.Name = reader["Name"].ToString();
                            payment.ImgUrl = reader["ImgUrl"].ToString();
                            payment.Account = reader["Account"].ToString();
                            payment.PrivateKey = reader["PrivateKey"].ToString();
                            payment.Pid = reader["Pid"].ToString();
                            payment.AccountType = (int)reader["AccountType"];
                            payment.Status = (int)reader["Status"];
                            return payment;
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
        /// 保存（新增/修改）支付方式
        /// </summary>
        /// <param name="payment"></param>
        /// <returns></returns>
        public static bool SavePayment(Payment payment)
        {
            var cmdText = string.Empty;
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            if (payment.Id > 0)
            {
                cmdText = @"UPDATE Payment SET
                                        Name                    = ?Name        ,
                                        Description             = ?Description       ,
                                        ImgUrl                  = ?ImgUrl     ,
                                        Account                 = ?Account       ,
                                        PrivateKey              = ?PrivateKey ,
                                        Pid                     = ?Pid      ,
                                        AccountType             = ?AccountType       ,
                                        Status                  = ?Status  
                                    WHERE
                                        Id                      =?Id";

                parameters.Add(new MySqlParameter("?Name", payment.Name));
                parameters.Add(new MySqlParameter("?Description", payment.Description));
                parameters.Add(new MySqlParameter("?ImgUrl", payment.ImgUrl));
                parameters.Add(new MySqlParameter("?Account", payment.Account));
                parameters.Add(new MySqlParameter("?PrivateKey", payment.PrivateKey));
                parameters.Add(new MySqlParameter("?Pid", payment.Pid));
                parameters.Add(new MySqlParameter("?AccountType", payment.AccountType));
                parameters.Add(new MySqlParameter("?Status", payment.Status));
                parameters.Add(new MySqlParameter("?Id",payment.Id));
            }
            else
            {
                cmdText = @"insert into Payment
                                        (
                                        Name       ,
                                        Description  ,
                                        ImgUrl       ,
                                        Account      ,
                                        PrivateKey   ,
                                        Pid          ,
                                        AccountType  ,
                                        Status       
                                        ) 
                                        values
                                        (
                                        ?Name       ,
                                        ?Description  ,
                                        ?ImgUrl       ,
                                        ?Account      ,
                                        ?PrivateKey   ,
                                        ?Pid          ,
                                        ?AccountType  ,
                                        ?Status       
                                        )";
                parameters.Add(new MySqlParameter("?Name", payment.Name));
                parameters.Add(new MySqlParameter("?Description", payment.Description));
                parameters.Add(new MySqlParameter("?ImgUrl", payment.ImgUrl));
                parameters.Add(new MySqlParameter("?Account", payment.Account));
                parameters.Add(new MySqlParameter("?PrivateKey", payment.PrivateKey));
                parameters.Add(new MySqlParameter("?Pid", payment.Pid));
                parameters.Add(new MySqlParameter("?AccountType", payment.AccountType));
                parameters.Add(new MySqlParameter("?Status", payment.Status));
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

        /// <summary>
        /// 删除支付方式
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static bool DeletePayment(int id)
        {
            var cmdText = String.Format("delete from Payment where Id={0} limit 1;", id);
            try
            {
                return MySqlHelper.ExecuteNonQuery(Utility._gameDbConn, CommandType.Text, cmdText) > 0;
            }
            catch (System.Exception ex)
            {
                throw;
            }
        }
    }
}