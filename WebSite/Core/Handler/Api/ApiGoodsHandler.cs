using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Web;
using Backstage.Core;
using Backstage.Core.Entity;
using Backstage.Core.Logic;

namespace Backstage.Handler
{
    public class ApiGoodsHandler : BaseApiHandler
    {
        public override void ProcessRequest(HttpContext context)
        {
            base.SetApiName("ApiGoodsHandler");
            base.ProcessRequest(HttpContext.Current);
            switch (Action)
            {
                case "getpageinfo"://首页
                    GetPageInfo();
                    break;
                case "getgoodslist"://获取产品列表
                    GetGoodsList();
                    break;
                case "getgoodsdetail"://获取产品详情
                    GetGoodsDetail();
                    break;
                case "getgoodscomments"://获取产品评论
                    GetGoodsComments();
                    break;
                case "addgoodscomment"://发表产品评论
                    AddGoodsComment();
                    break;
                case "favgoods"://收藏商品
                    FavGoods();
                    break;
                case "sharegoods"://分享商品
                    ShareGoods();
                    break;
                default: break;
            }

        }
        #region 首页
        public class HomeData
        {
            public List<SlideItem> slide { get; set; }

            public AdItem ad { get; set; }

            public List<HotItem> hots { get; set; }

            public HomeData()
            {
                slide = new List<SlideItem>();
                ad = new AdItem();
                hots = new List<HotItem>();
            }
        }
        public class SlideAdItem
        {
            public string img { get; set; }
            public string title { get; set; }
        }
        public class SlideItem : SlideAdItem
        {
            public int type { get; set; }
            public int typeid { get; set; }
        }
        public class AdItem : SlideAdItem
        {
            public string url { get; set; }
        }
        public class TSlideItem : SlideItem
        {
            public DateTime createtime { get; set; }
        }
        public class HotItem
        {
            public string img { get; set; }
            public int gid { get; set; }
        }
        private void GetPageInfo()
        {
            int sellerid = GetInt("sellerid");

            if (sellerid == 0)
            {
                ReturnErrorMsg("商户id不合法");
                return;
            }
            //单独获取产品的列表 以后得改 +图片墙+活动
            var list = new List<TSlideItem>();
            int totalnum;
            var gads = GoodsHelper.GetGoodsList(sellerid, out totalnum, "", "", 0, 5, 0);
            foreach (var gad in gads)
            {
                var s = new TSlideItem();
                s.img = gad.LogoUrl;
                s.title = gad.Title;
                s.type = (int)CommentType.Goods;
                s.typeid = gad.Id;
                s.createtime = gad.CreateTime;

                list.Add(s);
            }
            var aads = ActiveHelper.GetList(0, 5, "", " order by createtime desc ");
            foreach (var aad in aads)
            {
                var s = new TSlideItem();
                s.img = aad.CoverImgUrl;
                s.title = aad.Title;
                s.type = (int)CommentType.Avtive;
                s.typeid = aad.Id;
                s.createtime = aad.CreateTime;

                list.Add(s);
            }
            var pads = SourceMaterialHelper.GetList(0, 5, "", " order by createtime desc ");
            foreach (var pad in pads)
            {
                var s = new TSlideItem();
                s.img = pad.Url;
                s.title = pad.Title;
                s.type = (int)CommentType.Img;
                s.typeid = pad.Id;
                s.createtime = pad.CreateTime;

                list.Add(s);
            }

            list = list.OrderByDescending(o => o.createtime).Take(5).ToList();

            var data = new HomeData();
            foreach (var l in list)
            {
                data.slide.Add(new SlideItem() { img = l.img, title = l.title, type = l.type, typeid = l.typeid });
            }

            Mparam mpparam = MparamHelper.GetMparam(1);
            data.ad = new AdItem() { img = mpparam.AdImgUrl, title = mpparam.Title, url = mpparam.Url };

            int totalcount;
            var glist = GoodsHelper.GetGoodsList(sellerid, out totalcount, " and IsHot = 1 ","", 0, 8, 0);
            foreach (var gl in glist)
            {
                data.hots.Add(new HotItem() { img=gl.LogoUrl,gid=gl.Id });
            }

            JsonTransfer jt = new JsonTransfer();
            jt.AddSuccessParam();
            jt.Add("data", data);
            Response.Write(DesEncrypt(jt));
            Response.End();
        }
        #endregion

        #region 获取商品列表
        private class GoodsListData
        {
            public List<CategoriesItem> categories { get; set; }
            public List<GoodsItem> goods { get; set; }

            public GoodsListData()
            {
                categories = new List<CategoriesItem>();
                goods = new List<GoodsItem>();
            }
        }

        private class CategoriesItem
        {
            public int cid { get; set; }
            public string title { get; set; }
            public CategoriesItem()
            {
                title = "";
            }
        }

        private class GoodsItem
        {
            public int gid { get; set; }
            public string title { get; set; }
            public string img { get; set; }
            public float nowprice { get; set; }
            public float originalprice { get; set; }
            public int sales { get; set; }
            public float score { get; set; }
            public int isfav { get; set; }
            public string content { get; set; }

            public GoodsItem()
            {
                title = "";
                img = "";
                content = "";
            }
        }

        /// <summary>
        /// 获取商品列表
        /// </summary>
        private void GetGoodsList()
        {
            int sellerid = GetInt("sellerid");
            int cid = GetInt("cid");
            int order = GetInt("order");
            int start = GetInt("start");
            int limit = GetInt("limit");

            string wheresql = string.Empty;
            string ordersql = "";
            if (cid > 0) wheresql += string.Format(" and Cid={0}", cid);
            switch (order)
            {
                case 1:
                    ordersql += " order by Sales asc "; break;
                case -1:
                    ordersql += " order by Sales desc "; break;
                case 2:
                    ordersql += " order by CreateTime asc "; break;
                case -2:
                    ordersql += " order by CreateTime desc "; break;
                case 3:
                    ordersql += " order by Nowprice asc "; break;
                case -3:
                    ordersql += " order by Nowprice desc "; break;
            }

            //组装下发数据
            int totalcount;
            int totalccount;
            var user = Utility.GetCurUser();
            var goodslist = GoodsHelper.GetGoodsList(sellerid, out totalcount, wheresql, ordersql, start * limit, limit);
            //string pwheresql = GetWhereSql(goodslist.Select(o => o.Logo).ToList());
            //var picList = SourceMaterialHelper.GetList(0, 0, pwheresql, "");
            var gclist = GoodsCategoriesHelper.GetList(sellerid, out totalccount);
            Favorite favorite = null;
            if (user != null)
            {
                favorite = FavoriteHelper.GetFavorite(user.Id);
            }
            GoodsListData data = new GoodsListData();
            foreach (var goodsCategoriese in gclist)
            {
                CategoriesItem citem = new CategoriesItem();
                citem.cid = goodsCategoriese.Id;
                citem.title = goodsCategoriese.Name;

                data.categories.Add(citem);
            }

            foreach (var goods in goodslist)
            {
                GoodsItem gitem = new GoodsItem();
                gitem.title = goods.Title;
                //var pic = picList.FirstOrDefault(o => o.Id == goods.Logo);
                //if (pic != null) gitem.img = pic.Url;
                gitem.img = goods.LogoUrl;
                gitem.nowprice = goods.Nowprice;
                gitem.originalprice = goods.OriginalPrice;
                gitem.sales = goods.Sales;
                gitem.score = goods.Score;
                gitem.content = goods.Content;
                if (favorite != null && favorite.GidList.Contains(goods.Id))
                    gitem.isfav = 1;
                gitem.gid = goods.Id;

                data.goods.Add(gitem);
            }

            JsonTransfer jt = new JsonTransfer();
            jt.AddSuccessParam();
            jt.Add("data", data);
            Response.Write(DesEncrypt(jt));
            Response.End();
        }
        #endregion

        #region 商品详情
        public class GoodsDetailItem
        {
            public List<string> images { get; set; }
            public int gid { get; set; }
            public string title { get; set; }
            public float nowprice { get; set; }
            public float originalprice { get; set; }
            public int sales { get; set; }
            public int score { get; set; }
            public int isfav { get; set; }
            public string tag { get; set; }
            public string content { get; set; }
            public int favcount { get; set; }
            public int sharecount { get; set; }
            public int cid { get; set; }
            public string cname { get; set; }

            public GoodsDetailItem()
            {
                images = new List<string>();
                title = "";
                tag = "";
                content = "";
                cname = "";
            }
        }
        public void GetGoodsDetail()
        {
            int gid = GetInt("gid");

            var goods = GoodsHelper.GetGoods(gid);
            int cid = goods.Cid;
            var gcategories = GoodsCategoriesHelper.GetGoodsCategories(cid);
            string wheresql = GetWhereSql(goods.ImgIdList);
            var piclist = SourceMaterialHelper.GetList(0, 0, wheresql, "");
            var user = Utility.GetCurUser();
            Favorite favorite = null;
            if (user != null)
                favorite = FavoriteHelper.GetFavorite(user.Id);
            var data = new GoodsDetailItem();

            foreach (var sourceMaterial in piclist)
            {
                data.images.Add(sourceMaterial.Url);
            }
            data.gid = gid;
            data.title = goods.Title;
            data.nowprice = goods.Nowprice;
            data.originalprice = goods.OriginalPrice;
            data.sales = goods.Sales;
            data.tag = goods.Tag;
            data.content = goods.Content;
            if (favorite != null && favorite.GidList.Contains(goods.Id))
                data.isfav = 1;
            data.favcount = goods.FavCount;
            data.sharecount = goods.ShareCount;
            data.cid = cid;
            if (gcategories != null)
                data.cname = gcategories.Name;

            JsonTransfer jt = new JsonTransfer();
            jt.AddSuccessParam();
            jt.Add("data", data);
            Response.Write(DesEncrypt(jt));
            Response.End();
        }
        #endregion

        #region 获取商品评论列表
        public class CommentResponse
        {
            public int commentnum { get; set; }
            public List<CommentItem> comments { get; set; }

            public CommentResponse()
            {
                comments = new List<CommentItem>();
            }
        }
        public class CommentItem
        {
            public string avatar { get; set; }
            public string username { get; set; }
            public int sex { get; set; }
            public DateTime dateline { get; set; }
            public string message { get; set; }

            public CommentItem()
            {
                avatar = username = message = "";
                dateline = DateTime.MinValue;
            }
        }
        public void GetGoodsComments()
        {
            int start = GetInt("start");
            int limit = GetInt("limit");
            int gid = GetInt("gid");

            int totalcount = 0;
            int utotalcount;
            var goods = GoodsHelper.GetGoods(gid);
            int sellerId = goods.SellerId;
            var commentResult = CommentHelper.GetPagings(sellerId, CommentType.Goods, gid, start * limit, limit);
            var commentlist = commentResult.Results;
            string wheresql = GetWhereSql(commentlist.Select(o => o.UserId).ToList());
            var userlist = AccountHelper.GetUserList(out utotalcount, wheresql, "", start * limit, limit);

            var data = new CommentResponse();
            data.commentnum = totalcount;
            foreach (var comment in commentlist)
            {
                var item = new CommentItem();
                item.dateline = comment.CreateTime;
                item.message = comment.Content;

                var user = userlist.FirstOrDefault(o => o.Id == comment.UserId);
                if (user != null)
                {
                    item.avatar = user.Avatar;
                    item.username = user.UserName;
                    item.sex = user.Sex;
                }

                data.comments.Add(item);
            }

            JsonTransfer jt = new JsonTransfer();
            jt.AddSuccessParam();
            jt.Add("data", data);
            Response.Write(DesEncrypt(jt));
            Response.End();
        }
        #endregion

        #region 发表商品评论
        public void AddGoodsComment()
        {
            int uid = GetInt("uid");
            int gid = GetInt("gid");
            string message = GetString("message");

            var goods = GoodsHelper.GetGoods(gid);
            var comment = new Comment();
            comment.Content = message;
            comment.CreateTime = DateTime.Now;
            comment.SellerId = goods.SellerId;
            comment.Type = CommentType.Goods;
            comment.TypeId = gid;
            comment.UserId = uid;

            //发表商品评论
            CommentHelper.Create(comment);

            //返回
            ReturnCorrectMsg("返回消息");
        }
        #endregion

        #region 商品收藏
        public void FavGoods()
        {
            int uid = GetInt("uid");
            int gid = GetInt("gid");

            var goods = GoodsHelper.GetGoods(gid);
            goods.FavCount++;
            var favorite = FavoriteHelper.GetFavorite(uid);
            if (favorite.GidList.Contains(gid))
            {
                ReturnErrorMsg("已收藏过该商品");
                return;
            }
            if (favorite.GidList.Count == 0)
                favorite.Gids = gid.ToString();
            else
                favorite.Gids += "," + gid.ToString();

            //保存商品
            GoodsHelper.SaveGoods(goods);
            //保存收藏
            FavoriteHelper.SaveFavorite(favorite);
            //返回
            ReturnCorrectMsg("返回消息");
        }
        #endregion

        #region 商品分享
        public void ShareGoods()
        {
            int uid = GetInt("uid");
            int gid = GetInt("gid");

            var goods = GoodsHelper.GetGoods(gid);
            goods.ShareCount++;

            //保存商品
            GoodsHelper.SaveGoods(goods);
            //返回
            ReturnCorrectMsg("返回消息");
        }
        #endregion
    }
}