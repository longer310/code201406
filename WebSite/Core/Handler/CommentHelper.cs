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

        public static Comment GetItem(int id)
        {
            Comment a = null;
            string commandText = @"select * from comment where id = ?id";
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
                        a = new Comment();
                        a.Id = (int)reader["Id"];
                        a.SellerId = (int)reader["SellerId"];
                        a.Content = reader["Content"].ToString();
                        a.CreateTime = (DateTime)reader["CreateTime"];
                        a.Feedback = reader["Feedback"].ToString();
                        a.Title = reader["Title"].ToString();
                        a.Img = reader["Img"].ToString();
                        a.Type = (CommentType)reader["Type"];
                        a.TypeId = (int)reader["TypeId"];
                        a.UserId = (int)reader["UserId"];
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
        public static PagResults<Comment> GetPagings(int sellerId, CommentType type, int typeId, int index, int size, string order = "order by CreateTime desc")
        {
            var results = new PagResults<Comment>();
            results.Results = new List<Comment>();
            int skipnum = index * size;
            int totalnum = 0;
            string commandText = "";
            if (type == CommentType.All)
                commandText = @"select * from comment where sellerId = ?sellerId " + order + " LIMIT ?index,?size";
            else
                commandText = @"select * from comment where sellerId = ?sellerId and type = ?type and typeId = ?typeId " + order + " LIMIT ?index,?size";



            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?sellerId", sellerId));
            if (type != CommentType.All)
            {
                parameters.Add(new MySqlParameter("?type", (int)type));
                parameters.Add(new MySqlParameter("?typeId", typeId));
            }
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
                        c.Img = reader["Img"].ToString();
                        c.Title = reader["Title"].ToString();
                        c.Feedback = reader["Feedback"].ToString();
                        results.Results.Add(c);
                    }

                    //一个函数有两次连接数据库 先把连接断开 然后重连
                    conn.Close();
                    conn.Dispose();
                    conn.Open();
                    if (type == CommentType.All)
                        commandText = @"select count(*) from comment where sellerId = ?sellerId ";
                    else
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
            	                                Img,
            	                                Title,
            	                                UserId,
            	                                CreateTime,
            	                                Feedback
            	                                )
            	                                VALUES
            	                                (  
            	                                ?SellerId,
            	                                ?Type,
            	                                ?TypeId, 
            	                                ?Content,
            	                                ?Img,
            	                                ?Title,
            	                                ?UserId,
            	                                ?CreateTime,
            	                                ?Feedback
            	                                )";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?SellerId", c.SellerId));
            parameters.Add(new MySqlParameter("?Type", c.Type));
            parameters.Add(new MySqlParameter("?TypeId", c.TypeId));
            parameters.Add(new MySqlParameter("?Content", c.Content));
            parameters.Add(new MySqlParameter("?Img", c.Img));
            parameters.Add(new MySqlParameter("?Title", c.Title));
            parameters.Add(new MySqlParameter("?UserId", c.UserId));
            parameters.Add(new MySqlParameter("?CreateTime", DateTime.Now));
            parameters.Add(new MySqlParameter("?Feedback", c.Feedback));


            MySqlHelper.ExecuteNonQuery(connectionString, CommandType.Text, commandText, parameters.ToArray());
        }

        public static void Update(Comment c)
        {
            string commandText = @"UPDATE comment SET
                                        Type = ?Type,
                                        TypeId = ?TypeId,
                                        Content = ?Content,
                                        Img = ?Img,
                                        Title = ?Title,
                                        UserId = ?UserId,
                                        CreateTime = ?CreateTime,
                                        Feedback = ?Feedback
                                    WHERE
                                        Id = ?Id";

            string connectionString = GlobalConfig.DbConn;

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?Id", c.Id));
            parameters.Add(new MySqlParameter("?SellerId", c.SellerId));
            parameters.Add(new MySqlParameter("?Type", c.Type));
            parameters.Add(new MySqlParameter("?TypeId", c.TypeId));
            parameters.Add(new MySqlParameter("?Content", c.Content));
            parameters.Add(new MySqlParameter("?Img", c.Img));
            parameters.Add(new MySqlParameter("?Title", c.Title));
            parameters.Add(new MySqlParameter("?UserId", c.UserId));
            parameters.Add(new MySqlParameter("?CreateTime", DateTime.Now));
            parameters.Add(new MySqlParameter("?Feedback", c.Feedback));
            MySqlHelper.ExecuteNonQuery(connectionString, CommandType.Text, commandText, parameters.ToArray());
        }


        /// <summary>
        /// 获取用户评论
        /// </summary>
        /// <param name="uid"></param>
        /// <param name="sellerId"></param>
        /// <param name="type"></param>
        /// <param name="start"></param>
        /// <param name="limit"></param>
        /// <returns></returns>
        public static PagResults<Comment> GetList(int uid, int sellerId, CommentType type, int start, int limit, int isgetcount = 0)
        {
            var results = new PagResults<Comment>();
            results.Results = new List<Comment>();
            var wheresql = (type == CommentType.All ? string.Empty : "and Type = ?Type ");
            var ordersql = " order by CreateTime desc ";
            var limitsql = limit != 0 ? " LIMIT ?Start,?Limit" : string.Empty;
            string commandText = @"select * from comment where UserId = ?UserId and SellerId = ?SellerId  " + wheresql + ordersql + limitsql;

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?UserId", uid));
            parameters.Add(new MySqlParameter("?SellerId", sellerId));
            parameters.Add(new MySqlParameter("?Type", (int)type));
            parameters.Add(new MySqlParameter("?Start", start));
            parameters.Add(new MySqlParameter("?Limit", limit));

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
                        c.Type = (CommentType)reader["Type"];
                        c.TypeId = (int)reader["TypeId"];
                        c.Content = reader["Content"].ToString();
                        c.Img = reader["Img"].ToString();
                        c.Title = reader["Title"].ToString();
                        c.CreateTime = (DateTime)reader["CreateTime"];
                        c.UserId = (int)reader["UserId"];
                        results.Results.Add(c);
                    }

                    if (isgetcount > 0)
                    {
                        //一个函数有两次连接数据库 先把连接断开 然后重连
                        conn.Close();
                        conn.Dispose();
                        conn.Open();

                        commandText = "select count(*) from comment where UserId = ?UserId and SellerId = ?SellerId  " + wheresql;
                        parameters.Clear();
                        parameters.Add(new MySqlParameter("?UserId", uid));
                        parameters.Add(new MySqlParameter("?SellerId", sellerId));
                        parameters.Add(new MySqlParameter("?Type", (int)type));
                        reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, commandText, parameters.ToArray());
                        while (reader.Read())
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
        /// 获取用户评论列表
        /// </summary>
        /// <param name="uid"></param>
        /// <param name="ids"></param>
        /// <returns></returns>
        public static List<Comment> GetList(int uid, string ids)
        {
            var list = new List<Comment>();
            //string commandText = @"select * from comment where Id IN(??afsdfsdf);";
            string commandText = string.Format("select * from comment where UserId = {0} and Id in({1});", uid, ids);

            //List<MySqlParameter> parameters = new List<MySqlParameter>();
            //parameters.Add(new MySqlParameter("?UserId", uid));
            //gidList = new List<int>() { 215, 216 };
            //parameters.Add(new MySqlParameter("??afsdfsdf", string.Join(",", gidList.ToArray())));

            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, commandText);//, parameters.ToArray()
                    while (reader.Read())
                    {
                        Comment c = new Comment();
                        c.Id = (int)reader["Id"];
                        c.SellerId = (int)reader["SellerId"];
                        c.Type = (CommentType)reader["Type"];
                        c.TypeId = (int)reader["TypeId"];
                        c.Content = reader["Content"].ToString();
                        c.Img = reader["Img"].ToString();
                        c.Title = reader["Title"].ToString();
                        c.CreateTime = (DateTime)reader["CreateTime"];
                        c.UserId = (int)reader["UserId"];
                        list.Add(c);
                    }
                }
            }
            catch (System.Exception ex)
            {
                throw;
            }
            return list;
        }

        public static void Delete(int id)
        {
            string commandText = @"delete from comment where id=?id";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?id", id));
            MySqlHelper.ExecuteNonQuery(GlobalConfig.DbConn, CommandType.Text, commandText, parameters.ToArray());
        }

        /// <summary>
        /// 删除用户评论列表
        /// </summary>
        /// <param name="uid"></param>
        /// <param name="ids"></param>
        /// <returns></returns>
        public static bool DelList(int uid, string ids)
        {
            //string commandText = @"delete from comment where UserId = ?UserId and Id in(?Id);";
            string commandText = string.Format("delete from comment where UserId = {0} and Id in({1});", uid, ids);

            //List<MySqlParameter> parameters = new List<MySqlParameter>();
            //parameters.Add(new MySqlParameter("?UserId", uid));
            //parameters.Add(new MySqlParameter("?Id", ids));

            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    return MySqlHelper.ExecuteNonQuery(conn, CommandType.Text, commandText) > 0;//, parameters.ToArray()
                }
            }
            catch (System.Exception ex)
            {
                throw;
            }
            return false;
        }
    }
}