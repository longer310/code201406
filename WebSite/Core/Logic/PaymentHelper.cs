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
    }
}