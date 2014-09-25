using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using Backstage.Core.Entity;
using MySql.Data.MySqlClient;
using Newtonsoft.Json;
using WebSite.Core;

namespace Backstage.Core.Logic
{
    public static class ImgSizeCfgHelper
    {
        public static List<ImgSizeCfg> GetImgSizeCfgList(UploadType type)
        {
            var result = new List<ImgSizeCfg>();
            var cmdText = @"select * from ImgSizeCfg where Type=?Type;";
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?Type", (int)type));
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText, parameters.ToArray());
                    while (reader.Read())
                    {
                        var item = new ImgSizeCfg();
                        item.Id = reader.GetInt32(0);
                        item.Type = (UploadType)reader["Type"];
                        item.IsOriginal = (int)reader["IsOriginal"];
                        item.Width = (int)reader["Width"];
                        item.Height = (int)reader["Height"];

                        result.Add(item);
                    }
                }
            }
            catch (System.Exception ex)
            {
                throw;
            }
            return result;
        }
    }
}