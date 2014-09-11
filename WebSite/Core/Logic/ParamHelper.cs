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
    public static class ParamHelper
    {
        public static string GetParamvalue(string key)
        {
            var cmdText = string.Format("select * from Param where `Key`='{0}' limit 1;", key);
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlDataReader reader = MySqlHelper.ExecuteReader(conn, CommandType.Text, cmdText);
                    if (reader.HasRows)
                    {
                        if (reader.Read())
                        {
                            return reader["Kvalue"].ToString();
                        }
                    }
                }
            }
            catch (System.Exception ex)
            {
                throw;
            }
            return "";
        }
        /// <summary>
        /// 添加商户配置信息
        /// </summary>
        /// <param name="sellerId"></param>
        /// <param name="o"></param>
        /// <param name="description"></param>
        /// <returns></returns>
        public static bool AddMerchantParam(int sellerId, object o, string description)
        {
            var data = JsonTransfer.SerializeObject(o);
            var key = string.Format(MerchantCfgKey, sellerId);
            var cmdText = @"insert into Param (Key,Kvalue,Description) values (?Key,?Kvalue,?Description);";
            List<MySqlParameter> parameters = new List<MySqlParameter>();
            parameters.Add(new MySqlParameter("?Key", key));
            parameters.Add(new MySqlParameter("?Kvalue", data));
            parameters.Add(new MySqlParameter("?Description", description));
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    return MySqlHelper.ExecuteNonQuery(conn, CommandType.Text, cmdText) > 0;
                }
            }
            catch (System.Exception ex)
            {
                return false;
                throw;
            }
            return false;
        }
        public static bool UpdateParamvalue(string key, object o)
        {
            var data = JsonTransfer.SerializeObject(o);
            var cmdText = string.Format("update Param set kvalue='{0}' where `Key`='{1}' limit 1;", data, key);
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    return MySqlHelper.ExecuteNonQuery(conn, CommandType.Text, cmdText) > 0;
                }
            }
            catch (System.Exception ex)
            {
                return false;
                throw;
            }
            return false;
        }

        #region 首页广告
        public class MerchantTypeItem
        {
            public int Id { get; set; }
            public string Name { get; set; }
        }
        public class SignTypeItem
        {
            public int Id { get; set; }
            /// <summary>
            /// 签约模式名称 模式A 模式B 模式C
            /// </summary>
            public string Name { get; set; }
            /// <summary>
            /// 销量的百分比 7% 8% 10%（存7、8、110）
            /// </summary>
            public float Prec { get; set; }
        }
        public class PlatformCfg
        {
            /// <summary>
            /// 手机软件端广告
            /// </summary>
            public PicJumpItem PhoneAd { get; set; }
            /// <summary>
            /// 商户首页右下角 单张广告图片显示的时间（秒）轮播
            /// </summary>
            public int MerchantAdStayTime { get; set; }
            /// <summary>
            /// 商户首页右下角广告列表
            /// </summary>
            public List<PicJumpItem> MerchantAds { get; set; }
            /// <summary>
            /// 商户类型名称列表
            /// </summary>
            public List<string> MerchantTypeList { get; set; }
            /// <summary>
            /// 签约列表
            /// </summary>
            public List<SignTypeItem> SignList { get; set; }
        }

        public static PlatformCfg PlatformCfgData
        {
            get
            {
                var key = "PlatformCfg";
                var obj = MyCache.Get(key);
                if (obj == null)
                {
                    obj = JsonConvert.DeserializeObject<PlatformCfg>(GetParamvalue(key));
                    MyCache.Put(key, obj);
                }
                return (PlatformCfg)obj;
            }
        }
        #endregion

        #region 获取积分配置
        public class ExtcreditCfg
        {
            public int Charge { get; set; }
            /// <summary>
            /// 分享获得
            /// </summary>
            public int Share { get; set; }
            /// <summary>
            /// 签到
            /// </summary>
            public int Register { get; set; }
            /// <summary>
            /// 消费（比例）
            /// </summary>
            public int Consume { get; set; }
            /// <summary>
            /// 评论
            /// </summary>
            public int Comment { get; set; }
        }
        public static ExtcreditCfg ExtcreditCfgData
        {
            get
            {
                var key = "ExtcreditCfg";
                var obj = MyCache.Get(key);
                if (obj == null)
                {
                    obj = JsonConvert.DeserializeObject<ExtcreditCfg>(GetParamvalue(key));
                    MyCache.Put(key, obj);
                }
                return (ExtcreditCfg)obj;
            }
        }
        #endregion

        #region 商户配置信息

        public static string MerchantCfgKey = "MerchantCfg:{0}";
        public class PicJumpItem
        {
            /// <summary>
            /// 图片本身url
            /// </summary>
            public string PicUrl { get; set; }
            /// <summary>
            /// 图片点击后跳转的页面url
            /// </summary>
            public string JumpUrl { get; set; }

            public PicJumpItem()
            {
                PicUrl = "";
                JumpUrl = "";
            }
        }
        /// <summary>
        /// 商户配置信息 
        /// </summary>
        public class MerchantCfg
        {
            /// <summary>
            /// 送餐费
            /// </summary>
            public int SendPrice { get; set; }
            /// <summary>
            /// 免送餐费的价格
            /// </summary>
            public int FreeSendPrice { get; set; }
            /// <summary>
            /// 登录页广告停留时间（秒）
            /// </summary>
            public int LoginAdStayTime { get; set; }
            /// <summary>
            /// 登录页广告图片地址
            /// </summary>
            public string LoginAdUrl { get; set; }
            /// <summary>
            /// wifi广告停留时间（秒）
            /// </summary>
            public int WifiAdStayTime { get; set; }
            /// <summary>
            /// wifi广告图片列表
            /// </summary>
            public List<PicJumpItem> WifiAds { get; set; }

            public MerchantCfg()
            {
                SendPrice = 5;
                FreeSendPrice = 100;
                LoginAdStayTime = 2;
                LoginAdUrl = "";
                WifiAdStayTime = 2;
                WifiAds = new List<PicJumpItem>();
            }
        }
        /// <summary>
        /// 获取商户配置信息
        /// </summary>
        /// <param name="sellerId"></param>
        /// <param name="name"></param>
        /// <returns></returns>
        public static MerchantCfg GetMerchantCfgData(int sellerId,string name)
        {
            var key = string.Format(MerchantCfgKey, sellerId);
            var obj = MyCache.Get(key);
            if (obj == null)
            {
                string str = GetParamvalue(key);
                if (string.IsNullOrEmpty(str))
                {
                    obj = new MerchantCfg();
                    AddMerchantParam(sellerId, obj, name);
                }
                else
                {
                    obj = JsonConvert.DeserializeObject<MerchantCfg>(str);
                }
                MyCache.Put(key, obj);
            }
            return (MerchantCfg)obj;
        }

        /// <summary>
        /// 更新商户配置信息
        /// </summary>
        /// <param name="sellerId"></param>
        /// <param name="cfg"></param>
        /// <returns></returns>
        public static bool UpdateMerchantCfg(int sellerId, MerchantCfg cfg)
        {
            try
            {
                var key = string.Format(MerchantCfgKey, sellerId);
                return UpdateParamvalue(key, cfg);
            }
            catch (Exception exc)
            {
                return false;
                throw;
            }
            return false;
        }
        /// <summary>
        /// 商户配置信息
        /// </summary>
        //public static MerchantCfg MerchantCfgData
        //{
        //    get
        //    {
        //        var key = "MerchantCfg";
        //        var obj = MyCache.Get(key);
        //        if (obj == null)
        //        {
        //            obj = JsonConvert.DeserializeObject<MerchantCfg>(GetParamvalue(key));
        //            MyCache.Put(key, obj);
        //        }
        //        return (MerchantCfg)obj;
        //    }
        //}
        #endregion
    }
}