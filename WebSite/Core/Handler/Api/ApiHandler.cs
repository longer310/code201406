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
    public class ApiHandler : BaseApiHandler
    {
        public override void ProcessRequest(HttpContext context)
        {
            base.SetApiName("ApiHandler");
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
        private void GetPageInfo()
        {
            JsonTransfer jt = new JsonTransfer();
            int sellerid = GetInt("sellerid");

            if (sellerid == 0)
            {
                ReturnErrorMsg("商户id不合法");
                return;
            }
            jt.AddSuccessParam();
            //单独获取产品的列表 以后得改 +图片墙+活动
            int totalnum;
            var ads = GoodsHelper.GetGoodsList(sellerid, out totalnum, "", "", 0, 5);
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
            public string title { get; set; }
            public string img { get; set; }
            public int nowprice { get; set; }
            public int originalprice { get; set; }
            public int sales { get; set; }
            public int score { get; set; }
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

            string wheresql = "";
            string ordersql = "";
            if (cid > 0) wheresql += string.Format(" Cid={0}", cid);
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
            var picList = new List<SourceMaterial>();//TODO:去图片表获取图片列表
            var gclist = GoodsCategoriesHelper.GetList(sellerid, out totalccount);
            Favorite favorite = FavoriteHelper.GetFavorite(user.Id);
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
                var pic = picList.FirstOrDefault(o => o.Id == goods.Logo);
                if (pic != null) gitem.img = pic.Url;
                gitem.nowprice = goods.Nowprice;
                gitem.originalprice = goods.OriginalPrice;
                gitem.sales = goods.Sales;
                gitem.score = goods.Score;
                gitem.content = goods.Content;
                if (favorite != null && favorite.GidList.Contains(goods.Id))
                    gitem.isfav = 1;

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
            public int nowprice { get; set; }
            public int originalprice { get; set; }
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
            var piclist = new List<SourceMaterial>();//TODO:去图片表获取图片列表
            var user = Utility.GetCurUser();
            Favorite favorite = FavoriteHelper.GetFavorite(user.Id);
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
            var commentlist = new List<Comment>();//TODO:获取评论列表
            var uidlist = commentlist.Select(o => o.UserId).ToList();
            string wheresql = "";
            string str = String.Join(",", uidlist.ConvertAll<string>(new Converter<int, string>(m => m.ToString())).ToArray());
            wheresql += " Id in(" + str + ") ";
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

            //TODO:调用添加评论接口

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