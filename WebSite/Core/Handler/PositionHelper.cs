using Backstage.Core.Entity;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace Backstage.Core.Handler
{
    public class PositionHelper
    {
        public static Position GetItem(int id)
        {
            var p = new Position();
            string commandText = @"select * from position where id = ?id";
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
                        p.Id = reader.GetInt32(0);
                        p.ImgId = (int)reader["ImgId"];
                        p.ImgUrl = reader["ImgUrl"].ToString();
                        p.Title = reader["Title"].ToString();
                        p.Phone = (int)reader["Phone"];
                        p.Price = (float)reader["Price"];
                        p.SellerId = (int)reader["SellerId"];
                        p.Description = reader["CreateTime"].ToString();
                        p.Status = (int)reader["Status"];
                    }
                }

            }
            catch (System.Exception ex)
            {
                throw;
            }
            return p;
        }

        public static IList<Position> GetList(int sellerId, int pageIndex, int pageSize)
        {
            var results = new List<Position>();
            int skipnum = pageSize * pageIndex;
            int totalnum = 0;
            string commandText = @"select * from position where sellerId = ?sellerId LIMIT ?index,?size";

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
                        Position p = new Position();
                        p.Id = reader.GetInt32(0);
                        p.ImgId = (int)reader["ImgId"];
                        p.ImgUrl = reader["ImgUrl"].ToString();
                        p.Title = reader["Title"].ToString();
                        p.Phone = (int)reader["Phone"];
                        p.Price = (float)reader["Price"];
                        p.SellerId = (int)reader["SellerId"];
                        p.Description = reader["CreateTime"].ToString();
                        p.Status = (int)reader["Status"];
                        results.Add(p);
                    }
                }

            }
            catch (System.Exception ex)
            {
                throw;
            }
            return results;
        }

        public static void Update(Position sm)
        {
            //            string commandText = @"UPDATE position SET
            //                                        Title = ?Title,
            //                                        ImgId = ?ImgId,
            //                                        Description = ?Description,
            //                                        Views = ?Views,
            //                                        Commentnum = ?Commentnum,
            //                                        SellerId = ?SellerId,
            //                                        CreateTime = ?CreateTime
            //                                    WHERE
            //                                        Id = ?Id";

            //            List<MySqlParameter> parameters = new List<MySqlParameter>();
            //            parameters.Add(new MySqlParameter("?Id", sm.Id));
            //            parameters.Add(new MySqlParameter("?Title", sm.Title));
            //            parameters.Add(new MySqlParameter("?Url", sm.Url));
            //            parameters.Add(new MySqlParameter("?Description", sm.Description));
            //            parameters.Add(new MySqlParameter("?Views", sm.Views));
            //            parameters.Add(new MySqlParameter("?Commentnum", sm.Commentnum));
            //            parameters.Add(new MySqlParameter("?SellerId", sm.SellerId));
            //            parameters.Add(new MySqlParameter("?CreateTime", sm.CreateTime));


            //            MySqlHelper.ExecuteNonQuery(GlobalConfig.DbConn, CommandType.Text, commandText, parameters.ToArray());

        }

        internal static UserPosition GetUserPosition(int userId, int positionId)
        {
            var up = new UserPosition();
            string commandText = @"select * from userposition where userId = ?userId and positionId = ?positionId";
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?userId", userId));
            parameters.Add(new MySqlParameter("?positionId", positionId));
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    //MySqlDataReader reader = MySqlHelper.ExecuteReader(GlobalConfig.DbConn, CommandType.Text, commandText, parameters.ToArray());
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, commandText, parameters.ToArray());
                    while (reader.Read())
                    {
                        up.Id = reader.GetInt32(0);
                        up.PositionId = (int)reader["PositionId"];
                        up.NickName = reader["NickName"].ToString();
                        up.Message = reader["Message"].ToString();
                        up.UserId = (int)reader["UserId"];
                        up.SellerId = (int)reader["SellerId"];
                        up.Phone = (int)reader["Phone"];
                        up.CreateTime = (DateTime)reader["CreateTime"];
                        up.PayId = (int)reader["PayId"];
                        up.Status = (int)reader["Status"];
                    }
                }

            }
            catch (System.Exception ex)
            {
                throw;
            }
            return up;
        }

        internal static UserPosition GetUserPosition(int orderId)
        {
            var up = new UserPosition();
            string commandText = @"select * from userposition where orderId = ?orderId";
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?orderId", orderId));
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    //MySqlDataReader reader = MySqlHelper.ExecuteReader(GlobalConfig.DbConn, CommandType.Text, commandText, parameters.ToArray());
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, commandText, parameters.ToArray());
                    while (reader.Read())
                    {
                        up.Id = reader.GetInt32(0);
                        up.PositionId = (int)reader["PositionId"];
                        up.NickName = reader["NickName"].ToString();
                        up.Message = reader["Message"].ToString();
                        up.UserId = (int)reader["UserId"];
                        up.SellerId = (int)reader["SellerId"];
                        up.Phone = (int)reader["Phone"];
                        up.CreateTime = (DateTime)reader["CreateTime"];
                        up.PayId = (int)reader["PayId"];
                        up.Status = (int)reader["Status"];
                    }
                }

            }
            catch (System.Exception ex)
            {
                throw;
            }
            return up;
        }

        internal static void CreateUserPositon(UserPosition userPosition)
        {
            string connectionString = GlobalConfig.DbConn;
            string commandText = @"INSERT INTO userposition 
            	                                ( 
            	                                UserId, 
            	                                PositionId,
            	                                NickName,
           	                                    Message, 
            	                                SellerId,
           	                                    Phone, 
            	                                PayId,
            	                                CreateTime,
                                                Status
            	                                )
            	                                VALUES
            	                                ( 
            	                                ?UserId, 
            	                                ?PositionId,
            	                                ?NickName,
           	                                    ?Message, 
            	                                ?SellerId,
           	                                    ?Phone, 
            	                                ?PayId,
            	                                ?CreateTime,
                                                ?Status
            	                                )";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?UserId", userPosition.UserId));
            parameters.Add(new MySqlParameter("?PositionId", userPosition.PositionId));
            parameters.Add(new MySqlParameter("?NickName", userPosition.NickName));
            parameters.Add(new MySqlParameter("?Message", userPosition.Message));
            parameters.Add(new MySqlParameter("?SellerId", userPosition.SellerId));
            parameters.Add(new MySqlParameter("?Phone", userPosition.Phone));
            parameters.Add(new MySqlParameter("?PayId", userPosition.PayId));
            parameters.Add(new MySqlParameter("?CreateTime", DateTime.Now));
            parameters.Add(new MySqlParameter("?Status", userPosition.Status));



            MySqlHelper.ExecuteNonQuery(connectionString, CommandType.Text, commandText, parameters.ToArray());
        }

        internal static void UpdateUserPosition(UserPosition order)
        {
            string commandText = @"UPDATE position SET
                                                    UserId = ?UserId,
                                                    PositionId = ?PositionId,
                                                    NickName = ?NickName,
                                                    Message = ?Message,
                                                    Phone = ?Phone,
                                                    SellerId = ?SellerId,
                                                    PayId = ?PayId,
                                                    CreateTime = ?CreateTime
                                                    Status = ?Status
                                                WHERE
                                                    Id = ?Id";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?Id", order.Id));
            parameters.Add(new MySqlParameter("?UserId", order.UserId));
            parameters.Add(new MySqlParameter("?PositionId", order.PositionId));
            parameters.Add(new MySqlParameter("?NickName", order.NickName));
            parameters.Add(new MySqlParameter("?Message", order.Message));
            parameters.Add(new MySqlParameter("?SellerId", order.SellerId));
            parameters.Add(new MySqlParameter("?Phone", order.Phone));
            parameters.Add(new MySqlParameter("?PayId", order.PayId));
            parameters.Add(new MySqlParameter("?CreateTime", order.CreateTime));
            parameters.Add(new MySqlParameter("?Status", order.Status));


            MySqlHelper.ExecuteNonQuery(GlobalConfig.DbConn, CommandType.Text, commandText, parameters.ToArray());
        }
    }
}