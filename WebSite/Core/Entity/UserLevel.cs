using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Entity
{
    public class UserLevel
    {
        public int Id { get; set; }

        public string Title { get; set; }

        public int Discount { get; set; }

        public int NeedMoney { get; set; }

        public int Level { get; set; }

        public DateTime CreateTime { get; set; }

        public int SellerId { get; set; }

        //public int  { get; set; }

    }
}