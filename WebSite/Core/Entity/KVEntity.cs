using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Web;

namespace Backstage.Core.Entity
{
    /// <summary>
    /// 对象Id接口
    /// </summary>
    public interface IObjectId
    {
        /// <summary>
        /// 对象Id
        /// </summary>
        int Id { get; set; }
    }

    /// <summary>
    /// 实体基类
    /// </summary>
    public abstract class KVEntity : IObjectId
    {
        /// <summary>
        /// Id
        /// </summary>
        public int Id { get; set; }
    }
}