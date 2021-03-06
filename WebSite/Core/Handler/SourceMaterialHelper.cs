﻿
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
    public static class SourceMaterialHelper
    {
        public static SourceMaterial GetItem(int id)
        {
            SourceMaterial sm = null;
            string commandText = @"select * from material where id = ?id";
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?id", id));
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    //MySqlDataReader reader = MySqlHelper.ExecuteReader(GlobalConfig.DbConn, CommandType.Text, commandText, parameters.ToArray());
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, commandText, parameters.ToArray());
                    while (reader.Read())
                    {
                        sm = new SourceMaterial();
                        sm.Id = reader.GetInt32(0);
                        sm.Url = reader["Url"].ToString();
                        sm.Title = reader["Title"].ToString();
                        sm.Description = reader["Description"].ToString();
                        sm.Views = (int)reader["Views"];
                        sm.Commentnum = (int)reader["Commentnum"];
                        sm.SellerId = (int)reader["SellerId"];
                        sm.CreateTime = (DateTime)reader["CreateTime"];
                        sm.ImageType = (UploadType)reader["ImageType"];
                    }
                }

            }
            catch (System.Exception ex)
            {
                throw;
            }
            return sm;
        }


        public static PagResults<SourceMaterial> GetPaging(int pageIndex, int pageSize, int sellerId)
        {
            var results = new PagResults<SourceMaterial>();
            results.Results = new List<SourceMaterial>();
            int totalnum = 0;
            string commandText = @"select * from material where sellerId = ?sellerId order by CreateTime desc LIMIT ?index,?size";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?sellerId", sellerId));
            parameters.Add(new MySqlParameter("?index", pageIndex));
            parameters.Add(new MySqlParameter("?size", pageSize));

            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, commandText, parameters.ToArray());
                    while (reader.Read())
                    {
                        SourceMaterial sm = new SourceMaterial();
                        sm.Id = reader.GetInt32(0);
                        sm.Url = reader["Url"].ToString();
                        sm.Title = reader["Title"].ToString();
                        sm.Description = reader["Description"].ToString();
                        sm.Views = (int)reader["Views"];
                        sm.Commentnum = (int)reader["Commentnum"];
                        sm.SellerId = (int)reader["SellerId"];
                        sm.CreateTime = (DateTime)reader["CreateTime"];
                        sm.ImageType = (UploadType)reader["ImageType"];
                        results.Results.Add(sm);
                    }

                    //一个函数有两次连接数据库 先把连接断开 然后重连
                    conn.Close();
                    conn.Dispose();
                    conn.Open();

                    commandText = @"select count(*) from material where sellerId=?sellerId";
                    parameters.Clear();
                    parameters.Add(new MySqlParameter("?sellerId", sellerId));
                    
                    reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, commandText, parameters.ToArray());
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

        public static IList<SourceMaterial> GetList(int sellerId, int pageIndex, int pageSize)
        {
            var results = new List<SourceMaterial>();
            int skipnum = pageSize * pageIndex;
            int totalnum = 0;
            string commandText = @"select * from material where sellerId = ?sellerId LIMIT ?index,?size";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?sellerId", sellerId));
            parameters.Add(new MySqlParameter("?index", pageIndex));
            parameters.Add(new MySqlParameter("?size", pageSize));

            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, commandText, parameters.ToArray());
                    while (reader.Read())
                    {
                        SourceMaterial sm = new SourceMaterial();
                        sm.Id = reader.GetInt32(0);
                        sm.Url = reader["Url"].ToString();
                        sm.Title = reader["Title"].ToString();
                        sm.Description = reader["Description"].ToString();
                        sm.Views = (int)reader["Views"];
                        sm.Commentnum = (int)reader["Commentnum"];
                        sm.SellerId = (int)reader["SellerId"];
                        sm.CreateTime = (DateTime)reader["CreateTime"];
                        sm.ImageType = (UploadType)reader["ImageType"];
                        results.Add(sm);
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
        /// 
        /// </summary>
        /// <param name="start"></param>
        /// <param name="limit"></param>
        /// <param name="wheresql"></param>
        /// <param name="ordersql"></param>
        /// <returns></returns>
        public static IList<SourceMaterial> GetList(int start, int limit, string wheresql = "", string ordersql = "")
        {
            var results = new List<SourceMaterial>();
            string limitsql = limit == 0 ? string.Empty : " LIMIT ?start,?limit ";
            string commandText = @"select * from material " + wheresql + ordersql + limitsql;

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
                        SourceMaterial sm = new SourceMaterial();
                        sm.Id = reader.GetInt32(0);
                        sm.Url = reader["Url"].ToString();
                        sm.Title = reader["Title"].ToString();
                        sm.Description = reader["Description"].ToString();
                        sm.Views = (int)reader["Views"];
                        sm.Commentnum = (int)reader["Commentnum"];
                        sm.SellerId = (int)reader["SellerId"];
                        sm.CreateTime = (DateTime)reader["CreateTime"];
                        sm.ImageType = (UploadType)reader["ImageType"];
                        results.Add(sm);
                    }
                }
            }
            catch (System.Exception ex)
            {
                throw;
            }
            return results;
        }

        public static int Create(SourceMaterial sm)
        {
            string connectionString = GlobalConfig.DbConn;
            string commandText = @"INSERT INTO material 
        	                                ( 
        	                                Title, 
        	                                Url,
        	                                Description,
        	                                Views, 
        	                                Commentnum,
        	                                SellerId,
        	                                CreateTime,
        	                                ImageType
        	                                )
        	                                VALUES
        	                                ( 
        	                                ?Title, 
        	                                ?Url,
        	                                ?Description,
        	                                ?Views, 
        	                                ?Commentnum,
        	                                ?SellerId,
        	                                ?CreateTime,
        	                                ?ImageType
        	                                )";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?Title", sm.Title));
            parameters.Add(new MySqlParameter("?Url", sm.Url));
            parameters.Add(new MySqlParameter("?Description", sm.Description));
            parameters.Add(new MySqlParameter("?Views", sm.Views));
            parameters.Add(new MySqlParameter("?Commentnum", sm.Commentnum));
            parameters.Add(new MySqlParameter("?SellerId", sm.SellerId));
            parameters.Add(new MySqlParameter("?CreateTime", sm.CreateTime));
            parameters.Add(new MySqlParameter("?ImageType", sm.ImageType));


            using (var conn = Utility.ObtainConn(Utility._gameDbConn))
            {
                MySqlHelper.ExecuteNonQuery(conn, CommandType.Text, commandText, parameters.ToArray());

                var id = 0;
                commandText = @"select LAST_INSERT_ID();";
                var reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, commandText);
                if (reader.HasRows)
                {
                    if (reader.Read())
                    {
                        id = reader.GetInt32(0);
                    }
                }
                return id;
            }

        }

        public static void Update(SourceMaterial sm)
        {
            string commandText = @"UPDATE material SET
                                        Title = ?Title,
                                        Url = ?Url,
                                        Description = ?Description,
                                        Views = ?Views,
                                        Commentnum = ?Commentnum,
                                        SellerId = ?SellerId,
                                        CreateTime = ?CreateTime,
                                        ImageType = ?ImageType
                                    WHERE
                                        Id = ?Id";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?Id", sm.Id));
            parameters.Add(new MySqlParameter("?Title", sm.Title));
            parameters.Add(new MySqlParameter("?Url", sm.Url));
            parameters.Add(new MySqlParameter("?Description", sm.Description));
            parameters.Add(new MySqlParameter("?Views", sm.Views));
            parameters.Add(new MySqlParameter("?Commentnum", sm.Commentnum));
            parameters.Add(new MySqlParameter("?SellerId", sm.SellerId));
            parameters.Add(new MySqlParameter("?CreateTime", sm.CreateTime));
            parameters.Add(new MySqlParameter("?ImageType", sm.ImageType));

            MySqlHelper.ExecuteNonQuery(GlobalConfig.DbConn, CommandType.Text, commandText, parameters.ToArray());

        }

        //        public static void Delete(SourceMaterial sm)
        //        {
        //            string commandText = @"Delete material WHERE Id = ?Id";
        //            List<MySqlParameter> parameters = new List<MySqlParameter>();
        //            parameters.Add(new MySqlParameter("?Id", sm.Id));

        //            MySqlHelper.ExecuteNonQuery(GlobalConfig.DbConn, CommandType.Text, commandText, parameters.ToArray());
        //        }


        internal static void Delete(int id)
        {
            string commandText = @"DELETE FROM material WHERE Id = ?Id";
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?Id", id));

            MySqlHelper.ExecuteNonQuery(GlobalConfig.DbConn, CommandType.Text, commandText, parameters.ToArray());
        }
    }
}