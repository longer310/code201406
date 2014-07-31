using Backstage.Core.Entity;
using Backstage.Model;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace Backstage.Core
{
    public class ActiveHelper
    {

        public static Active GetItem(int id)
        {
            Active a = null;
            string commandText = @"select * from active where id = ?id";
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
                        a = new Active();
                        a.Id = reader.GetInt32(0);
                        a.SellerId = (int)reader["SellerId"];
                        a.CoverImgId = (int)reader["CoverImgId"];
                        a.Title = reader["Title"].ToString();
                        a.Summary = reader["Summary"].ToString();
                        a.CreateTime = (DateTime)reader["CreateTime"];
                        a.Views = (int)reader["Views"];
                        a.Commentnum = (int)reader["Commentnum"];
                    }
                }
            }
            catch (System.Exception ex)
            {
                throw;
            }
            return a;
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
        public static PagResults<Active> GetPagings(int sellerId, int index, int size, string order = "")
        {
            var results = new PagResults<Active>();
            results.Results = new List<Active>();
            string commandText = @"select * from active where sellerId = ?sellerId LIMIT ?index,?size " + order;

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?sellerId", sellerId));
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
                        Active a = new Active();
                        a.Id = (int)reader["Id"];
                        a.SellerId = (int)reader["SellerId"];
                        a.CoverImgId = (int)reader["CoverImgId"];
                        a.CoverImgUrl = reader["CoverImgUrl"].ToString();
                        a.Title = reader["Title"].ToString();
                        a.Summary = reader["Summary"].ToString();
                        a.CreateTime = (DateTime)reader["CreateTime"];
                        a.Views = (int)reader["Views"];
                        a.Commentnum = (int)reader["Commentnum"];
                        results.Results.Add(a);
                    }

                    //一个函数有两次连接数据库 先把连接断开 然后重连
                    conn.Close();
                    conn.Dispose();
                    conn.Open();

                    commandText = "select count(*) from active where sellerId = ?sellerId";
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

        /// <summary>
        /// 活动列表
        /// </summary>
        /// <param name="start"></param>
        /// <param name="limit"></param>
        /// <param name="wheresql"></param>
        /// <param name="ordersql"></param>
        /// <returns></returns>
        public static IList<Active> GetList(int start, int limit, string wheresql = "", string ordersql = "")
        {
            var results = new List<Active>();
            string limitsql = limit == 0 ? string.Empty : " LIMIT ?start,?limit ";
            string commandText = @"select * from active " + wheresql + ordersql + limitsql;

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?start", start));
            parameters.Add(new MySqlParameter("?limit", limit));

            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, commandText, parameters.ToArray());
                    while (reader.Read())
                    {
                        Active a = new Active();
                        a.Id = (int)reader["Id"];
                        a.SellerId = (int)reader["SellerId"];
                        a.CoverImgId = (int)reader["CoverImgId"];
                        a.Title = reader["Title"].ToString();
                        a.Summary = reader["Summary"].ToString();
                        a.CreateTime = (DateTime)reader["CreateTime"];
                        a.CoverImgUrl = reader["CoverImgUrl"].ToString();
                        a.Views = (int)reader["Views"];
                        a.Commentnum = (int)reader["Commentnum"];
                        results.Add(a);
                    }
                }
            }
            catch (System.Exception ex)
            {
                throw;
            }
            return results;
        }



        internal static void Update(Active active)
        {
            string commandText = @"UPDATE active SET
                                        SellerId = ?SellerId,
                                        CoverImgId = ?CoverImgId,
                                        CoverImgUrl = ?CoverImgUrl,
                                        Title = ?Title,
                                        Summary = ?Summary,
                                        Description = ?Description,
                                        Commentnum = ?Commentnum,
                                        CreateTime = ?CreateTime,
                                        Views = ?Views
                                    WHERE
                                        Id = ?Id";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?Id", active.Id));
            parameters.Add(new MySqlParameter("?SellerId", active.SellerId));
            parameters.Add(new MySqlParameter("?CoverImgId", active.CoverImgId));
            parameters.Add(new MySqlParameter("?CoverImgUrl", active.CoverImgUrl));
            parameters.Add(new MySqlParameter("?Title", active.Title));
            parameters.Add(new MySqlParameter("?Summary", active.Summary));
            parameters.Add(new MySqlParameter("?Description", active.Description));
            parameters.Add(new MySqlParameter("?Commentnum", active.Commentnum));
            parameters.Add(new MySqlParameter("?CreateTime", active.CreateTime));
            parameters.Add(new MySqlParameter("?Views", active.Views));

            MySqlHelper.ExecuteNonQuery(GlobalConfig.DbConn, CommandType.Text, commandText, parameters.ToArray());
        }

        public static void Create(Active active)
        {
            string connectionString = GlobalConfig.DbConn;
            string commandText = @"INSERT INTO material 
        	                                ( 
        	                                SellerId, 
        	                                CoverImgId,
        	                                CoverImgUrl,
        	                                Title, 
        	                                Summary,
        	                                Description,
        	                                Commentnum,
        	                                CreateTime,
        	                                Views
        	                                )
        	                                VALUES
        	                                ( 
        	                                ?SellerId, 
        	                                ?CoverImgId,
        	                                ?CoverImgUrl,
        	                                ?Title, 
        	                                ?Summary,
        	                                ?Description,
        	                                ?Commentnum,
        	                                ?CreateTime,
        	                                ?Views
        	                                )";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?SellerId", active.SellerId));
            parameters.Add(new MySqlParameter("?CoverImgId", active.CoverImgId));
            parameters.Add(new MySqlParameter("?CoverImgUrl", active.CoverImgUrl));
            parameters.Add(new MySqlParameter("?Title", active.Title));
            parameters.Add(new MySqlParameter("?Summary", active.Summary));
            parameters.Add(new MySqlParameter("?Description", active.Description));
            parameters.Add(new MySqlParameter("?Commentnum", active.Commentnum));
            parameters.Add(new MySqlParameter("?CreateTime", active.CreateTime));
            parameters.Add(new MySqlParameter("?Views", active.Views));
            MySqlHelper.ExecuteNonQuery(connectionString, CommandType.Text, commandText, parameters.ToArray());
        }


        internal static void Delete(int id)
        {
            string commandText = @"DELETE FROM active WHERE Id = ?Id";
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?Id", id));

            MySqlHelper.ExecuteNonQuery(GlobalConfig.DbConn, CommandType.Text, commandText, parameters.ToArray());
        }
    }
}