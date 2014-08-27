using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Entity
{
    public class Push
    {
        public int Id { get; set; }

        public string Title { get; set; }

        public PushType PushType { get; set; }

        public string Content { get; set; }

        public int TypeId { get; set; }

        public DateTime CreateTime { get; set; }

        public int SellerId { get; set; }

    }

    public enum PushType
    {
        Img = 1,
        Goods = 2,
        Active = 3,
        Url = 4
    }
}