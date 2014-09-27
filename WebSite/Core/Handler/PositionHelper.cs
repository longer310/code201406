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
    public class PositionHelper
    {
        #region Position
        public static void Create(Position p)
        {
            string connectionString = GlobalConfig.DbConn;
            string commandText = @"INSERT INTO position 
        	                                ( 
        	                                SellerId, 
        	                                BoxTypeId,
        	                                ImgUrls,
        	                                BoxNumber,
        	                                Price,
        	                                Description,
        	                                Phone,
        	                                Status,
                                            CreateTime
        	                                )
        	                                VALUES
        	                                ( 
        	                                ?SellerId, 
        	                                ?BoxTypeId,
        	                                ?ImgUrls,
        	                                ?BoxNumber,
        	                                ?Price,
        	                                ?Description,
        	                                ?Phone,
        	                                ?Status,
        	                                ?CreateTime
        	                                )";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?SellerId", p.SellerId));
            parameters.Add(new MySqlParameter("?BoxTypeId", p.BoxTypeId));
            parameters.Add(new MySqlParameter("?ImgUrls", p.ImgUrls));
            parameters.Add(new MySqlParameter("?BoxNumber", p.BoxNumber));
            parameters.Add(new MySqlParameter("?Price", p.Price));
            parameters.Add(new MySqlParameter("?Description", p.Description));
            parameters.Add(new MySqlParameter("?Phone", p.Phone));
            parameters.Add(new MySqlParameter("?Status", p.Status));
            parameters.Add(new MySqlParameter("?CreateTime", p.CreateTime));
            MySqlHelper.ExecuteNonQuery(connectionString, CommandType.Text, commandText, parameters.ToArray());

        }

        public static void Delete(int id)
        {
            string commandText = @"DELETE FROM position WHERE Id = ?Id";
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?Id", id));

            MySqlHelper.ExecuteNonQuery(GlobalConfig.DbConn, CommandType.Text, commandText, parameters.ToArray());
        }
        internal static IList<Position> GetListByBoxTypeId(int boxTypeId)
        {

            var results = new List<Position>();
            int totalnum = 0;
            string commandText = @"select * from position where boxTypeId = ?boxTypeId";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?boxTypeId", boxTypeId));

            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, commandText, parameters.ToArray());
                    while (reader.Read())
                    {
                        Position p = new Position();
                        p.Id = reader.GetInt32(0);
                        p.ImgUrls = reader["ImgUrls"].ToString();
                        p.BoxNumber = reader["BoxNumber"].ToString();
                        p.Phone = reader["Phone"].ToString();
                        p.Price = (float)reader["Price"];
                        p.SellerId = (int)reader["SellerId"];
                        p.Description = reader["Description"].ToString();
                        p.Status = (int)reader["Status"];
                        p.BoxTypeId = (int)reader["BoxTypeId"];
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
        public static void Update(Position p)
        {
            string commandText = @"UPDATE position SET
                                                    SellerId = ?SellerId, 
        	                                        BoxTypeId = ?BoxTypeId,
        	                                        ImgUrls = ?ImgUrls,
        	                                        BoxNumber = ?BoxNumber,
        	                                        Price = ?Price,
        	                                        Description = ?Description,
        	                                        Phone = ?Phone,
        	                                        Status = Status,
                                                    CreateTime = CreateTime
                                                WHERE
                                                    Id = ?Id";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?Id", p.Id));
            parameters.Add(new MySqlParameter("?SellerId", p.SellerId));
            parameters.Add(new MySqlParameter("?BoxTypeId", p.BoxTypeId));
            parameters.Add(new MySqlParameter("?ImgUrls", p.ImgUrls));
            parameters.Add(new MySqlParameter("?BoxNumber", p.BoxNumber));
            parameters.Add(new MySqlParameter("?Price", p.Price));
            parameters.Add(new MySqlParameter("?Description", p.Description));
            parameters.Add(new MySqlParameter("?Phone", p.Phone));
            parameters.Add(new MySqlParameter("?Status", p.Status));
            parameters.Add(new MySqlParameter("?CreateTime", p.CreateTime));

            MySqlHelper.ExecuteNonQuery(GlobalConfig.DbConn, CommandType.Text, commandText, parameters.ToArray());

        }

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
                        p.ImgUrls = reader["ImgUrls"].ToString();
                        p.BoxNumber = reader["BoxNumber"].ToString();
                        p.Phone = reader["Phone"].ToString();
                        p.Price = (float)reader["Price"];
                        p.SellerId = (int)reader["SellerId"];
                        p.Description = reader["Description"].ToString();
                        p.Status = (int)reader["Status"];
                        p.BoxTypeId = (int)reader["BoxTypeId"];
                    }
                }

            }
            catch (System.Exception ex)
            {
                throw;
            }
            return p;
        }

        public static IList<Position> GetList(int sellerId, int pageIndex, int pageSize, int cid = 0, int status = -1)
        {
            var results = new List<Position>();
            int totalnum = 0;
            string commandText = @"select * from position where sellerId = ?sellerId";
            if (cid != 0)
                commandText += (" and BoxTypeId = " + cid);
            if (status != -1)
                commandText += (" and status = " + status);
            commandText += " LIMIT ?index,?size";
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
                        //p.ImgId = (int)reader["ImgId"];
                        p.ImgUrls = reader["ImgUrls"].ToString();
                        p.BoxNumber = reader["BoxNumber"].ToString();
                        p.Phone = reader["Phone"].ToString();
                        p.Price = (float)reader["Price"];
                        p.SellerId = (int)reader["SellerId"];
                        p.Description = reader["Description"].ToString();
                        p.Status = (int)reader["Status"];
                        p.BoxTypeId = (int)reader["BoxTypeId"];
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

        public static PagResults<Position> GetPaging(int sellerId, int pageIndex, int pageSize, int cid = 0, int status = -1)
        {
            var results = new PagResults<Position>();
            int totalnum = 0;
            string commandText = @"select * from position where sellerId = ?sellerId order by CreateTime desc";
            if (cid != 0)
                commandText += (" and BoxTypeId = " + cid);
            if (status != -1)
                commandText += (" and status = " + status);
            commandText += " LIMIT ?index,?size";
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
                        //p.ImgId = (int)reader["ImgId"];
                        p.ImgUrls = reader["ImgUrls"].ToString();
                        p.BoxNumber = reader["BoxNumber"].ToString();
                        p.Phone = reader["Phone"].ToString();
                        p.Price = (float)reader["Price"];
                        p.SellerId = (int)reader["SellerId"];
                        p.Description = reader["Description"].ToString();
                        p.Status = (int)reader["Status"];
                        p.BoxTypeId = (int)reader["BoxTypeId"];
                        p.CreateTime =(DateTime)reader["CreateTime"];
                        results.Results.Add(p);
                    }

                    //一个函数有两次连接数据库 先把连接断开 然后重连
                    conn.Close();
                    conn.Dispose();
                    conn.Open();

                    commandText = @"select count(*) from position where sellerId = ?sellerId";
                    parameters.Clear();
                    parameters.Add(new MySqlParameter("?sellerId", sellerId));
                    if (cid != 0)
                        commandText += (" and BoxTypeId = " + cid);
                    if (status != -1)
                        commandText += (" and status = " + status);

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

        #endregion

        #region BoxType

        public static IList<BoxType> GetListBoxTypes(int sellerId, int pageIndex, int pageSize)
        {
            var results = new List<BoxType>();
            string commandText = @"select * from boxtype where sellerId = ?sellerId LIMIT ?index,?size";
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            if (pageSize == 0)
            {
                commandText = @"select * from boxtype where sellerId = ?sellerId";
                parameters.Add(new MySqlParameter("?sellerId", sellerId));
            }
            else
            {
                parameters.Add(new MySqlParameter("?sellerId", sellerId));
                parameters.Add(new MySqlParameter("?index", pageIndex));
                parameters.Add(new MySqlParameter("?size", pageSize));
            }
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, commandText, parameters.ToArray());
                    while (reader.Read())
                    {
                        BoxType b = new BoxType();
                        b.Id = reader.GetInt32(0);
                        b.SellerId = (int)reader["SellerId"];
                        b.HoldNum = (int)reader["HoldNum"];
                        b.Lowest = (int)reader["Lowest"];
                        b.Title = reader["Title"].ToString();

                        results.Add(b);
                    }
                }

            }
            catch (System.Exception ex)
            {
                throw;
            }
            return results;
        }


        public static PagResults<BoxType> GetPagingBoxTypes(int sellerId, int pageIndex, int pageSize)
        {
            var results = new PagResults<BoxType>();
            string commandText = @"select * from boxtype where sellerId = ?sellerId LIMIT ?index,?size";
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            if (pageSize == 0)
            {
                commandText = @"select * from boxtype where sellerId = ?sellerId";
                parameters.Add(new MySqlParameter("?sellerId", sellerId));
            }
            else
            {
                parameters.Add(new MySqlParameter("?sellerId", sellerId));
                parameters.Add(new MySqlParameter("?index", pageIndex));
                parameters.Add(new MySqlParameter("?size", pageSize));
            }
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, commandText, parameters.ToArray());
                    while (reader.Read())
                    {
                        BoxType b = new BoxType();
                        b.Id = reader.GetInt32(0);
                        b.SellerId = (int)reader["SellerId"];
                        b.HoldNum = (int)reader["HoldNum"];
                        b.Lowest = (int)reader["Lowest"];
                        b.Title = reader["Title"].ToString();

                        results.Results.Add(b);
                    }
                    conn.Close();
                    conn.Dispose();
                    conn.Open();

                    commandText = @"select count(*) from boxType where sellerId = ?sellerId";
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

        internal static BoxType GetBoxType(int id)
        {

            var p = new BoxType();
            string commandText = @"select * from boxType where id = ?id";
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
                        p.CreateTime = (DateTime)reader["CreateTime"];
                        p.HoldNum = (int)reader["HoldNum"];
                        p.Lowest = (int)reader["Lowest"];
                        p.SellerId = (int)reader["SellerId"];
                        p.Title = reader["Title"].ToString();
                    }
                }

            }
            catch (System.Exception ex)
            {
                throw;
            }
            return p;

        }

        internal static void ClearBoxTypes(int sellerId)
        {
            string commandText = @"DELETE FROM boxType WHERE sellerId = ?sellerId";
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?sellerId", sellerId));

            MySqlHelper.ExecuteNonQuery(GlobalConfig.DbConn, CommandType.Text, commandText, parameters.ToArray());
       
        }

        internal static void CreateBoxType(BoxType boxType)
        {
            string connectionString = GlobalConfig.DbConn;
            string commandText = @"INSERT INTO BoxType 
            	                                ( 
            	                                CreateTime, 
            	                                HoldNum,
            	                                Lowest,
           	                                    SellerId, 
            	                                Title
            	                                )
            	                                VALUES
            	                                ( 
            	                                ?CreateTime, 
            	                                ?HoldNum,
            	                                ?Lowest,
           	                                    ?SellerId, 
            	                                ?Title
            	                                )";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?CreateTime", boxType.CreateTime));
            parameters.Add(new MySqlParameter("?HoldNum", boxType.HoldNum));
            parameters.Add(new MySqlParameter("?Lowest", boxType.Lowest));
            parameters.Add(new MySqlParameter("?SellerId", boxType.SellerId));
            parameters.Add(new MySqlParameter("?Title", boxType.Title));



            MySqlHelper.ExecuteNonQuery(connectionString, CommandType.Text, commandText, parameters.ToArray());
        }

        internal static void UpdateBoxType(BoxType boxType)
        {
            string commandText = @"UPDATE position SET
                                                    CreateTime = ?CreateTime,
                                                    HoldNum = ?HoldNum,
                                                    Lowest = ?Lowest,
                                                    SellerId = ?SellerId,
                                                    Title = ?Title,
                                                WHERE
                                                    Id = ?Id";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?Id", boxType.Id));
            parameters.Add(new MySqlParameter("?CreateTime", boxType.CreateTime));
            parameters.Add(new MySqlParameter("?HoldNum", boxType.HoldNum));
            parameters.Add(new MySqlParameter("?Lowest", boxType.Lowest));
            parameters.Add(new MySqlParameter("?SellerId", boxType.SellerId));
            parameters.Add(new MySqlParameter("?Title", boxType.Title));

            MySqlHelper.ExecuteNonQuery(GlobalConfig.DbConn, CommandType.Text, commandText, parameters.ToArray());
        }
        public static void DeleteBoxType(int id)
        {
            string commandText = @"DELETE FROM boxtype WHERE Id = ?Id";
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?Id", id));

            MySqlHelper.ExecuteNonQuery(GlobalConfig.DbConn, CommandType.Text, commandText, parameters.ToArray());
        }

        #endregion

        internal static UserPosition GetUserPosition(int timeid, int positionId)
        {
            UserPosition up = null;
            string commandText = @"select * from userposition where timeid = ?timeid and positionId = ?positionId";
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?timeid", timeid));
            parameters.Add(new MySqlParameter("?positionId", positionId));
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    //MySqlDataReader reader = MySqlHelper.ExecuteReader(GlobalConfig.DbConn, CommandType.Text, commandText, parameters.ToArray());
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, commandText, parameters.ToArray());
                    while (reader.Read())
                    {
                        up = new UserPosition();
                        up.Id = reader.GetInt32(0);
                        up.PositionId = (int)reader["PositionId"];
                        up.NickName = reader["NickName"].ToString();
                        up.Message = reader["Message"].ToString();
                        up.UserId = (int)reader["UserId"];
                        up.SellerId = (int)reader["SellerId"];
                        up.Phone = reader["Phone"].ToString();
                        up.CreateTime = (DateTime)reader["CreateTime"];
                        up.PayId = (int)reader["PayId"];
                        up.Status = (int)reader["Status"];
                        up.TimeId = (int)reader["TimeId"];
                    }
                }

            }
            catch (System.Exception ex)
            {
                throw;
            }
            return up;
        }

        public static PagResults<UserPosition> GetPagingUserPosition(int sellerId, int pageIndex, int pageSize)
        {
            var results = new PagResults<UserPosition>();
            string commandText = @"select * from UserPosition where sellerId = ?sellerId order by CreateTime desc LIMIT ?index,?size";
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            if (pageSize == 0)
            {
                commandText = @"select * from UserPosition where sellerId = ?sellerId";
                parameters.Add(new MySqlParameter("?sellerId", sellerId));
            }
            else
            {
                parameters.Add(new MySqlParameter("?sellerId", sellerId));
                parameters.Add(new MySqlParameter("?index", pageIndex));
                parameters.Add(new MySqlParameter("?size", pageSize));
            }
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, commandText, parameters.ToArray());
                    while (reader.Read())
                    {
                        UserPosition up = new UserPosition();
                        up.Id = reader.GetInt32(0);
                        up.SellerId = (int)reader["SellerId"];
                        up.CreateTime = (DateTime)reader["CreateTime"];
                        up.Message = reader["Message"].ToString();
                        up.NickName = reader["NickName"].ToString();
                        up.PayId = (int)reader["PayId"];
                        up.Phone = reader["Phone"].ToString();
                        up.PositionId = (int)reader["PositionId"];
                        up.Status = (int)reader["Status"];
                        up.TimeId = (int)reader["TimeId"];
                        up.UserId = (int)reader["UserId"];

                        results.Results.Add(up);
                    }
                    conn.Close();
                    conn.Dispose();
                    conn.Open();

                    commandText = @"select count(*) from UserPosition where sellerId = ?sellerId";
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

        internal static UserPosition GetUserPosition(int id)
        {
            var up = new UserPosition();
            string commandText = @"select * from userposition where id = ?id";
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
                        up.Id = reader.GetInt32(0);
                        up.PositionId = (int)reader["PositionId"];
                        up.NickName = reader["NickName"].ToString();
                        up.Message = reader["Message"].ToString();
                        up.UserId = (int)reader["UserId"];
                        up.SellerId = (int)reader["SellerId"];
                        up.Phone = reader["Phone"].ToString();
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
            string commandText = @"UPDATE userposition SET
                                                    UserId = ?UserId,
                                                    PositionId = ?PositionId,
                                                    NickName = ?NickName,
                                                    Message = ?Message,
                                                    Phone = ?Phone,
                                                    SellerId = ?SellerId,
                                                    PayId = ?PayId,
                                                    CreateTime = ?CreateTime,
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

        public static void DeleteUserPosion(int id)
        {
            string commandText = @"DELETE FROM userposition WHERE Id = ?Id";
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?Id", id));

            MySqlHelper.ExecuteNonQuery(GlobalConfig.DbConn, CommandType.Text, commandText, parameters.ToArray());
        }

        #region timeline

        internal static IList<Timeline> GetTimeLines(int positionId)
        {
            var results = new List<Timeline>();
            int totalnum = 0;
            string commandText = @"select * from timeline where positionId = ?positionId";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?positionId", positionId));

            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, commandText, parameters.ToArray());
                    while (reader.Read())
                    {
                        Timeline t = new Timeline();
                        t.Id = reader.GetInt32(0);
                        t.PositionId = (int)reader["PositionId"];
                        t.Status = (int)reader["Status"];
                        t.Title = reader["Title"].ToString();
                        t.BeginTime = (DateTime)reader["BeginTime"];
                        t.EndTime = (DateTime)reader["EndTime"];
                        t.SellerId = (int)reader["SellerId"];
                        t.Date = (DateTime)reader["Date"];

                        results.Add(t);
                    }
                }

            }
            catch (System.Exception ex)
            {
                throw;
            }
            return results;
        }

        internal static PagResults<Timeline> GetTimeLines(int positionId,int sellerId,int index,int size)
        {
            var results = new PagResults<Timeline>();
            int totalnum = 0;
            string commandText = @"select * from timeline where positionId = ?positionId and sellerId = ?sellerId limit ?index,?size";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?positionId", positionId));
            parameters.Add(new MySqlParameter("?sellerId", sellerId));
            parameters.Add(new MySqlParameter("?index", index));
            parameters.Add(new MySqlParameter("?size", size));

            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, commandText, parameters.ToArray());
                    while (reader.Read())
                    {
                        Timeline t = new Timeline();
                        t.Id = reader.GetInt32(0);
                        t.PositionId = (int)reader["PositionId"];
                        t.Status = (int)reader["Status"];
                        t.Title = reader["Title"].ToString();
                        t.BeginTime = (DateTime)reader["BeginTime"];
                        t.EndTime = (DateTime)reader["EndTime"];
                        t.SellerId = (int)reader["SellerId"];
                        t.Date = (DateTime)reader["Date"];

                        results.Results.Add(t);
                    }

                    conn.Close();
                    conn.Dispose();
                    conn.Open();

                    commandText = @"select count(*) from timeline where positionId = ?positionId and sellerId = ?sellerId";
                    parameters.Clear();
                    parameters.Add(new MySqlParameter("?positionId", positionId));
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

        internal static Timeline GetTimeLine(int id)
        {
            var t = new Timeline();
            string commandText = @"select * from Timeline where id = ?id";
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
                        t.Id = reader.GetInt32(0);
                        t.PositionId = (int)reader["PositionId"];
                        t.Status = (int)reader["Status"];
                        t.Title = reader["Title"].ToString();
                        t.BeginTime = (DateTime)reader["BeginTime"];
                        t.EndTime = (DateTime)reader["EndTime"];
                        t.SellerId = (int)reader["SellerId"];
                        t.Date = (DateTime)reader["Date"];
                    }
                }

            }
            catch (System.Exception ex)
            {
                throw;
            }
            return t;
        }

        public static void CreateTimeline(Timeline t)
        {
            string connectionString = GlobalConfig.DbConn;
            string commandText = @"INSERT INTO timeline 
        	                                ( 
        	                                SellerId, 
        	                                BeginTime,
        	                                Date,
        	                                EndTime,
        	                                PositionId,
        	                                Status,
                                            Title
        	                                )
        	                                VALUES
        	                                ( 
        	                                ?SellerId, 
        	                                ?BeginTime,
        	                                ?Date,
        	                                ?EndTime,
        	                                ?PositionId,
        	                                ?Status,
        	                                ?Title
        	                                )";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?Id", t.Id));
            parameters.Add(new MySqlParameter("?SellerId", t.SellerId));
            parameters.Add(new MySqlParameter("?BeginTime", t.BeginTime));
            parameters.Add(new MySqlParameter("?EndTime", t.EndTime));
            parameters.Add(new MySqlParameter("?Date", t.Date));
            parameters.Add(new MySqlParameter("?PositionId", t.PositionId));
            parameters.Add(new MySqlParameter("?Status", t.Status));
            parameters.Add(new MySqlParameter("?Title", t.Title));
            

            MySqlHelper.ExecuteNonQuery(connectionString, CommandType.Text, commandText, parameters.ToArray());

        }

        public static void UpdateTimeline(Timeline t)
        {
            string commandText = @"UPDATE position SET
                                                    SellerId = ?SellerId, 
        	                                        BeginTime = ?BeginTime,
        	                                        EndTime = ?EndTime,
        	                                        Date = ?Date,
        	                                        PositionId = ?PositionId,
        	                                        Status = ?Status,
        	                                        Title = ?Title
                                                WHERE
                                                    Id = ?Id";

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?Id", t.Id));
            parameters.Add(new MySqlParameter("?SellerId", t.SellerId));
            parameters.Add(new MySqlParameter("?BeginTime", t.BeginTime));
            parameters.Add(new MySqlParameter("?EndTime", t.EndTime));
            parameters.Add(new MySqlParameter("?Date", t.Date));
            parameters.Add(new MySqlParameter("?PositionId", t.PositionId));
            parameters.Add(new MySqlParameter("?Status", t.Status));
            parameters.Add(new MySqlParameter("?Title", t.Title));
            

            MySqlHelper.ExecuteNonQuery(GlobalConfig.DbConn, CommandType.Text, commandText, parameters.ToArray());

        }

        public static void DeleteTimeline(int id)
        {
            string commandText = @"DELETE FROM timeline WHERE Id = ?Id";
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?Id", id));

            MySqlHelper.ExecuteNonQuery(GlobalConfig.DbConn, CommandType.Text, commandText, parameters.ToArray());
        }
        #endregion


        
    }
}