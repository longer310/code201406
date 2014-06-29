using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WebSite
{
    public class PagResults<T>
    {
        public IList<T> Results { get; set; }

        public int TotalCount { get; set; }
    }
}
