using System;
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
            var sql = string.Format("select * from Favorite where Id={0} limit 1;", id);
            try
            {
                MySqlDataReader reader = MySqlHelper.ExecuteReader(Utility._gameDbConn, CommandType.Text, sql);
                if (reader.HasRows)
                {
                    if (reader.Read())
                    {
                        Favorite favorite = new Favorite();
                        favorite.Id = reader.GetInt32(0);
                        favorite.Gids = reader.GetString(1);
                        return favorite;
                    }
                }
                else
                {
                    var favorite = new Favorite();
                    favorite.Id = id;
                    SaveFavorite(favorite);
                    return favorite;
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
            var sql = string.Empty;
            if (isAdd == 0)
                string.Format("update Favorite set Gids='{0}' where Id={1}", favorite.Gids, favorite.Id);
            else
            {
                string.Format("insert into Favorite(Id,Gids) values ({0},'{1}')", favorite.Id, favorite.Gids);
            }
            try
            {
                var num = MySqlHelper.ExecuteNonQuery(Utility._gameDbConn, CommandType.Text, sql);
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