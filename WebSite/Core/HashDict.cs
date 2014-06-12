// -------------------------------------------------------
// Copyright (C) 施维串 版权所有。
// 文 件 名：HashDict.cs
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

namespace Backstage.Core
{
    /// <summary>
    /// 不区分大小写的字典
    /// </summary>
    /// <typeparam name="TValue"></typeparam>
    public class HashDict<TValue> : Dictionary<string, TValue>
    {
        public HashDict()
            : base(StringComparer.InvariantCultureIgnoreCase)
        {

        }

        /// <summary>
        /// 获取指定key的值，并转成指定类型的对象
        /// </summary>
        /// <typeparam name="T">要转换的类型</typeparam>
        /// <param name="key">要获取的值关联的key</param>
        /// <returns></returns>
        public T Get<T>(string key)
        {
            var typecode = Type.GetTypeCode(typeof(T));
            var v = this[key];
            if (typecode == TypeCode.Object)
            {
                return Newtonsoft.Json.JsonConvert.DeserializeObject<T>(v.ToString());
            }
            return (T)Convert.ChangeType(v, typecode);
        }

        public int GetInt(string key)
        {
            return Get<int>(key);
        }

        public string GetString(string key)
        {
            return Get<string>(key);
        }
    }
}
