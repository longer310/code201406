using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Entity
{
    public class ExtractMoney
    {
        public int Id { get; set; }

        public int SellerId { get; set; }

        /// <summary>
        /// 提现金额
        /// </summary>
        public int Money { get; set; }

        /// <summary>
        /// 余额
        /// </summary>
        public int Balance { get; set; }

        /// <summary>
        /// 开户名
        /// </summary>
        public string AccountName { get; set; }

        /// <summary>
        /// 银行
        /// </summary>
        public string Bank { get; set; }

        /// <summary>
        /// 卡号
        /// </summary>
        public long CardNumber { get; set; }

        public DateTime CreateTime { get; set; }


        /// <summary>
        /// 1:已提现成功，0:未提现，-1：处理失败
        /// </summary>
        public int Status { get; set; }


    }
}