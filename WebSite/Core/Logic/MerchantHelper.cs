using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using Backstage.Core.Entity;
using MySql.Data.MySqlClient;

namespace Backstage.Core.Logic
{
    public static class MerchantHelper
    {
        /// <summary>
        /// 获取商户信息
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static Merchant GetMerchant(int id)
        {
            var cmdText = string.Format("select * from Merchant where Id={0} limit 1;", id);
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText);
                    if (reader.HasRows)
                    {
                        if (reader.Read())
                        {
                            Merchant merchant = new Merchant();
                            merchant.Id             = reader.GetInt32(0);
                            merchant.Tname          = reader["Tname"].ToString();
                            merchant.Name           = reader["Name"].ToString();
                            merchant.Address        = reader["Address"].ToString();
                            merchant.Phone          = reader["Phone"].ToString();
                            merchant.Description    = reader["Description"].ToString();
                            merchant.Mapurl         = reader["Mapurl"].ToString();
                            merchant.AppId          = (int)reader["AppId"];
                            merchant.AppSecret      = reader["AppSecret"].ToString();
                            merchant.AccessToken    = reader["AccessToken"].ToString();
                            merchant.AccessExpire   = (DateTime)reader["AccessExpire"];
                            merchant.AndroidUrl     = reader["AndroidUrl"].ToString();
                            merchant.IosUrl         = reader["IosUrl"].ToString();
                            merchant.WxUrl          = reader["WxUrl"].ToString();
                            merchant.PointX = reader["PointX"].ToString();
                            merchant.PointY = reader["PointY"].ToString();
                            return merchant;
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

        /// <summary>
        /// 保存收藏
        /// </summary>
        /// <param name="merchant"></param>
        /// <param name="isAdd"></param>
        /// <returns></returns>
        public static bool SaveMerchant(Merchant merchant)
        {
            var cmdText = string.Empty;
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            if (merchant.Id > 0)
            {
                cmdText = @"UPDATE merchant SET
                                        Name           = ?Name        ,
                                        Tname          = ?Tname       ,
                                        Address        = ?Address     ,
                                        Phone          = ?Phone       ,
                                        Description    = ?Description ,
                                        Mapurl         = ?Mapurl      ,
                                        AppId          = ?AppId       ,
                                        AppSecret      = ?AppSecret   ,
                                        AccessToken    = ?AccessToken ,
                                        AccessExpire   = ?AccessExpire,
                                        AndroidUrl     = ?AndroidUrl  ,
                                        IosUrl         = ?IosUrl      ,
                                        WxUrl          = ?WxUrl       ,
                                        PointX         = ?PointX      ,
                                        PointY         = ?PointY      
                                    WHERE
                                        Id = ?Id";
                parameters.Add(new MySqlParameter("?Name           ", merchant.Name));
                parameters.Add(new MySqlParameter("?Tname          ", merchant.Tname));
                parameters.Add(new MySqlParameter("?Address        ", merchant.Address));
                parameters.Add(new MySqlParameter("?Phone          ", merchant.Phone));
                parameters.Add(new MySqlParameter("?Description    ", merchant.Description));
                parameters.Add(new MySqlParameter("?Mapurl         ", merchant.Mapurl));
                parameters.Add(new MySqlParameter("?AppId          ", merchant.AppId));
                parameters.Add(new MySqlParameter("?AppSecret      ", merchant.AppSecret));
                parameters.Add(new MySqlParameter("?AccessToken    ", merchant.AccessToken));
                parameters.Add(new MySqlParameter("?AccessExpire   ", merchant.AccessExpire));
                parameters.Add(new MySqlParameter("?AndroidUrl     ", merchant.AndroidUrl));
                parameters.Add(new MySqlParameter("?IosUrl         ", merchant.IosUrl));
                parameters.Add(new MySqlParameter("?WxUrl          ", merchant.WxUrl));
                parameters.Add(new MySqlParameter("?Id             ", merchant.Id));
                parameters.Add(new MySqlParameter("?PointX             ", merchant.PointX));
                parameters.Add(new MySqlParameter("?PointY             ", merchant.PointY));

            }
            else
            {
                cmdText = @"insert into merchant
                                        (
                                        Name         ,
                                        Tname        ,
                                        Address      ,
                                        Phone        ,
                                        Description  ,
                                        Mapurl       ,
                                        AppId        ,
                                        AppSecret    ,
                                        AccessToken  ,
                                        AccessExpire ,
                                        AndroidUrl   ,
                                        IosUrl       ,
                                        WxUrl        ,
                                        PointX       ,
                                        PonitY        
                                        ) 
                                        values
                                        (
                                        ?Name         ,
                                        ?Tname        ,
                                        ?Address      ,
                                        ?Phone        ,
                                        ?Description  ,
                                        ?Mapurl       ,
                                        ?AppId        ,
                                        ?AppSecret    ,
                                        ?AccessToken  ,
                                        ?AccessExpire ,
                                        ?AndroidUrl   ,
                                        ?IosUrl       ,
                                        ?WxUrl        ,
                                        ?PointX       ,
                                        ?PonitY   
                                        )";
                parameters.Add(new MySqlParameter("?Name           ", merchant.Name));
                parameters.Add(new MySqlParameter("?Tname          ", merchant.Tname));
                parameters.Add(new MySqlParameter("?Address        ", merchant.Address));
                parameters.Add(new MySqlParameter("?Phone          ", merchant.Phone));
                parameters.Add(new MySqlParameter("?Description    ", merchant.Description));
                parameters.Add(new MySqlParameter("?Mapurl         ", merchant.Mapurl));
                parameters.Add(new MySqlParameter("?AppId          ", merchant.AppId));
                parameters.Add(new MySqlParameter("?AppSecret      ", merchant.AppSecret));
                parameters.Add(new MySqlParameter("?AccessToken    ", merchant.AccessToken));
                parameters.Add(new MySqlParameter("?AccessExpire   ", merchant.AccessExpire));
                parameters.Add(new MySqlParameter("?AndroidUrl     ", merchant.AndroidUrl));
                parameters.Add(new MySqlParameter("?IosUrl         ", merchant.IosUrl));
                parameters.Add(new MySqlParameter("?WxUrl          ", merchant.WxUrl));
                parameters.Add(new MySqlParameter("?PointX         ", merchant.IosUrl));
                parameters.Add(new MySqlParameter("?PonitY          ", merchant.WxUrl));
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