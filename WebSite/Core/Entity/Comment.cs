using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Entity
{
    public class Comment
    {
        public int Id { get; set; }

        public int SellerId { get; set; }

        public string Content { get; set; }
        public int Type { get; set; }

        public int TypeId { get; set; }

        public int UserId { get; set; }

        public DateTime CreateTime { get; set; }
        

    }
}