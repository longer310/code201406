﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Entity
{
    /// <summary>
    /// 开发者后台 参数配置
    /// </summary>
    public class M_Param : KVEntity
    {
        /// <summary>
        /// 推送的广告图片id
        /// </summary>
        public int AdImgId { get; set; }
    }
}