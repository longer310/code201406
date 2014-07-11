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
    public static class CommentHelper
    {

        public static PagResults<Comment> GetList(int index, int size)
        {
            throw new NotImplementedException();
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
        public static PagResults<Comment> GetPagings(int sellerId, CommentType type, int typeId, int index, int size, string order = "")
        {
            var results = new PagResults<Comment>();
            results.Results = new List<Comment>();
            int skipnum = index * size;
            int totalnum = 0;
            string commandText = @"select * from comment where sellerId = ?sellerId and type = ?type and typeId = ?typeId LIMIT ?index,?size " + order;

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?sellerId", sellerId));
            parameters.Add(new MySqlParameter("?type", (int)type));
            parameters.Add(new MySqlParameter("?typeId", typeId));
            parameters.Add(new MySqlParameter("?index", index));
            parameters.Add(new MySqlParameter("?size", size));

            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, commandText, parameters.ToArray());
                    while (reader.Read())
                    {
                        Comment c = new Comment();
                        c.Id = (int)reader["Id"];
                        c.SellerId = (int)reader["SellerId"];
                        c.Type = type;
                        c.TypeId = typeId;
                        c.Content = reader["Content"].ToString();
                        c.CreateTime = (DateTime)reader["CreateTime"];
                        c.UserId = (int)reader["UserId"];
                        results.Results.Add(c);
                    }

                    //一个函数有两次连接数据库 先把连接断开 然后重连
                    conn.Close();
                    conn.Dispose();
                    conn.Open();

                    commandText = "select count(*) from comment where sellerId = ?sellerId and type = ?type and typeId = ?typeId";
                    parameters.Clear();
                    parameters.Add(new MySqlParameter("?sellerId", sellerId));
                    parameters.Add(new MySqlParameter("?type", (int)type));
                    parameters.Add(new MySqlParameter("?typeId", typeId));
                    reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, commandText, parameters.ToArray());
                    while (reader.Read())
                    {
                        results.TotalCount = reader.GetInt32(0);
                    }
                }
            }
            catch (System.Exception ex)
            {
                throw;
            }
            return results;
        }




        public static void Create(Comment c)
        {
            string connectionString = GlobalConfig.DbConn;
            string commandText = @"INSERT INTO comment 
            	                                ( 
            	                                SellerId,
            	                                Type,
            	                                TypeId, 
            	                                Content,
            	                                UserId,
            	                                CreateTime
            	                                )
            	                                VALUES
            	                                (  
            	                                ?SellerId,
            	                                ?Type,
            	                                ?TypeId, 
            	                                ?Content,
            	                                ?UserId,
            	                                ?CreateTime
            	                                )";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?SellerId", c.SellerId));
            parameters.Add(new MySqlParameter("?Type", c.Type));
            parameters.Add(new MySqlParameter("?TypeId", c.TypeId));
            parameters.Add(new MySqlParameter("?Content", c.Content));
            parameters.Add(new MySqlParameter("?UserId", c.UserId));
            parameters.Add(new MySqlParameter("?CreateTime", DateTime.Now));

            MySqlHelper.ExecuteNonQuery(connectionString, CommandType.Text, commandText, parameters.ToArray());
        }
    }
}