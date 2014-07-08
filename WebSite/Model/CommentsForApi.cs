using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Model
{
    public class CommentsForApis
    {
        public IList<ComentsForApi> Comments { get; set; }
        public int Commentnum { get; set; }

        public CommentsForApis()
        {
            Comments = new List<ComentsForApi>();
        }
    }

    public class ComentsForApi
    {
        public string Avatar { get; set; }

        public string UserName { get; set; }

        public int Sex { get; set; }

        public DateTime Dateline { get; set; }

        public string Message { get; set; }
    }

}