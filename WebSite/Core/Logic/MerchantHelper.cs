using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using Backstage.Core.Entity;
using Backstage.Model;
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
                            merchant.Id = reader.GetInt32(0);
                            merchant.Tname = reader["Tname"].ToString();
                            merchant.Name = reader["Name"].ToString();
                            merchant.Address = reader["Address"].ToString();
                            merchant.Phone = reader["Phone"].ToString();
                            merchant.Description = reader["Description"].ToString();
                            merchant.Mapurl = reader["Mapurl"].ToString();
                            merchant.AppId = reader["AppId"].ToString();
                            merchant.AppSecret = reader["AppSecret"].ToString();
                            merchant.AccessToken = reader["AccessToken"].ToString();
                            merchant.AccessExpire = (DateTime)reader["AccessExpire"];
                            merchant.AndroidUrl = reader["AndroidUrl"].ToString();
                            merchant.IosUrl = reader["IosUrl"].ToString();
                            merchant.WxUrl = reader["WxUrl"].ToString();
                            merchant.PointX = reader["PointX"].ToString();
                            merchant.PointY = reader["PointY"].ToString();
                            merchant.ReChargeIntegral = (int)reader["ReChargeIntegral"];
                            merchant.ConsumptionIntegral = (int)reader["ConsumptionIntegral"];
                            merchant.CommentIntegral = (int)reader["CommentIntegral"];
                            merchant.ShareIntegral = (int)reader["ShareIntegral"];
                            merchant.Freight = (int)reader["Freight"];
                            merchant.NeedToFreeFreight = (int)reader["NeedToFreeFreight"];

                            merchant.ServerEndTime = (DateTime)reader["ServerEndTime"];
                            merchant.LogoUrl = reader["LogoUrl"].ToString();
                            merchant.Mid = (int)reader["Mid"];
                            merchant.UserCount = (int)reader["UserCount"];
                            merchant.Tid = (int)reader["Tid"];
                            merchant.HasWifi = (int)reader["HasWifi"];
                            merchant.HasPrint = (int)reader["HasPrint"];
                            merchant.ManagerPhone = reader["ManagerPhone"].ToString();
                            merchant.Qq = reader["Qq"].ToString();
                            merchant.WinXinAccount = reader["WinXinAccount"].ToString();
                            merchant.Remark = reader["Remark"].ToString();
                            merchant.CnameList = Utility.GetListstring(reader["CnameList"].ToString());
                            merchant.Money = (float)reader["Money"];
                            merchant.DevName = reader["DevName"].ToString();
                            merchant.Sid = (int)reader["Sid"];

                            merchant.AccountName = reader["AccountName"].ToString();
                            merchant.CardNumber = (long)reader["CardNumber"];
                            merchant.Bank = reader["Bank"].ToString();

                            merchant.LoginAdStayTime = (int)reader["LoginAdStayTime"];
                            merchant.LoginAdUrl = reader["LoginAdUrl"].ToString();
                            merchant.WifiAdStayTime = (int)reader["WifiAdStayTime"];
                            merchant.WifiAds = JsonTransfer.DeserializeObject<List<PicJumpItem>>(reader["WifiAds"].ToString());

                            merchant.MachineCode = reader["MachineCode"].ToString();
                            merchant.MachineKey = reader["MachineKey"].ToString();

                            merchant.HasDelivery = (int)reader["HasDelivery"];

                            merchant.WifiAccount = reader["WifiAccount"].ToString();
                            merchant.AndroidVersion = reader["AndroidVersion"].ToString();
                            merchant.IosVersion = reader["IosVersion"].ToString();

                            merchant.SlideAdStayTime = (int)reader["SlideAdStayTime"];
                            merchant.SlideAds = JsonTransfer.DeserializeObject<List<SlideAdItem>>(reader["SlideAds"].ToString());

                            //获取商户基础类型
                            var merchanttype = MerchantTypeHelper.GetMerchantType(merchant.Mid);
                            if (merchanttype != null)
                                merchant.MerType = (MerchantTypes)merchanttype.TypeId;

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
        /// 保存商户
        /// </summary>
        /// <param name="merchant"></param>
        /// <param name="isAdd"></param>
        /// <returns></returns>
        public static bool SaveMerchant(Merchant merchant,int isadd = 0)
        {
            var cmdText = string.Empty;
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            if (isadd == 0)
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
                                        PointY         = ?PointY      ,
                                        ReChargeIntegral        = ?ReChargeIntegral,
                                        ConsumptionIntegral     = ?ConsumptionIntegral  ,
                                        CommentIntegral         = ?CommentIntegral      ,
                                        ShareIntegral           = ?ShareIntegral       ,
                                        Freight                 = ?Freight      ,
                                        NeedToFreeFreight       = ?NeedToFreeFreight  ,    

                                        ServerEndTime                 = ?ServerEndTime      ,
                                        LogoUrl                           = ?LogoUrl                ,
                                        Mid                           = ?Mid                ,
                                        UserCount                     = ?UserCount          ,
                                        Tid                           = ?Tid                ,
                                        HasWifi                       = ?HasWifi            ,
                                        HasPrint                      = ?HasPrint           ,
                                        ManagerPhone                  = ?ManagerPhone       ,
                                        Qq                            = ?Qq                 ,
                                        WinXinAccount                 = ?WinXinAccount      ,
                                        Remark                         = ?Remark              ,
                                        Money                         = ?Money              ,
                                        DevName                         = ?DevName              ,
                                        Sid                         = ?Sid              ,
                                        CnameList                     = ?CnameList   ,    
                                        AccountName                         = ?AccountName              ,
                                        CardNumber                         = ?CardNumber              ,
                                        Bank                     = ?Bank        ,
                                        LoginAdStayTime          = ?LoginAdStayTime        ,
                                        LoginAdUrl               = ?LoginAdUrl             ,
                                        WifiAdStayTime           = ?WifiAdStayTime         ,
                                        WifiAds                  = ?WifiAds              ,
                                        MachineCode                  = ?MachineCode               ,
                                        MachineKey                  = ?MachineKey                ,
                                        HasDelivery                  = ?HasDelivery               ,
                                        WifiAccount                  = ?WifiAccount              ,
                                        AndroidVersion                  = ?AndroidVersion              ,
                                        IosVersion                  = ?IosVersion                 ,
                                        SlideAdStayTime                  = ?SlideAdStayTime                 ,
                                        SlideAds                  = ?SlideAds                           

                                    WHERE
                                        Id = ?Id";

                parameters.Add(new MySqlParameter("?Name", merchant.Name));
                parameters.Add(new MySqlParameter("?Tname", merchant.Tname));
                parameters.Add(new MySqlParameter("?Address", merchant.Address));
                parameters.Add(new MySqlParameter("?Phone", merchant.Phone));
                parameters.Add(new MySqlParameter("?Description", merchant.Description));
                parameters.Add(new MySqlParameter("?Mapurl", merchant.Mapurl));
                parameters.Add(new MySqlParameter("?AppId", merchant.AppId));
                parameters.Add(new MySqlParameter("?AppSecret", merchant.AppSecret));
                parameters.Add(new MySqlParameter("?AccessToken", merchant.AccessToken));
                parameters.Add(new MySqlParameter("?AccessExpire", merchant.AccessExpire));
                parameters.Add(new MySqlParameter("?AndroidUrl", merchant.AndroidUrl));
                parameters.Add(new MySqlParameter("?IosUrl", merchant.IosUrl));
                parameters.Add(new MySqlParameter("?WxUrl", merchant.WxUrl));
                parameters.Add(new MySqlParameter("?Id", merchant.Id));
                parameters.Add(new MySqlParameter("?PointX", merchant.PointX));
                parameters.Add(new MySqlParameter("?PointY", merchant.PointY));

                parameters.Add(new MySqlParameter("?ReChargeIntegral", merchant.ReChargeIntegral));
                parameters.Add(new MySqlParameter("?ConsumptionIntegral", merchant.ConsumptionIntegral));
                parameters.Add(new MySqlParameter("?CommentIntegral", merchant.CommentIntegral));
                parameters.Add(new MySqlParameter("?ShareIntegral", merchant.ShareIntegral));
                parameters.Add(new MySqlParameter("?Freight", merchant.Freight));
                parameters.Add(new MySqlParameter("?NeedToFreeFreight", merchant.NeedToFreeFreight));


                parameters.Add(new MySqlParameter("?ServerEndTime", merchant.ServerEndTime));
                parameters.Add(new MySqlParameter("?LogoUrl", merchant.LogoUrl));
                parameters.Add(new MySqlParameter("?Mid", merchant.Mid));
                parameters.Add(new MySqlParameter("?UserCount", merchant.UserCount));
                parameters.Add(new MySqlParameter("?Tid", merchant.Tid));
                parameters.Add(new MySqlParameter("?HasWifi", merchant.HasWifi));
                parameters.Add(new MySqlParameter("?HasPrint", merchant.HasPrint));
                parameters.Add(new MySqlParameter("?ManagerPhone", merchant.ManagerPhone));
                parameters.Add(new MySqlParameter("?Qq", merchant.Qq));
                parameters.Add(new MySqlParameter("?WinXinAccount", merchant.WinXinAccount));
                parameters.Add(new MySqlParameter("?Remark", merchant.Remark));
                parameters.Add(new MySqlParameter("?Money", merchant.Money));
                parameters.Add(new MySqlParameter("?CnameList", Utility.GetString(merchant.CnameList)));
                parameters.Add(new MySqlParameter("?DevName", merchant.DevName));
                parameters.Add(new MySqlParameter("?Sid", merchant.Sid));

                parameters.Add(new MySqlParameter("?AccountName", merchant.AccountName));
                parameters.Add(new MySqlParameter("?CardNumber", merchant.CardNumber));
                parameters.Add(new MySqlParameter("?Bank", merchant.Bank));

                parameters.Add(new MySqlParameter("?LoginAdStayTime", merchant.LoginAdStayTime));
                parameters.Add(new MySqlParameter("?LoginAdUrl", merchant.LoginAdUrl));
                parameters.Add(new MySqlParameter("?WifiAdStayTime", merchant.WifiAdStayTime));
                parameters.Add(new MySqlParameter("?WifiAds", JsonTransfer.SerializeObject(merchant.WifiAds)));

                parameters.Add(new MySqlParameter("?MachineCode", merchant.MachineCode));
                parameters.Add(new MySqlParameter("?MachineKey", merchant.MachineKey));
                parameters.Add(new MySqlParameter("?HasDelivery", merchant.HasDelivery));
                parameters.Add(new MySqlParameter("?WifiAccount", merchant.WifiAccount));
                parameters.Add(new MySqlParameter("?AndroidVersion", merchant.AndroidVersion));
                parameters.Add(new MySqlParameter("?IosVersion", merchant.IosVersion));

                parameters.Add(new MySqlParameter("?SlideAdStayTime", merchant.SlideAdStayTime));
                parameters.Add(new MySqlParameter("?SlideAds", JsonTransfer.SerializeObject(merchant.SlideAds)));


            }
            else
            {
                cmdText = @"insert into merchant
                                        (
                                        Id         ,
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
                                        PointY        ,

                                        ReChargeIntegral ,
                                        ConsumptionIntegral   ,
                                        CommentIntegral       ,
                                        ShareIntegral        ,
                                        Freight       ,
                                        NeedToFreeFreight   ,

                                        ServerEndTime        ,
                                        LogoUrl                  ,
                                        Mid                  ,
                                        UserCount            ,
                                        Tid                  ,
                                        HasWifi              ,
                                        HasPrint             ,
                                        ManagerPhone         ,
                                        Qq                   ,
                                        WinXinAccount        ,
                                        Remark                ,
                                        Money                ,
                                        DevName                ,
                                        Sid                ,
                                        CnameList          ,
                                        AccountName              ,
                                        CardNumber              ,
                                        Bank          ,
                                        LoginAdStayTime          ,
                                        LoginAdUrl               ,
                                        WifiAdStayTime           ,
                                        WifiAds                  ,
                                        MachineCode                 ,
                                        MachineKey                 ,
                                        HasDelivery                 ,
                                        WifiAccount                ,
                                        AndroidVersion                ,
                                        IosVersion                ,
                                        SlideAdStayTime                ,
                                        SlideAds                
                                        ) 
                                        values
                                        (
                                        ?Id         ,
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
                                        ?PointY       ,

                                        ?ReChargeIntegral ,
                                        ?ConsumptionIntegral   ,
                                        ?CommentIntegral       ,
                                        ?ShareIntegral        ,
                                        ?Freight       ,
                                        ?NeedToFreeFreight   ,

                                        ?ServerEndTime        ,
                                        ?LogoUrl                  ,
                                        ?Mid                  ,
                                        ?UserCount            ,
                                        ?Tid                  ,
                                        ?HasWifi              ,
                                        ?HasPrint             ,
                                        ?ManagerPhone         ,
                                        ?Qq                   ,
                                        ?WinXinAccount        ,
                                        ?Remark                ,
                                        ?Money                ,
                                        ?DevName                ,
                                        ?Sid                ,
                                        ?CnameList          ,
                                        ?AccountName              ,
                                        ?CardNumber              ,
                                        ?Bank          ,
                                        ?LoginAdStayTime          ,
                                        ?LoginAdUrl               ,
                                        ?WifiAdStayTime           ,
                                        ?WifiAds                  ,
                                        ?MachineCode                 ,
                                        ?MachineKey                 ,
                                        ?HasDelivery                ,
                                        ?WifiAccount                 ,
                                        ?AndroidVersion                 ,
                                        ?IosVersion                   ,
                                        ?SlideAdStayTime                   ,
                                        ?SlideAds                  
                                        )";
                parameters.Add(new MySqlParameter("?Id", merchant.Id));
                parameters.Add(new MySqlParameter("?Name", merchant.Name));
                parameters.Add(new MySqlParameter("?Tname", merchant.Tname));
                parameters.Add(new MySqlParameter("?Address", merchant.Address));
                parameters.Add(new MySqlParameter("?Phone", merchant.Phone));
                parameters.Add(new MySqlParameter("?Description", merchant.Description));
                parameters.Add(new MySqlParameter("?Mapurl", merchant.Mapurl));
                parameters.Add(new MySqlParameter("?AppId", merchant.AppId));
                parameters.Add(new MySqlParameter("?AppSecret", merchant.AppSecret));
                parameters.Add(new MySqlParameter("?AccessToken", merchant.AccessToken));
                parameters.Add(new MySqlParameter("?AccessExpire", merchant.AccessExpire));
                parameters.Add(new MySqlParameter("?AndroidUrl", merchant.AndroidUrl));
                parameters.Add(new MySqlParameter("?IosUrl", merchant.IosUrl));
                parameters.Add(new MySqlParameter("?WxUrl", merchant.WxUrl));
                parameters.Add(new MySqlParameter("?PointX", merchant.PointX));
                parameters.Add(new MySqlParameter("?PointY", merchant.PointY));

                parameters.Add(new MySqlParameter("?ReChargeIntegral", merchant.ReChargeIntegral));
                parameters.Add(new MySqlParameter("?ConsumptionIntegral", merchant.ConsumptionIntegral));
                parameters.Add(new MySqlParameter("?CommentIntegral", merchant.CommentIntegral));
                parameters.Add(new MySqlParameter("?ShareIntegral", merchant.ShareIntegral));
                parameters.Add(new MySqlParameter("?Freight", merchant.Freight));
                parameters.Add(new MySqlParameter("?NeedToFreeFreight", merchant.NeedToFreeFreight));

                parameters.Add(new MySqlParameter("?ServerEndTime", merchant.ServerEndTime));
                parameters.Add(new MySqlParameter("?LogoUrl", merchant.LogoUrl));
                parameters.Add(new MySqlParameter("?Mid", merchant.Mid));
                parameters.Add(new MySqlParameter("?UserCount", merchant.UserCount));
                parameters.Add(new MySqlParameter("?Tid", merchant.Tid));
                parameters.Add(new MySqlParameter("?HasWifi", merchant.HasWifi));
                parameters.Add(new MySqlParameter("?HasPrint", merchant.HasPrint));
                parameters.Add(new MySqlParameter("?ManagerPhone", merchant.ManagerPhone));
                parameters.Add(new MySqlParameter("?Qq", merchant.Qq));
                parameters.Add(new MySqlParameter("?WinXinAccount", merchant.WinXinAccount));
                parameters.Add(new MySqlParameter("?Remark", merchant.Remark));
                parameters.Add(new MySqlParameter("?CnameList", Utility.GetString(merchant.CnameList)));
                parameters.Add(new MySqlParameter("?Money", merchant.Money));
                parameters.Add(new MySqlParameter("?DevName", merchant.DevName));
                parameters.Add(new MySqlParameter("?Sid", merchant.Sid));

                parameters.Add(new MySqlParameter("?AccountName", merchant.AccountName));
                parameters.Add(new MySqlParameter("?CardNumber", merchant.CardNumber));
                parameters.Add(new MySqlParameter("?Bank", merchant.Bank));

                parameters.Add(new MySqlParameter("?LoginAdStayTime", merchant.LoginAdStayTime));
                parameters.Add(new MySqlParameter("?LoginAdUrl", merchant.LoginAdUrl));
                parameters.Add(new MySqlParameter("?WifiAdStayTime", merchant.WifiAdStayTime));
                parameters.Add(new MySqlParameter("?WifiAds", JsonTransfer.SerializeObject(merchant.WifiAds)));

                parameters.Add(new MySqlParameter("?MachineCode", merchant.MachineCode));
                parameters.Add(new MySqlParameter("?MachineKey", merchant.MachineKey));
                parameters.Add(new MySqlParameter("?HasDelivery", merchant.HasDelivery));
                parameters.Add(new MySqlParameter("?WifiAccount", merchant.WifiAccount));
                parameters.Add(new MySqlParameter("?AndroidVersion", merchant.AndroidVersion));
                parameters.Add(new MySqlParameter("?IosVersion", merchant.IosVersion));

                parameters.Add(new MySqlParameter("?SlideAdStayTime", merchant.SlideAdStayTime));
                parameters.Add(new MySqlParameter("?SlideAds", JsonTransfer.SerializeObject(merchant.SlideAds)));
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

        /// <summary>
        /// 获取商户信息
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static PagResults<Merchant> GetMerchantList(int mid, int orderby, int orderbytype, int start = 0, int limit = 0, int gettotal = 1)
        {
            var result = new PagResults<Merchant>();
            result.Results = new List<Merchant>();
            var wheresql = mid > 0 ? string.Format(" where mid={0}", mid) : string.Empty;
            var orderbysql = string.Empty;
            if (orderby == 0) orderbysql = " order by Id ";
            else if (orderby == 1) orderbysql = " order by ServerEndTime ";
            else if (orderby == 2) orderbysql = " order by UserCount ";
            else if (orderby == 3) orderbysql = " order by Money ";
            if (!string.IsNullOrEmpty(orderbysql) && orderbytype == 0)
                orderbysql += " desc";
            string limitsql = limit != 0 ? " LIMIT ?start,?limit" : string.Empty;
            var cmdText = string.Format("select * from Merchant ") + wheresql + orderbysql + limitsql;

            List<MySqlParameter> parameters = new List<MySqlParameter>();
            if (!string.IsNullOrEmpty(limitsql))
            {
                parameters.Add(new MySqlParameter("?start", start));
                parameters.Add(new MySqlParameter("?limit", limit));
            }
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText, parameters.ToArray());
                    while (reader.Read())
                    {
                        Merchant merchant = new Merchant();
                        merchant.Id = reader.GetInt32(0);
                        merchant.Tname = reader["Tname"].ToString();
                        merchant.Name = reader["Name"].ToString();
                        merchant.Address = reader["Address"].ToString();
                        merchant.Phone = reader["Phone"].ToString();
                        merchant.Description = reader["Description"].ToString();
                        merchant.Mapurl = reader["Mapurl"].ToString();
                        merchant.AppId = reader["AppId"].ToString();
                        merchant.AppSecret = reader["AppSecret"].ToString();
                        merchant.AccessToken = reader["AccessToken"].ToString();
                        merchant.AccessExpire = (DateTime)reader["AccessExpire"];
                        merchant.AndroidUrl = reader["AndroidUrl"].ToString();
                        merchant.IosUrl = reader["IosUrl"].ToString();
                        merchant.WxUrl = reader["WxUrl"].ToString();
                        merchant.PointX = reader["PointX"].ToString();
                        merchant.PointY = reader["PointY"].ToString();
                        merchant.ReChargeIntegral = (int)reader["ReChargeIntegral"];
                        merchant.ConsumptionIntegral = (int)reader["ConsumptionIntegral"];
                        merchant.CommentIntegral = (int)reader["CommentIntegral"];
                        merchant.ShareIntegral = (int)reader["ShareIntegral"];
                        merchant.Freight = (int)reader["Freight"];
                        merchant.NeedToFreeFreight = (int)reader["NeedToFreeFreight"];

                        merchant.ServerEndTime = (DateTime)reader["ServerEndTime"];
                        merchant.LogoUrl = reader["LogoUrl"].ToString();
                        merchant.Mid = (int)reader["Mid"];
                        merchant.UserCount = (int)reader["UserCount"];
                        merchant.Tid = (int)reader["Tid"];
                        merchant.HasWifi = (int)reader["HasWifi"];
                        merchant.HasPrint = (int)reader["HasPrint"];
                        merchant.ManagerPhone = reader["ManagerPhone"].ToString();
                        merchant.Qq = reader["Qq"].ToString();
                        merchant.WinXinAccount = reader["WinXinAccount"].ToString();
                        merchant.Remark = reader["Remark"].ToString();
                        merchant.CnameList = Utility.GetListstring(reader["CnameList"].ToString());
                        merchant.Money = (float)reader["Money"];
                        merchant.DevName = reader["DevName"].ToString();
                        merchant.Sid = (int)reader["Sid"];

                        merchant.AccountName = reader["AccountName"].ToString();
                        merchant.CardNumber = (long)reader["CardNumber"];
                        merchant.Bank = reader["Bank"].ToString();

                        merchant.LoginAdStayTime = (int)reader["LoginAdStayTime"];
                        merchant.LoginAdUrl = reader["LoginAdUrl"].ToString();
                        merchant.WifiAdStayTime = (int)reader["WifiAdStayTime"];
                        merchant.WifiAds = JsonTransfer.DeserializeObject<List<PicJumpItem>>(reader["WifiAds"].ToString());

                        merchant.MachineCode = reader["MachineCode"].ToString();
                        merchant.MachineKey = reader["MachineKey"].ToString();
                        merchant.HasDelivery = (int)reader["HasDelivery"];

                        merchant.WifiAccount = reader["WifiAccount"].ToString();
                        merchant.AndroidVersion = reader["AndroidVersion"].ToString();
                        merchant.IosVersion = reader["IosVersion"].ToString();

                        merchant.SlideAdStayTime = (int)reader["SlideAdStayTime"];
                        merchant.SlideAds = JsonTransfer.DeserializeObject<List<SlideAdItem>>(reader["SlideAds"].ToString());

                        result.Results.Add(merchant);
                    }

                    if (gettotal > 0)
                    {
                        //一个函数有两次连接数据库 先把连接断开 然后重连
                        conn.Close();
                        conn.Dispose();
                        conn.Open();

                        cmdText = "select count(*) from Merchant " + wheresql;
                        reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText);
                        if (reader.HasRows)
                        {
                            if (reader.Read())
                            {
                                result.TotalCount = reader.GetInt32(0);
                            }
                        }
                    }

                    return result;
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