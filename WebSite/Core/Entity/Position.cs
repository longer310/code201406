using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Entity
{
    public class Position
    {
        public int Id { get; set; }

        public int ImgId { get; set; }

        public string ImgUrl { get; set; }

        public string Title { get; set; }

        public float Price { get; set; }

        public string Description { get; set; }

        public int Phone { get; set; }

        public int Status { get; set; }

        public int SellerId { get; set; }
    }
}