using Backstage.Core.Entity;
using Backstage.Model;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace Backstage.Core.Handler
{
    public class ExtractMoneyHelper
    {
        public static ExtractMoney GetItem(int id)
        {
            ExtractMoney e = null;
            string commandText = @"select * from ExtractMoney where id = ?id";
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?id", id));
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text,
                        commandText, parameters.ToArray());
                    while (reader.Read())
                    {
                        e = new ExtractMoney();
                        e.Id = (int)reader["Id"];
                        e.SellerId = (int)reader["SellerId"];
                        e.CardNumber = (long)reader["CardNumber"];
                        e.Bank = reader["Bank"].ToString();
                        e.Balance = (float)reader["Balance"];
                        e.CreateTime = (DateTime)reader["CreateTime"];
                        e.Money = (float)reader["Money"];
                        e.AccountName = reader["AccountName"].ToString();
                        e.Status = (int)reader["Status"];
                        e.Fee = (float)reader["Fee"];
                    }
                }
            }
            catch (System.Exception ex)
            {
                throw;
            }
            return e;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="sellId"></param>
        /// <param name="type"></param>
        /// <param name="index"></param>
        /// <param name="size"></param>
        /// <param name="order">排序sql</param>
        /// <returns></returns>
        public static PagResults<ExtractMoney> GetPagings(int sellerId, int index, int size, string order = "order by CreateTime desc")
        {
            var results = new PagResults<ExtractMoney>();
            results.Results = new List<ExtractMoney>();
            List<MySqlParameter> parameters = new List<MySqlParameter>();

            string commandText = "";
            if (sellerId != 0)
            {
                commandText = @"select * from ExtractMoney where sellerId = ?sellerId " + order + " LIMIT ?index,?size";
                parameters.Add(new MySqlParameter("?sellerId", sellerId));
            }
            else
                commandText = @"select * from ExtractMoney " + order + " LIMIT ?index,?size";

            parameters.Add(new MySqlParameter("?index", index));
            parameters.Add(new MySqlParameter("?size", size));

            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text,
                        commandText, parameters.ToArray());
                    while (reader.Read())
                    {
                        ExtractMoney e = new ExtractMoney();
                        e.Id = (int)reader["Id"];
                        e.SellerId = (int)reader["SellerId"];
                        e.CardNumber = (long)reader["CardNumber"];
                        e.Bank = reader["Bank"].ToString();
                        e.Balance = (float)reader["Balance"];
                        e.CreateTime = (DateTime)reader["CreateTime"];
                        e.Money = (float)reader["Money"];
                        e.AccountName = reader["AccountName"].ToString();
                        e.Status = (int)reader["Status"];
                        e.Fee = (float)reader["Fee"];

                        results.Results.Add(e);
                    }

                    //一个函数有两次连接数据库 先把连接断开 然后重连
                    conn.Close();
                    conn.Dispose();
                    conn.Open();

                    commandText = "select count(*) from ExtractMoney where sellerId = ?sellerId";
                    parameters.Clear();
                    parameters.Add(new MySqlParameter("?sellerId", sellerId));
                    reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, commandText,
                        parameters.ToArray());
                    if (reader.HasRows)
                    {
                        if (reader.Read())
                        {
                            results.TotalCount = reader.GetInt32(0);
                        }
                    }
                }
            }
            catch (System.Exception ex)
            {
                throw;
            }
            return results;
        }
        public static void Create(ExtractMoney item)
        {
            string connectionString = GlobalConfig.DbConn;
            string commandText = @"INSERT INTO ExtractMoney 
        	                                ( 
        	                                SellerId, 
        	                                CardNumber,
        	                                Bank,
        	                                Balance,
        	                                Money,
        	                                CreateTime,
        	                                AccountName,
        	                                Status,
        	                                Fee
        	                                )
        	                                VALUES
        	                                ( 
        	                                ?SellerId, 
        	                                ?CardNumber, 
        	                                ?Bank,
        	                                ?Balance,
        	                                ?Money,
        	                                ?CreateTime,
        	                                ?AccountName,
        	                                ?Status,
        	                                ?Fee
        	                                )";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?SellerId", item.SellerId));
            parameters.Add(new MySqlParameter("?CardNumber", item.CardNumber));
            parameters.Add(new MySqlParameter("?Bank", item.Bank));
            parameters.Add(new MySqlParameter("?Balance", item.Balance));
            parameters.Add(new MySqlParameter("?Money", item.Money));
            parameters.Add(new MySqlParameter("?CreateTime", item.CreateTime));
            parameters.Add(new MySqlParameter("?AccountName", item.AccountName));
            parameters.Add(new MySqlParameter("?Status", item.Status));
            parameters.Add(new MySqlParameter("?Fee", item.Fee));

            MySqlHelper.ExecuteNonQuery(connectionString, CommandType.Text, commandText, parameters.ToArray());
        }

        internal static void Update(ExtractMoney item)
        {
            string commandText = @"UPDATE ExtractMoney SET
                                        SellerId = ?SellerId,
                                        CardNumber = ?CardNumber,
                                        Bank = ?Bank,
                                        Balance = ?Balance,
                                        Money = ?Money,
                                        AccountName = ?AccountName,
                                        CreateTime = ?CreateTime,
                                        Status = ?Status,
                                        Fee = ?Fee
                                    WHERE
                                        Id = ?Id";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?Id", item.Id));
            parameters.Add(new MySqlParameter("?SellerId", item.SellerId));
            parameters.Add(new MySqlParameter("?CardNumber", item.CardNumber));
            parameters.Add(new MySqlParameter("?Bank", item.Bank));
            parameters.Add(new MySqlParameter("?Balance", item.Balance));
            parameters.Add(new MySqlParameter("?Money", item.Money));
            parameters.Add(new MySqlParameter("?CreateTime", item.CreateTime));
            parameters.Add(new MySqlParameter("?AccountName", item.AccountName));
            parameters.Add(new MySqlParameter("?Status", item.Status));
            parameters.Add(new MySqlParameter("?Fee", item.Fee));

            MySqlHelper.ExecuteNonQuery(GlobalConfig.DbConn, CommandType.Text, commandText, parameters.ToArray());
        }


        internal static void Delete(int id)
        {
            string commandText = @"DELETE FROM ExtractMoney WHERE Id = ?Id";
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?Id", id));

            MySqlHelper.ExecuteNonQuery(GlobalConfig.DbConn, CommandType.Text, commandText, parameters.ToArray());
        }

    }
}