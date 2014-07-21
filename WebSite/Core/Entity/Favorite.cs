using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Entity
{
    /// <summary>
    /// 用户收藏 id=userid
    /// </summary>
    public class Favorite : KVEntity
    {
        /// <summary>
        /// 收藏的产品id列表
        /// </summary>
        //public string Gids { get; set; }

        public List<int> GidList { get; set; //get
            //{
            //    var List = Gids.Split(new Char[] {','}, StringSplitOptions.RemoveEmptyEntries).ToList();
            //    List<int> glist = new List<int>();
            //    foreach (var gid in List)
            //    {
            //        glist.Add(Convert.ToInt32(gid));
            //    }
            //    return glist;
            //}
        }

        public Favorite()
        {
            GidList = new List<int>();
        }
    }



}