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
            var cmdText = string.Format("select * from Param where Key={0} limit 1;", key);
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
    }
}