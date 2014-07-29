using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Entity
{
    /// <summary>
    /// 商户产品
    /// </summary>
    public class Goods : KVEntity
    {
        /// <summary>
        /// 商户id
        /// </summary>
        public int SellerId { get; set; }
        /// <summary>
        /// 封面图
        /// </summary>
        //public int Logo { get; set; }

        /// <summary>
        /// 产品图集
        /// </summary>
        //public string ImgIds { get; set; }
        //public List<int> ImgIdList { get; set; }

        /// <summary>
        /// 销量
        /// </summary>
        public int Sales { get; set; }
        /// <summary>
        /// 标题
        /// </summary>
        public string Title { get; set; }
        /// <summary>
        /// 分类id
        /// </summary>
        public int Cid { get; set; }
        /// <summary>
        /// 现价
        /// </summary>
        public float Nowprice { get; set; }
        /// <summary>
        /// 原价
        /// </summary>
        public float OriginalPrice { get; set; }
        /// <summary>
        /// 评级
        /// </summary>
        public float Score { get; set; }
        /// <summary>
        /// 创建时间或者最后修改时间
        /// </summary>
        public DateTime CreateTime { get; set; }
        /// <summary>
        /// 收藏次数
        /// </summary>
        public int FavCount { get; set; }
        /// <summary>
        /// 分享次数
        /// </summary>
        public int ShareCount { get; set; }
        /// <summary>
        /// 产品标签
        /// </summary>
        public string Tag
        {
            get { return Utility.GetString(TagList); }
        }
        /// <summary>
        /// 产品标签列表
        /// </summary>
        public List<string> TagList { get; set; }
        /// <summary>
        /// 产品描述
        /// </summary>
        public string Content { get; set; }

        /// <summary>
        /// 图片地址 (注：直接保存)
        /// </summary>
        public string LogoUrl { get; set; }
        /// <summary>
        /// 图片地址列表 (注：直接保存)
        /// </summary>
        public List<string> ImageUrlList { get; set; }

        /// <summary>
        /// 是否热销
        /// </summary>
        public int IsHot { get; set; }
        /// <summary>
        /// 评论次数
        /// </summary>
        public int CommentCount { get; set; }
        /// <summary>
        /// 浏览次数
        /// </summary>
        public int BrowseCount { get; set; }

        /// <summary>
        /// 是否推荐
        /// </summary>
        public int IsRecommend { get; set; }

        public List<GoodsLogo> Thumbnails { get; set; }

        //public List<int> ImgIdList { get; set; //get
        //{
        //    var List = ImgIds.Split(new Char[] { ',' }, StringSplitOptions.RemoveEmptyEntries).ToList();
        //    List<int> imgids = new List<int>();
        //    foreach (var imgid in List)
        //    {
        //        imgids.Add(Convert.ToInt32(imgid));
        //    }
        //    return imgids;
        //}
        //}

        public Goods()
        {
            Thumbnails = Thumbnails ?? new List<GoodsLogo>();
        }

        public void InitThumbnails()
        {
            Thumbnails = new List<GoodsLogo>();
            foreach (var imageUrl in ImageUrlList)
            {
                var logo = new GoodsLogo();
                if (imageUrl.Equals(LogoUrl)) logo.IsLogo = 1;
                logo.Url = imageUrl;

                Thumbnails.Add(logo);
            }
        }
    }

    public class GoodsLogo
    {
        public int IsLogo { get; set; }
        public string Url { get; set; }
    }
}