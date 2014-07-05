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

        public string Views { get; set; }

        public int Commentnum { get; set; }

        public string Title { get; set; }

        public string Url { get; set; }

        public string Content { get; set; }

        public DateTime CreateTime { get; set; }
        

    }
}