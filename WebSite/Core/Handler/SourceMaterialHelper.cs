
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
            var sm = new SourceMaterial();
            string commandText = @"select * from material where id = ?id";
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?id", id));
            try
            {
                using (MySqlConnection conn = new MySqlConnection(GlobalConfig.DbConn))
                {
                    //MySqlDataReader reader = MySqlHelper.ExecuteReader(GlobalConfig.DbConn, CommandType.Text, commandText, parameters.ToArray());
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(GlobalConfig.DbConn, CommandType.Text, commandText, parameters.ToArray());
                    while (reader.Read())
                    {
                        sm.Id = reader.GetInt32(0);
                        sm.Url = reader["Url"].ToString();
                        sm.Title = reader["Title"].ToString();
                        sm.Description = reader["Description"].ToString();
                        sm.Views = (int)reader["Views"];
                        sm.Commentnum = (int)reader["Commentnum"];
                        sm.SellerId = (int)reader["SellerId"];
                        sm.CreateTime = (DateTime)reader["CreateTime"];
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
            int skipnum = pageSize * pageIndex;
            int totalnum = 0;
            string commandText = @"select * from material where sellerId = ?sellerId LIMIT ?index,?size";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?sellerId", sellerId));
            parameters.Add(new MySqlParameter("?index", pageIndex));
            parameters.Add(new MySqlParameter("?size", pageSize));

            try
            {
                using (MySqlConnection conn = new MySqlConnection(GlobalConfig.DbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(GlobalConfig.DbConn, CommandType.Text, commandText, parameters.ToArray());
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
                        results.Results.Add(sm);
                    }

                    commandText = @"select count(*) from material";
                    reader = MySqlHelper.ExecuteReader(GlobalConfig.DbConn, CommandType.Text, commandText, parameters.ToArray());
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
                using (MySqlConnection conn = new MySqlConnection(GlobalConfig.DbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(GlobalConfig.DbConn, CommandType.Text, commandText, parameters.ToArray());
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
                using (MySqlConnection conn = new MySqlConnection(GlobalConfig.DbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(GlobalConfig.DbConn, CommandType.Text, commandText, parameters.ToArray());
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

        //        public static void Create(SourceMaterial sm)
        //        {
        //            string connectionString = GlobalConfig.DbConn;
        //            string commandText = @"INSERT INTO material 
        //	                                ( 
        //	                                Name, 
        //	                                Address,
        //	                                Remark,
        //	                                )
        //	                                VALUES
        //	                                ( 
        //	                                ?Name, 
        //	                                ?Address, 
        //	                                ?Remark
        //	                                )";

        //            List<MySqlParameter> parameters = new List<MySqlParameter>();
        //            parameters.Add(new MySqlParameter("?Name", sm.Name));
        //            parameters.Add(new MySqlParameter("?Address", sm.Address));
        //            parameters.Add(new MySqlParameter("?Remark", sm.Remark));

        //            MySqlHelper.ExecuteNonQuery(connectionString, CommandType.Text, commandText, parameters.ToArray());
        //        }

        public static void Update(SourceMaterial sm)
        {
            string commandText = @"UPDATE material SET
                                        Title = ?Title,
                                        Url = ?Url,
                                        Description = ?Description,
                                        Views = ?Views,
                                        Commentnum = ?Commentnum,
                                        SellerId = ?SellerId,
                                        CreateTime = ?CreateTime
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


            MySqlHelper.ExecuteNonQuery(GlobalConfig.DbConn, CommandType.Text, commandText, parameters.ToArray());

        }

        //        public static void Delete(SourceMaterial sm)
        //        {
        //            string commandText = @"Delete material WHERE Id = ?Id";
        //            List<MySqlParameter> parameters = new List<MySqlParameter>();
        //            parameters.Add(new MySqlParameter("?Id", sm.Id));

        //            MySqlHelper.ExecuteNonQuery(GlobalConfig.DbConn, CommandType.Text, commandText, parameters.ToArray());
        //        }

    }
}