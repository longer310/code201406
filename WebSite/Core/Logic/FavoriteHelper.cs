﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using Backstage.Core.Entity;
using MySql.Data.MySqlClient;

namespace Backstage.Core.Logic
{
    public static class FavoriteHelper
    {
        public static Favorite GetFavorite(int id)
        {
            var cmdText = string.Format("select * from Favorite where Id={0} limit 1;", id);
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText);
                    if (reader.HasRows)
                    {
                        if (reader.Read())
                        {
                            Favorite favorite = new Favorite();
                            favorite.Id = reader.GetInt32(0);
                            favorite.GidList = Utility.GetListint(reader["Gids"].ToString());
                            return favorite;
                        }
                    }
                    else
                    {
                        var favorite = new Favorite();
                        favorite.Id = id;
                        SaveFavorite(favorite, 1);
                        return favorite;
                    }
                }
            }
            catch (System.Exception ex)
            {
                throw;
            }
            return null;
        }

        /// <summary>
        /// 保存收藏
        /// </summary>
        /// <param name="favorite"></param>
        /// <param name="isAdd"></param>
        /// <returns></returns>
        public static bool SaveFavorite(Favorite favorite, int isAdd = 0)
        {
            var cmdText = string.Empty;
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            if (isAdd == 0)
            {
                cmdText = @"update Favorite set Gids=?Gids where Id=?Id";
                parameters.Add(new MySqlParameter("?Id", favorite.Id));
                parameters.Add(new MySqlParameter("?Gids", Utility.GetString(favorite.GidList)));
            }
            else
            {
                cmdText = @"insert into Favorite(Id,Gids) values (?Id,?Gids)";
                parameters.Add(new MySqlParameter("?Id", favorite.Id));
                parameters.Add(new MySqlParameter("?Gids", Utility.GetString(favorite.GidList)));
            }
            try
            {
                var num = MySqlHelper.ExecuteNonQuery(Utility._gameDbConn, CommandType.Text, cmdText, parameters.ToArray());
                return num > 0;
            }
            catch (System.Exception ex)
            {
                throw;
            }
            return false;
        }
    }
}