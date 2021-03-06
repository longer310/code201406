﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Reflection;
using System.Security.Permissions;
using System.Web;
using System.Web.UI.WebControls;
using Backstage.Core;
using Backstage.Core.Entity;
using Backstage.Core.Handler;
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
                #region 商品
                case "getpageinfo"://首页 1
                    GetPageInfo(context);
                    break;
                case "getgoodslist"://获取产品列表 2.1
                    GetGoodsList(context);
                    break;
                case "getgoodsdetail"://获取产品详情 2.2
                    GetGoodsDetail(context);
                    break;
                case "getgoodscomments"://获取产品评论 2.3
                    GetGoodsComments(context);
                    break;
                case "addgoodscomment"://发表产品评论 2.4
                    AddGoodsComment();
                    break;
                case "favgoods"://收藏/取消收藏商品 2.5
                    FavGoods();
                    break;
                case "sharegoods"://分享商品 2.6
                    ShareGoods();
                    break;
                #endregion

                #region 订单
                case "addshoppingcart"://添加产品到购物车 6.1
                    AddShoppingCart();
                    break;
                case "getshoppingcartlist"://获取购物车列表 6.2
                    GetShoppingCartList(context);
                    break;
                case "addorders"://添加订单 6.3
                    AddOrders();
                    break;
                case "getordersdetail"://获取订单详情 6.4
                    GetOrdersDetail(context);
                    break;
                case "getpaymentlist"://获取支付方式列表 6.5
                    GetPaymentList();
                    break;
                case "updateorders"://更新订单 6.6
                    UpdateOrders(context);
                    break;
                case "updateordersstatus"://更新订单状态 6.7
                    UpdateOrdersStatus();
                    break;
                case "delshoppingcart"://删除购物车 6.8
                    DelShoppingCart();
                    break;
                #endregion

                case "testprint"://删除购物车 6.8
                    TestPrint();
                    break;
                default: break;
            }
        }

        private void TestPrint()
        {
            var id = GetInt("id");
            var orders = OrdersHelper.GetOrders(id);
            if (orders == null)
            {
                ReturnErrorMsg("订单不存在");
                return;
            }
            if (Utility.SendOrdersMsgToPrint(orders))
            {
                ReturnCorrectMsg("订单打印成功");
                return;
            }
            ReturnCorrectMsg("订单打印失败");
        }
        #region 首页 1
        public class HomeData
        {
            public List<SlideItem> slide { get; set; }
            public int slidetime { get; set; }

            public AdItem ad { get; set; }

            public List<HotItem> hots { get; set; }

            public string phone { get; set; }

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
            public int createtime { get; set; }

            public TSlideItem()
            {
                img = title = "";
            }
        }
        public class HotItem
        {
            public string img { get; set; }
            public int gid { get; set; }
        }
        private void GetPageInfo(HttpContext context)
        {
            int sellerid = GetInt("sellerid");

            if (sellerid == 0)
            {
                ReturnErrorMsg("商户id不合法");
                return;
            }
            var merchant = MerchantHelper.GetMerchant(sellerid);
            if (merchant == null)
            {
                ReturnErrorMsg("不存在该商户");
                return;
            }
            var data = new HomeData();

            //单独获取产品的列表 以后得改 +图片墙+活动
            //var list = new List<TSlideItem>();
            merchant.SlideAds = merchant.SlideAds ?? new List<Core.Entity.SlideAdItem>();
            foreach (var slideAdItem in merchant.SlideAds)
            {
                var s = new SlideItem();
                //企业幻灯大小要改成540*420大小 modify by hql at 2014.11.10
                if (merchant.MerType == MerchantTypes.Company)
                    s.img = Utility.GetSizePicUrl(slideAdItem.img, 540, 420, context);
                else
                    s.img = Utility.GetSizePicUrl(slideAdItem.img, 540, 224, context);
                s.type = slideAdItem.type;
                s.typeid = slideAdItem.typeid;
                s.title = "";
                if (s.type == (int)CommentType.Goods)
                {
                    var goods = GoodsHelper.GetGoods(s.typeid);
                    if (goods != null) s.title = goods.Title;
                }
                else if (s.type == (int)CommentType.Avtive)
                {
                    var active = ActiveHelper.GetItem(s.typeid);
                    if (active != null) s.title = active.Title;
                }
                else if (s.type == (int)CommentType.Img)
                {
                    var sourceMaterialHelper = SourceMaterialHelper.GetItem(s.typeid);
                    if (sourceMaterialHelper != null) s.title = sourceMaterialHelper.Title;
                }
                data.slide.Add(s);
            }
            data.slidetime = merchant.SlideAdStayTime;
            //var gads = GoodsHelper.GetGoodsList(sellerid, "", "", 0, 5).Results;
            //foreach (var gad in gads)
            //{
            //    var s = new TSlideItem();
            //    s.img = Utility.GetPhoneNeedUrl(gad.LogoUrl);
            //    s.title = gad.Title;
            //    s.type = (int)CommentType.Goods;
            //    s.typeid = gad.Id;
            //    s.createtime = gad.CreateTime.GetUnixTime();

            //    list.Add(s);
            //}
            //var aads = ActiveHelper.GetList(0, 5, "", " order by createtime desc ");
            //foreach (var aad in aads)
            //{
            //    var s = new TSlideItem();
            //    s.img = Utility.GetPhoneNeedUrl(aad.CoverImgUrl);
            //    s.title = aad.Title;
            //    s.type = (int)CommentType.Avtive;
            //    s.typeid = aad.Id;
            //    s.createtime = aad.CreateTime.GetUnixTime();

            //    list.Add(s);
            //}
            //var pads = SourceMaterialHelper.GetList(0, 5, "", " order by createtime desc ");
            //foreach (var pad in pads)
            //{
            //    var s = new TSlideItem();
            //    s.img = Utility.GetPhoneNeedUrl(pad.Url);
            //    s.title = pad.Title;
            //    s.type = (int)CommentType.Img;
            //    s.typeid = pad.Id;
            //    s.createtime = pad.CreateTime.GetUnixTime();

            //    list.Add(s);
            //}

            //list = list.OrderByDescending(o => o.createtime).Take(5).ToList();

            //foreach (var l in list)
            //{
            //    data.slide.Add(new SlideItem() { img = Utility.GetPhoneNeedUrl(l.img), title = l.title, type = l.type, typeid = l.typeid });
            //}

            var pcfg = ParamHelper.PlatformCfgData;
            data.ad = new AdItem() { img = Utility.GetSizePicUrl(pcfg.PhoneAd.PicUrl, 540, 65, context), url = pcfg.PhoneAd.JumpUrl };
            //var merchantTypes = merchant.GetMerchantTypes();

            if (merchant.MerType == MerchantTypes.Food)
            {
                var glist = GoodsHelper.GetGoodsList(sellerid, " and a.IsHot = 1 ", "", 0, 8).Results;
                foreach (var gl in glist)
                {
                    data.hots.Add(new HotItem() { img = Utility.GetSizePicUrl(gl.LogoUrl, 270, 200, context), gid = gl.Id });
                }
            }
            else if (merchant.MerType == MerchantTypes.Night)
            {
                var mlist = SourceMaterialHelper.GetList(sellerid, 0, 8);
                foreach (var gl in mlist)
                {
                    data.hots.Add(new HotItem() { img = Utility.GetSizePicUrl(gl.Url, 190, 130, context), gid = gl.Id });
                }
            }

            data.phone = merchant.Phone;

            //返回信息
            ReturnCorrectData(data);
        }
        #endregion

        #region 获取商品列表 2.1
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
            public string img { get; set; }
            public string color { get; set; }
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
            //public int cid { get; set; }

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
        private void GetGoodsList(HttpContext context)
        {
            int sellerid = GetInt("sellerid");
            int cid = GetInt("cid");
            int order = GetInt("order");
            int start = GetInt("start");
            int limit = GetInt("limit");
            int uid = GetInt("uid");
            var keyword = GetString("keyword");

            string wheresql = string.Empty;
            string shoppingcartql = "";
            if (cid > 0) wheresql += string.Format(" and Cid={0}", cid);
            if (!string.IsNullOrEmpty(keyword)) wheresql += string.Format(" and Title like'%{0}%'", keyword);
            switch (order)
            {
                case 1:
                    shoppingcartql += " order by Sales asc "; break;
                case -1:
                    shoppingcartql += " order by Sales desc "; break;
                case 2:
                    shoppingcartql += " order by CreateTime asc "; break;
                case -2:
                    shoppingcartql += " order by CreateTime desc "; break;
                case 3:
                    shoppingcartql += " order by Nowprice asc "; break;
                case -3:
                    shoppingcartql += " order by Nowprice desc "; break;
                default: break;
            }

            //组装下发数据
            //var user = AccountHelper.GetCurUser();
            var goodslist = GoodsHelper.GetGoodsList(sellerid, wheresql, shoppingcartql, start * limit, limit).Results;
            //string pwheresql = GetWhereSql(goodslist.Select(o => o.Logo).ToList());
            //var picList = SourceMaterialHelper.GetList(0, 0, pwheresql, "");
            var gclist = GoodsCategoriesHelper.GetList(sellerid).Results;
            Favorite favorite = null;
            if (uid > 0)
            {
                favorite = FavoriteHelper.GetFavorite(uid);
            }
            GoodsListData data = new GoodsListData();
            foreach (var goodsCategoriese in gclist)
            {
                CategoriesItem citem = new CategoriesItem();
                citem.cid = goodsCategoriese.Id;
                citem.title = goodsCategoriese.Name;
                citem.img = Utility.GetSizePicUrl(goodsCategoriese.ImageUrl, 448, 126, context);
                citem.color = goodsCategoriese.Color;

                data.categories.Add(citem);
            }

            foreach (var goods in goodslist)
            {
                GoodsItem gitem = new GoodsItem();
                gitem.title = goods.Title;
                //var pic = picList.FirstOrDefault(o => o.Id == goods.Logo);
                //if (pic != null) gitem.img = pic.Url;
                gitem.img = Utility.GetSizePicUrl(goods.LogoUrl, 188, 133, context);
                gitem.nowprice = goods.Nowprice;
                gitem.originalprice = goods.OriginalPrice;
                gitem.sales = goods.Sales;
                gitem.score = goods.Score;
                gitem.content = Utility.GetNoHtmlStr(goods.Content);
                //gitem.cid = goods.Cid;
                if (favorite != null && favorite.GidList.Contains(goods.Id))
                    gitem.isfav = 1;
                gitem.gid = goods.Id;

                data.goods.Add(gitem);
            }

            //返回信息
            ReturnCorrectData(data);
        }
        #endregion

        #region 商品详情 2.2
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
        public void GetGoodsDetail(HttpContext context)
        {
            int gid = GetInt("gid");
            int sellerid = GetInt("sellerid");
            int uid = GetInt("uid");

            var goods = GoodsHelper.GetGoods(gid);
            if (goods == null)
            {
                ReturnErrorMsg("商户不存在");
                return;
            }
            if (goods.SellerId != sellerid)
            {
                ReturnErrorMsg("商户id与产品不对应");
                return;
            }
            int cid = goods.Cid;
            var gcategories = GoodsCategoriesHelper.GetGoodsCategories(cid);
            //string wheresql = Utility.GetWhereSql(goods.ImgIdList);
            //var piclist = SourceMaterialHelper.GetList(0, 0, wheresql, "");
            //var user = AccountHelper.GetCurUser();
            Favorite favorite = null;
            if (uid > 0)
                favorite = FavoriteHelper.GetFavorite(uid);
            var data = new GoodsDetailItem();

            //foreach (var sourceMaterial in piclist)
            //{
            //    data.images.Add(sourceMaterial.Url);
            //}
            data.images = Utility.GetSizePicUrlList(goods.ImageUrlList, 540, 400, context);
            data.gid = gid;
            data.title = goods.Title;
            data.nowprice = goods.Nowprice;
            data.originalprice = goods.OriginalPrice;
            data.sales = goods.Sales;
            data.tag = goods.Tag;
            data.content = Utility.GetNoHtmlStr(goods.Content);
            if (favorite != null && favorite.GidList.Contains(goods.Id))
                data.isfav = 1;
            data.favcount = goods.FavCount;
            data.sharecount = goods.ShareCount;
            data.cid = cid;
            if (gcategories != null)
                data.cname = gcategories.Name;

            //浏览次数加一
            goods.BrowseCount++;
            GoodsHelper.SaveGoods(goods);

            //返回信息
            ReturnCorrectData(data);
        }
        #endregion

        #region 获取商品评论列表 2.3
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
            public int dateline { get; set; }
            public string message { get; set; }

            public CommentItem()
            {
                avatar = username = message = "";
                dateline = DateTime.MinValue.GetUnixTime();
            }
        }
        public void GetGoodsComments(HttpContext context)
        {
            int start = GetInt("start");
            int limit = GetInt("limit");
            int gid = GetInt("gid");

            int totalcount = 0;
            int utotalcount;
            var goods = GoodsHelper.GetGoods(gid);
            if (goods == null)
            {
                ReturnErrorMsg("参数有误");
                return;
            }
            int sellerId = goods.SellerId;
            var commentResult = CommentHelper.GetPagings(sellerId, CommentType.Goods, gid, start * limit, limit);
            var commentlist = commentResult.Results;
            string wheresql = Utility.GetWhereSql(commentlist.Select(o => o.UserId).ToList());
            var userlist = AccountHelper.GetUserList(wheresql, "", start * limit, limit).Results;

            var data = new CommentResponse();
            data.commentnum = commentResult.TotalCount;
            foreach (var comment in commentlist)
            {
                var item = new CommentItem();
                item.dateline = comment.CreateTime.GetUnixTime();
                item.message = comment.Content;

                var user = userlist.FirstOrDefault(o => o.Id == comment.UserId);
                if (user != null)
                {
                    item.avatar = Utility.GetSizePicUrl(user.Avatar, 100, 100, context);
                    item.username = user.UserName;
                    item.sex = (int)user.Sex;
                }

                data.comments.Add(item);
            }

            //返回信息
            ReturnCorrectData(data);
        }
        #endregion

        #region 发表商品评论 2.4
        public void AddGoodsComment()
        {
            int uid = GetInt("uid");
            int gid = GetInt("gid");
            string message = GetString("message");

            var user = AccountHelper.GetUser(uid);
            if (user == null)
            {
                ReturnErrorMsg(string.Format("不存在Id={0}的用户", uid));
                return;
            }

            //评论次数加一
            var goods = GoodsHelper.GetGoods(gid);
            goods.CommentCount++;
            GoodsHelper.SaveGoods(goods);

            var comment = new Comment();
            comment.Content = message;
            comment.CreateTime = DateTime.Now;
            comment.SellerId = goods.SellerId;
            comment.Type = CommentType.Goods;
            comment.TypeId = gid;
            comment.UserId = uid;
            //冗余两个字段
            comment.Img = goods.LogoUrl;
            comment.Title = goods.Title;

            //发表商品评论
            CommentHelper.Create(comment);

            ExtcreditLog log = new ExtcreditLog();
            if (!ExtcreditLogHelper.JudgeExtcreditGet(ExtcreditSourceType.CommentGoods, gid, uid))
            {
                var setting = SystemHelper.GetMerchantExtend(user.SellerId);
                //积分获得
                log.UserId = uid;
                log.SellerId = user.SellerId;
                log.SourceId = gid;
                log.Extcredit = setting != null ? setting.CommentIntegral : 0;
                log.Type = ExtcreditSourceType.CommentGoods;
                log.CreateTime = DateTime.Now;

                ExtcreditLogHelper.AddExtcreditLog(log);

                user.Integral += log.Extcredit;
                AccountHelper.SaveAccount(user);
            }

            //返回信息
            ReturnCorrectData(new ApiUserHandler.IntegralData(log.Extcredit));
        }
        #endregion

        #region 收藏/取消收藏商品 2.5
        public void FavGoods()
        {
            int uid = GetInt("uid");
            int gid = GetInt("gid");
            int isfav = GetInt("isfav");//0:取消收藏，1:收藏，其他参数一律报错！

            if (isfav != 0 && isfav != 1)
            {
                ReturnErrorMsg("传参出错");
                return;
            }

            var goods = GoodsHelper.GetGoods(gid);
            var favorite = FavoriteHelper.GetFavorite(uid);
            if (isfav == 0 && !favorite.GidList.Contains(gid))
            {
                ReturnErrorMsg("没有收藏过该商品");
                return;
            }
            if (isfav == 1 && favorite.GidList.Contains(gid))
            {
                ReturnErrorMsg("已收藏过该商品");
                return;
            }
            if (isfav == 0)
            {//取消收藏
                goods.FavCount--;
                favorite.GidList.Remove(gid);
            }
            else if (isfav == 1)
            {//收藏
                goods.FavCount++;
                favorite.GidList.Add(gid);
            }

            //保存商品
            GoodsHelper.SaveGoods(goods);
            //保存收藏
            FavoriteHelper.SaveFavorite(favorite);
            //返回
            if (isfav == 0)
                ReturnCorrectMsg("取消收藏成功");
            else if (isfav == 1)
                ReturnCorrectMsg("收藏成功");
        }
        #endregion

        #region 商品/图片墙/活动分享 2.6
        public void ShareGoods()
        {
            int uid = GetInt("uid");
            int typeId = GetInt("typeid");
            var type = (ExtcreditSourceType)GetInt("type");
            var platform = (PlatformType)GetInt("platform");
            var content = GetString("content");

            var user = AccountHelper.GetUser(uid);
            if (user == null)
            {
                ReturnErrorMsg(string.Format("不存在Id={0}的用户", uid));
                return;
            }
            if (user.SellerId <= 0)
            {
                ReturnErrorMsg("此用户没有有商户");
                return;
            }

            if (type == ExtcreditSourceType.ShareGoods)
            {
                var goods = GoodsHelper.GetGoods(typeId);
                goods.ShareCount++;

                //保存商品
                GoodsHelper.SaveGoods(goods);
            }
            else if (type == ExtcreditSourceType.ShareActive)
            {
                //TODO:
            }
            else if (type == ExtcreditSourceType.ShareImg)
            {
                //TODO:
            }

            ExtcreditLog log = new ExtcreditLog();
            if (!ExtcreditLogHelper.JudgeExtcreditGet(type, typeId, uid, platform))
            {
                var setting = SystemHelper.GetMerchantExtend(user.SellerId);
                //积分获得
                log.UserId = uid;
                log.SellerId = user.SellerId;
                log.SourceId = typeId;
                log.Extcredit = setting != null ? setting.ShareIntegral : 0;
                log.Type = type;
                log.PlatformType = platform;

                ExtcreditLogHelper.AddExtcreditLog(log);

                user.Integral += log.Extcredit;
                AccountHelper.SaveAccount(user);
            }

            ShareLog shareLog = new ShareLog();
            shareLog.UserId = uid;
            shareLog.Type = (int)type;
            shareLog.TypeId = typeId;
            shareLog.Content = content;//记录分享内容
            ShareLogHelper.AddShareLog(shareLog);

            //返回信息
            ReturnCorrectData(new ApiUserHandler.IntegralData(log.Extcredit));
        }
        #endregion

        #region 添加产品到购物车 6.1
        public void AddShoppingCart()
        {
            var uid = GetInt("uid");
            var gid = GetInt("gid");
            var num = GetInt("num");

            var goods = GoodsHelper.GetGoods(gid);
            if (goods == null)
            {
                ReturnErrorMsg("商品不存在");
                return;
            }

            var shoppingcart = ShoppingCartHelper.GetShoppingCartByGid(uid, gid);
            if (shoppingcart == null) shoppingcart = new ShoppingCart();
            shoppingcart.UserId = uid;
            shoppingcart.Gid = gid;
            shoppingcart.Num += num;
            //shoppingcart.Img = goods.LogoUrl;
            //shoppingcart.Nowprice = goods.Nowprice;
            //shoppingcart.OriginalPrice = goods.OriginalPrice;
            //shoppingcart.Title = goods.Title;
            //shoppingcart.Description = goods.Content;
            shoppingcart.CreateTime = DateTime.Now;

            //保存订单
            ShoppingCartHelper.SaveShoppingCart(shoppingcart);

            //返回
            ReturnCorrectMsg("添加成功");
        }
        #endregion

        #region 获取购物车列表 6.2
        public class ShoppingCartData
        {
            public float totalprice { get; set; }
            public List<ShoppingCartItem> shoppingcartlist { get; set; }
            public int totalnum { get; set; }
            public ShoppingCartData()
            {
                shoppingcartlist = new List<ShoppingCartItem>();
            }
        }
        public class ShoppingCartItem
        {
            public int gid { get; set; }
            public int num { get; set; }
            public float totalprice { get; set; }
            public string img { get; set; }
            public string title { get; set; }
            public string content { get; set; }
            public float nowprice { get; set; }
            public float originalprice { get; set; }
        }
        public void GetShoppingCartList(HttpContext context)
        {
            int uid = GetInt("uid");

            var user = AccountHelper.GetUser(uid);
            if (user == null)
            {
                ReturnErrorMsg(string.Format("不存在Id={0}的用户", uid));
                return;
            }
            if (user.SellerId == 0)
            {
                ReturnErrorMsg("此用户不属于任何商户");
                return;
            }

            var wheresql = string.Format(" where UserId = {0} ", uid);
            var list = ShoppingCartHelper.GetShoppingCartList(wheresql).Results;
            if (list.Count > 0)
                wheresql = string.Format(" and a.Id in({0}) ",
                    Utility.GetString(list.Select(o => o.Gid).Distinct().ToList()));
            else wheresql = string.Empty;
            var glist = GoodsHelper.GetGoodsList(user.SellerId, wheresql).Results;

            var data = new ShoppingCartData();
            foreach (var shoppingCart in list)
            {
                var goods = glist.FirstOrDefault(o => o.Id == shoppingCart.Gid);
                if (goods != null)
                {
                    var item = new ShoppingCartItem();
                    item.gid = shoppingCart.Gid;
                    item.num = shoppingCart.Num;

                    item.nowprice = goods.Nowprice;
                    item.originalprice = goods.OriginalPrice;
                    item.title = goods.Title;
                    item.content = goods.Content;
                    item.img = Utility.GetSizePicUrl(goods.LogoUrl, 180, 133, context);

                    item.totalprice = goods.Nowprice * shoppingCart.Num;

                    data.totalnum += item.num;
                    data.shoppingcartlist.Add(item);
                    data.totalprice += item.totalprice;
                }
            }

            //返回信息
            ReturnCorrectData(data);
        }
        #endregion

        #region 添加订单 6.3
        public class AddOrdersData
        {
            public int orderid { get; set; }
        }
        public void AddOrders()
        {
            var uid = GetInt("uid");
            var sellerId = GetInt("sellerid");
            var gids = GetString("gids");
            var nums = GetString("nums");

            var user = AccountHelper.GetUser(uid);
            if (user == null)
            {
                ReturnErrorMsg(string.Format("不存在Id={0}的用户", uid));
                return;
            }

            var gidlist = Utility.GetListint(gids);
            var numlist = Utility.GetListint(nums);
            if (gidlist.Count != numlist.Count || gidlist.Count == 0)
            {
                ReturnErrorMsg("参数错误");
                return;
            }
            var goodslist = GoodsHelper.GetGoodsList(sellerId, string.Format(" and a.Id in({0}) ", gids)).Results;
            if (goodslist.Count == 0)
            {
                ReturnErrorMsg("找不到添加的商品");
                return;
            }
            var orders = new Orders();
            orders.UserId = uid;
            foreach (var goods in goodslist)
            {
                orders.GidList.Add(goods.Id);
                orders.ImgList.Add(goods.LogoUrl);
                orders.TitleList.Add(goods.Title);
                var html = Utility.GetNoHtmlStr(goods.Content);
                html = html.Length > 50 ? html.Substring(0, 50) : html;
                orders.ContentList.Add(html);
                orders.NowPriceList.Add(goods.Nowprice);
                orders.OriginalPriceList.Add(goods.OriginalPrice);
                var num = Utility.GetValueByList(gidlist, numlist, goods.Id);
                orders.NumList.Add(num);

                orders.StotalPrice += goods.Nowprice * num;

                //初始化订单 收货信息
                orders.LinkMan = user.LinkMan;
                orders.Mobile = user.Phone;
                orders.Address = user.Address;
            }
            orders.TotalPrice = (float)(orders.StotalPrice * 1.0 * user.Discount / 10);//打折！

            orders.Discount = user.Discount;
            orders.SendPrice = 0;
            orders.FreeSendPrice = 100;
            //orders.SendPrice = 5;

            orders.SellerId = sellerId;
            var merchant = MerchantHelper.GetMerchant(orders.SellerId);
            orders.HasDelivery = 0;
            if (merchant != null)
            {
                //orders.SendPrice = merchant.Freight;
                orders.FreeSendPrice = merchant.NeedToFreeFreight;
                orders.HasDelivery = merchant.HasDelivery;
            }

            var orderid = OrdersHelper.SaveOrders(orders);
            if (orderid == 0)
            {
                ReturnErrorMsg("生成订单失败");
                return;
            }
            //删除购物车列表
            ShoppingCartHelper.DeleteShoppingCartByGid(uid, gids);

            var data = new AddOrdersData();
            data.orderid = orderid;

            //返回信息
            ReturnCorrectData(data);
        }
        #endregion

        #region 获取订单详情 6.4
        public class OrderDetailData
        {
            public int orderid { get; set; }
            public int ordertime { get; set; }
            public int ordertype { get; set; }
            public int orderpeople { get; set; }
            public int status { get; set; }
            public int totalnum { get; set; }
            public float sendprice { get; set; }//送餐费
            public float freesendprice { get; set; }//免费送餐价格
            public float totalprice { get; set; }//实际应付
            public int extcredit { get; set; }//可获积分
            public int couponid { get; set; }//优惠券id
            public string coupontitle { get; set; }//优惠券名称
            public string ccontent { get; set; }//优惠券说明
            public float stotalprice { get; set; }//合计（商品总计）
            public string remark { get; set; }//订单备注
            public int createtime { get; set; }
            public string address { get; set; }
            public string mobile { get; set; }
            public string linkman { get; set; }
            public int pid { get; set; }
            public float discount { get; set; }
            public string boxno { get; set; }//包厢名称+包厢类型
            public List<OrderGoddsItem> goodslist { get; set; }
            public int hasdelivery { get; set; }

            public OrderDetailData()
            {
                goodslist = new List<OrderGoddsItem>();
            }

            public OrderDetailData(Orders orders, HttpContext context)
            {
                goodslist = new List<OrderGoddsItem>();
                var gidlist = orders.GidList;
                var numlist = orders.NumList;
                var titlelist = orders.TitleList;
                var imglist = orders.ImgList;
                var originalpricelist = orders.OriginalPriceList;
                var nowpricelist = orders.NowPriceList;
                var contentlist = orders.ContentList;

                for (int i = 0; i < gidlist.Count; i++)
                {
                    var item = new OrderGoddsItem();
                    item.img = Utility.GetSizePicUrl(imglist[i], 180, 133, context);
                    item.gid = gidlist[i];
                    item.title = titlelist[i];
                    item.content = contentlist[i];
                    item.nowprice = nowpricelist[i];
                    item.originalprice = originalpricelist[i];
                    item.num = numlist[i];
                    item.totalprice = item.nowprice * item.num;
                    totalnum += item.num;
                    goodslist.Add(item);
                }

                orderid = orders.Id;
                ordertime = orders.OrderTime.GetUnixTime();
                orderpeople = orders.OrderPeople;
                ordertype = (int)orders.OrderType;
                status = (int)orders.Status;
                sendprice = orders.SendPrice;
                freesendprice = orders.FreeSendPrice;
                hasdelivery = orders.HasDelivery;
                //var merchant = MerchantHelper.GetMerchant(orders.SellerId);
                //hasdelivery = 0;
                //if (merchant != null && orders.Status < OrderStatus.Pay)
                //{
                //    sendprice = merchant.Freight;//订单还未付款前 统一下发商户的运费信息
                ////    freesendprice = merchant.NeedToFreeFreight;
                ////    hasdelivery = merchant.HasDelivery;
                //}

                var setting = SystemHelper.GetMerchantExtend(orders.SellerId);
                totalprice = orders.TotalPrice;
                extcredit = (int)(orders.TotalPrice * 1.0 * (setting != null ? setting.ConsumeIntegral:0));
                couponid = orders.CouponId;
                coupontitle = orders.CouponTitle;
                if (string.IsNullOrEmpty(coupontitle))
                {
                    var coupon = CouponHelper.GetCouponIngronStatus(orders.CouponId, orders.UserId, orders.SellerId);
                    if (coupon != null)
                        coupontitle = string.Format("满{0}减{1}元电子券", coupon.FullMoney, coupon.DiscountMoney);
                }
                ccontent = orders.Ccontent;
                stotalprice = orders.StotalPrice;
                remark = orders.Remark;
                createtime = orders.CreateTime.GetUnixTime();
                address = orders.Address;
                mobile = orders.Mobile;
                linkman = orders.LinkMan;
                pid = orders.Pid;
                discount = orders.Discount;
                boxno = orders.Boxno;
            }
        }
        public class OrderGoddsItem
        {
            public int gid { get; set; }
            public int num { get; set; }
            public string title { get; set; }
            public string img { get; set; }
            public float nowprice { get; set; }
            public float originalprice { get; set; }
            public float totalprice { get; set; }
            public string content { get; set; }
        }
        public void GetOrdersDetail(HttpContext context)
        {
            var uid = GetInt("uid");
            var orderId = GetInt("orderid");

            var orders = OrdersHelper.GetOrders(orderId, uid);

            if (orders == null)
            {
                ReturnErrorMsg("不存在该订单");
                return;
            }

            var data = new OrderDetailData(orders, context);

            //返回信息
            ReturnCorrectData(data);
        }
        #endregion

        #region 获取支付方式列表 6.5
        public class PaymentData
        {
            public List<PaymentItem> paymentlist { get; set; }

            public PaymentData()
            {
                paymentlist = new List<PaymentItem>();
            }
        }
        public class PaymentItem
        {
            public int pid { get; set; }
            public string name { get; set; }
            public string description { get; set; }
        }
        public void GetPaymentList()
        {
            var sellerId = GetInt("sellerid");

            var data = new PaymentData();
            var list = PaymentHelper.GetList();
            foreach (var payment in list)
            {
                var item = new PaymentItem();
                item.pid = payment.Id;
                item.name = payment.Name;
                item.description = payment.Description;

                data.paymentlist.Add(item);
            }

            //返回信息
            ReturnCorrectData(data);
        }
        #endregion

        #region 更新订单 6.6
        public void UpdateOrders(HttpContext context)
        {
            var ordertime = GetTime("ordertime");
            var orderpeople = GetInt("orderpeople");
            var ordertype = GetInt("ordertype");
            var couponid = GetInt("couponid");
            var address = GetString("address");
            var linkman = GetString("linkman");
            var phone = GetString("phone");
            var pid = GetInt("pid");
            var remark = GetString("remark");
            var uid = GetInt("uid");
            var orderId = GetInt("orderid");
            var boxno = GetString("boxno");

            var orders = OrdersHelper.GetOrders(orderId, uid);

            var user = AccountHelper.GetUser(uid);
            if (user == null)
            {
                ReturnErrorMsg(string.Format("不存在Id={0}的用户", uid));
                return;
            }

            if (orders == null)
            {
                ReturnErrorMsg("不存在该用户的该订单");
                return;
            }
            var merchant = MerchantHelper.GetMerchant(orders.SellerId);
            if (merchant == null)
            {
                ReturnErrorMsg("商户不存在");
                return;
            }
            var payMent = PaymentHelper.GetPayment(pid);
            if (payMent == null)
            {
                ReturnErrorMsg("不存在该充值类型");
                return;
            }
            if (orders.Status > OrderStatus.Update)
            {
                ReturnErrorMsg("该订单已付款或已完结");
                return;
            }

            if (ordertime != default(DateTime)) orders.OrderTime = ordertime;
            orders.OrderType = (OrderType)ordertype;

            if (orders.OrderType != OrderType.Shop && merchant.HasDelivery == 0)
            {
                ReturnErrorMsg("该商户不支持配送");
                return;
            }

            orders.TotalPrice -= orders.SendPrice;
            if (orders.OrderType == OrderType.Shop)
            {
                orders.SendPrice = 0;
            }
            else
            {
                if (orders.TotalPrice >= orders.FreeSendPrice)
                    orders.SendPrice = 0;   //  满多少免运费
                else
                {
                    orders.SendPrice = merchant.Freight;
                    orders.TotalPrice += merchant.Freight;
                }
            }
            if (orderpeople != 0) orders.OrderPeople = orderpeople;
            if (!string.IsNullOrEmpty(address)) orders.Address = address;
            if (!string.IsNullOrEmpty(linkman)) orders.LinkMan = linkman;
            if (!string.IsNullOrEmpty(phone)) orders.Mobile = phone;
            orders.Boxno = boxno;//添加包厢号（夜场）
            float discount = 0;
            if (couponid != 0)
                orders.CouponId = couponid;


            orders.CouponId = couponid;
            if (orders.CouponId > 0)
            {
                var coupon = CouponHelper.GetCoupon(orders.CouponId, uid, user.SellerId);
                if (coupon == null)
                {
                    ReturnErrorMsg("未找到相应的优惠券或优惠券已被使用了");
                    return;
                }
                bool ifdiscount = true;
                var gidlist = orders.GidList;
                foreach (var i in gidlist)
                {
                    if (coupon.GoodsIds.Contains(i))
                        ifdiscount = false;
                }
                if (ifdiscount)
                {
                    //discount = (float)(coupon.Extcredit * 1.0) / 100;
                    if (orders.TotalPrice >= coupon.FullMoney)
                        discount = coupon.DiscountMoney;
                    orders.Ccontent = coupon.Description;
                    //string.Format("满{0}减{1}元电子券", coupon.FullMoney, coupon.DiscountMoney);
                }
                coupon.UsedTimes++;
                CouponHelper.Update(coupon);
                CouponHelper.UpdateUserCouponStatus(couponid, 1); //更新优惠券已使用

                orders.TotalPrice -= discount;
                orders.CtotalPrice = discount;
                orders.CouponTitle = coupon.Title;
                if (string.IsNullOrEmpty(orders.CouponTitle))
                    orders.CouponTitle = string.Format("满{0}减{1}元电子券", coupon.FullMoney, coupon.DiscountMoney);
                if (orders.TotalPrice < 0) orders.TotalPrice = 0;
            }

            orders.Pid = pid;
            if (!string.IsNullOrEmpty(remark)) orders.Remark = remark;
            orders.Status = OrderStatus.Update;

            OrdersHelper.SaveOrders(orders);

            var data = new OrderDetailData(orders, context);

            //返回信息
            ReturnCorrectData(data);
            //ReturnCorrectMsg("更新成功");
        }
        #endregion

        #region 更新订单状态 6.7
        public void UpdateOrdersStatus()
        {
            var uid = GetInt("uid");
            var orderId = GetInt("orderid");
            var status = GetInt("status");

            var user = AccountHelper.GetUser(uid);
            if (user == null)
            {
                ReturnErrorMsg(string.Format("不存在Id={0}的用户", uid));
                return;
            }

            var orders = OrdersHelper.GetOrders(orderId, uid);

            if (orders == null || (status > 0 && ((int)orders.Status + 1) != status))
            {
                ReturnErrorMsg("参数出错");
                return;
            }
            if (orders.UserId != uid)
            {
                ReturnErrorMsg("订单不属于该用户");
                return;
            }
            orders.Status = (OrderStatus)status;

            var log = new ExtcreditLog();
            if (orders.Status == OrderStatus.Pay)
            {
                if (orders.Pid == 1)
                {//余额付款
                    if (user.Money < orders.TotalPrice)
                    {
                        ReturnErrorMsg("余额不足");
                        return;
                    }
                    user.Concume(orders.TotalPrice);
                    //user.Money -= orders.TotalPrice;
                    //user.TotalConsume += orders.TotalPrice;
                    //user.TotalOrdersCount++;//完成付款的订单数
                }
                else
                {
                    ReturnErrorMsg("不是通过此接口改变订单状态为已付款（非账户余额付款）");
                    return;
                }

                var payMent = new Payment();
                if (orders.Pid > 0)
                    PaymentHelper.GetPayment(orders.Pid);

                var chargeLog = new ChargeLog();
                chargeLog.UserId = uid;
                chargeLog.Money = -orders.TotalPrice;
                chargeLog.Pid = orders.Pid;
                chargeLog.SellerId = orders.SellerId;
                chargeLog.OrderId = orders.Id.ToString();
                chargeLog.PayName = payMent.Id == 0 ? "账户余额" : payMent.Name;
                chargeLog.Status = RechargeStatus.Success;
                chargeLog.GidList = orders.GidList;
                chargeLog.NumList = orders.NumList;
                chargeLog.Num = orders.NumList.Sum(o => o);
                //记录消费记录
                ChargeLogHelper.AddChargeLog(chargeLog);

                //积分获得
                var setting = SystemHelper.GetMerchantExtend(user.SellerId);
                log.UserId = uid;
                log.SellerId = user.SellerId;
                log.SourceId = orders.Id;
                log.Extcredit = (int)(orders.TotalPrice * 1.0 / (setting != null ? setting.ConsumeIntegral : 0));
                log.Type = ExtcreditSourceType.Consume;
                log.CreateTime = DateTime.Now;

                ExtcreditLogHelper.AddExtcreditLog(log);

                user.Integral += log.Extcredit;

                //保存用户信息
                AccountHelper.SaveAccount(user);

                //更新订单中商品的销量
                GoodsHelper.UpdateGoodsSales(orders.GidList, orders.NumList);
            }
            else if (orders.Status == OrderStatus.Cancel)
            {//取消订单——返回优惠券
                CouponHelper.UpdateUserCouponStatus(orders.CouponId, 0); //更新优惠券未使用
            }

            OrdersHelper.SaveOrders(orders);

            //返回信息
            ReturnCorrectData(new ApiUserHandler.IntegralData(log.Extcredit));
        }
        #endregion

        #region 删除购物车 6.8
        public void DelShoppingCart()
        {
            var uid = GetInt("uid");
            var gids = GetString("gids");

            //var goods = GoodsHelper.GetGoods(gid);
            //if (goods == null)
            //{
            //    ReturnErrorMsg("商品不存在");
            //    return;
            //}
            var gidList = Utility.GetListint(gids);
            if (gidList.Count == 0)
            {
                ReturnErrorMsg("参数有误，没有商品id");
                return;
            }
            var list = ShoppingCartHelper.GetList(uid, gids);
            if (list.Count != gidList.Count)
            {
                ReturnErrorMsg("不存在该商品的购物车");
                return;
            }
            //批量删除购物车
            ShoppingCartHelper.DeleteShoppingCartByGid(uid, gids);

            //返回
            ReturnCorrectMsg("删除购物车成功");
        }
        #endregion
    }
}