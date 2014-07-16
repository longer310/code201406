// -------------------------------------------------------
// Copyright (C) 施维串 版权所有。
// 文 件 名：GameCache.cs
// 创建标识：2012/11/1 23:39:34 Created by 施维串
// 功能说明：
// 注意事项：
// 
// 更新记录：
// -------------------------------------------------------


using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections.Concurrent;
using Backstage.Core;

namespace WebSite.Core
{
    /// <summary>
    /// 缓存对象,Key不区分大小写
    /// </summary>
    public static class MyCache
    {
        private static ConcurrentDictionary<string, object> ht = new ConcurrentDictionary<string, object>(StringComparer.InvariantCultureIgnoreCase);

        /// <summary>
        /// 根据key获取对象
        /// </summary>
        /// <param name="key"></param>
        /// <returns></returns>
        public static object Get(string key)
        {
            object result = null;
            ht.TryGetValue(key, out result);
            return result;
        }

        /// <summary>
        /// 根据key删除对象
        /// </summary>
        /// <param name="key"></param>
        public static void Delete(string key)
        {
            object value;
            ht.TryRemove(key, out value);
        }

        /// <summary>
        /// 将对象放到缓存
        /// </summary>
        /// <param name="key"></param>
        /// <param name="value"></param>
        public static void Put(string key, object value)
        {
            ht[key] = value;
        }

        /// <summary>
        /// 刷新缓存
        /// </summary>
        public static void Reset()
        {
            var tobeDisposed = ht;
            ht = new ConcurrentDictionary<string, object>();
            foreach (var item in ht)
            {
                var disp = item.Value as IDisposable;
                if (disp != null)
                {
                    try
                    {
                        disp.Dispose();
                    }
                    catch (Exception ex)
                    {
                    }
                }
            }
        }
    }
}
