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
        public static string SaveParamvalue(string key, object o)
        {
            var data = JsonTransfer.SerializeObject(o);
            var cmdText = string.Format("update Param set kvalue='{0}' where `Key`='{1}' limit 1;", data, key);
            try
            {
                using (var conn = Utility.ObtainConn(Utility._gameDbConn))
                {
                    MySqlHelper.ExecuteNonQuery(conn, CommandType.Text, cmdText);
                }
            }
            catch (System.Exception ex)
            {
                throw;
            }
            return "";
        }

        #region 首页广告
        public class PageAd
        {
            /// <summary>
            /// 推送的广告图片id
            /// </summary>
            public int AdImgId { get; set; }
            /// <summary>
            /// URL
            /// </summary>
            public string AdImgUrl { get; set; }
            /// <summary>
            /// 标题
            /// </summary>
            public string Title { get; set; }

            /// <summary>
            /// 跳转到的URL
            /// </summary>
            public string Url { get; set; }
        }

        public static PageAd PageAdData
        {
            get
            {
                var key = "PageAd";
                var obj = MyCache.Get(key);
                if (obj == null)
                {
                    obj = JsonConvert.DeserializeObject<PageAd>(GetParamvalue(key));
                    MyCache.Put(key, obj);
                }
                return (PageAd)obj;
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
            /// wifi广告停图片地址列表
            /// </summary>
            public List<string> WifiAdUrlList { get; set; }
        }
        /// <summary>
        /// 商户配置信息
        /// </summary>
        public static MerchantCfg MerchantCfgData
        {
            get
            {
                var key = "MerchantCfg";
                var obj = MyCache.Get(key);
                if (obj == null)
                {
                    obj = JsonConvert.DeserializeObject<MerchantCfg>(GetParamvalue(key));
                    MyCache.Put(key, obj);
                }
                return (MerchantCfg)obj;
            }
        }
        #endregion
    }
}