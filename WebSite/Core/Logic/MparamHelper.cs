using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using Backstage.Core.Entity;
using MySql.Data.MySqlClient;

namespace Backstage.Core.Logic
{
    public static class MparamHelper
    {
        public static Mparam GetMparam(int id)
        {
            var cmdText = string.Format("select * from Mparam where Id={0} limit 1;", id);
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText);
                    if (reader.HasRows)
                    {
                        if (reader.Read())
                        {
                            Mparam mparam = new Mparam();
                            mparam.Id = reader.GetInt32(0);
                            mparam.AdImgId = (int) reader["AdImgId"];
                            mparam.AdImgUrl = reader["AdImgUrl"].ToString();
                            mparam.Title = reader["Title"].ToString();
                            mparam.Url = reader["Url"].ToString();
                            return mparam;
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