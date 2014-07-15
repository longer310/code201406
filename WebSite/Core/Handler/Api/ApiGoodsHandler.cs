using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Web;
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
                #endregion

                #region 订单
                case "addshoppingcart"://添加产品到购物车
                    AddShoppingCart();
                    break;
                case "getshoppingcartlist"://获取购物车列表
                    GetShoppingCartList();
                    break;
                case "getpaymentlist"://获取支付方式列表
                    GetPaymentList();
                    break;
                case "addorders"://添加订单
                    AddOrders();
                    break;
                case "getordersdetail"://获取订单详情
                    GetOrdersDetail();
                    break;
                case "updateorders"://更新订单
                    UpdateOrders();
                    break;
                case "updateordersstatus"://更新订单状态
                    UpdateOrdersStatus();
                    break;
                #endregion

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
            var gads = GoodsHelper.GetGoodsList(sellerid, out totalnum, "", "", 0, 0, 5);
            foreach (var gad in gads)
            {
                var s = new TSlideItem();
                s.img = gad.LogoUrl;
                s.title = gad.Title;
                s.type = (int)CommentType.Goods;
                s.typeid = gad.Id;
                s.createtime = gad.CreateTime.GetUnixTime();

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
                s.createtime = aad.CreateTime.GetUnixTime();

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
                s.createtime = pad.CreateTime.GetUnixTime();

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
            var glist = GoodsHelper.GetGoodsList(sellerid, out totalcount, " and IsHot = 1 ", "", 0, 0, 8);
            foreach (var gl in glist)
            {
                data.hots.Add(new HotItem() { img = gl.LogoUrl, gid = gl.Id });
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
            string shoppingcartql = "";
            if (cid > 0) wheresql += string.Format(" and Cid={0}", cid);
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
            }

            //组装下发数据
            int totalcount;
            int totalccount;
            var user = AccountHelper.GetCurUser();
            var goodslist = GoodsHelper.GetGoodsList(sellerid, out totalcount, wheresql, shoppingcartql, 0, start * limit, limit);
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
            string wheresql = Utility.GetWhereSql(goods.ImgIdList);
            var piclist = SourceMaterialHelper.GetList(0, 0, wheresql, "");
            var user = AccountHelper.GetCurUser();
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
            public int dateline { get; set; }
            public string message { get; set; }

            public CommentItem()
            {
                avatar = username = message = "";
                dateline = DateTime.MinValue.GetUnixTime();
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
            if (goods == null)
            {
                ReturnErrorMsg("参数有误");
                return;
            }
            int sellerId = goods.SellerId;
            var commentResult = CommentHelper.GetPagings(sellerId, CommentType.Goods, gid, start * limit, limit);
            var commentlist = commentResult.Results;
            string wheresql = Utility.GetWhereSql(commentlist.Select(o => o.UserId).ToList());
            var userlist = AccountHelper.GetUserList(out utotalcount, wheresql, "", start * limit, limit);

            var data = new CommentResponse();
            data.commentnum = totalcount;
            foreach (var comment in commentlist)
            {
                var item = new CommentItem();
                item.dateline = comment.CreateTime.GetUnixTime();
                item.message = comment.Content;

                var user = userlist.FirstOrDefault(o => o.Id == comment.UserId);
                if (user != null)
                {
                    item.avatar = user.Avatar;
                    item.username = user.UserName;
                    item.sex = (int)user.Sex;
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
            ReturnCorrectMsg("发表成功");
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
            ReturnCorrectMsg("收藏成功");
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
            ReturnCorrectMsg("分享成功");
        }
        #endregion

        #region 添加产品到购物车
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

        #region 获取购物车列表
        public class ShoppingCartData
        {
            public float totalprice { get; set; }
            public List<ShoppingCartItem> shoppingcartlist { get; set; }
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
            public string description { get; set; }
            public float nowprice { get; set; }
            public float originalprice { get; set; }
        }
        public void GetShoppingCartList()
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

            var wheresql = string.Format(" where UserId = {0}", uid);
            int totalcount;
            var list = ShoppingCartHelper.GetShoppingCartList(out totalcount, wheresql, "", 0);
            wheresql = Utility.GetWhereSql(list.Select(o => o.Id).ToList());
            var glist = GoodsHelper.GetGoodsList(user.SellerId, out totalcount, wheresql, "", 0);

            var data = new ShoppingCartData();
            foreach (var shoppingCart in list)
            {
                var item = new ShoppingCartItem();
                item.gid = shoppingCart.Gid;
                item.num = shoppingCart.Num;

                var goods = glist.FirstOrDefault(o => o.Id == shoppingCart.Gid);
                if (goods != null)
                {
                    item.nowprice           = goods.Nowprice;
                    item.originalprice      = goods.OriginalPrice;
                    item.title              = goods.Title;
                    item.description        = goods.Content;
                    item.img                = goods.LogoUrl;

                    item.totalprice = goods.Nowprice * shoppingCart.Num;

                    data.shoppingcartlist.Add(item);
                    data.totalprice += item.totalprice;
                }
            }

            JsonTransfer jt = new JsonTransfer();
            jt.AddSuccessParam();
            jt.Add("data", data);
            Response.Write(DesEncrypt(jt));
            Response.End();
        }
        #endregion

        #region 获取支付方式列表
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
            var list = PaymentHelper.GetList(sellerId);
            foreach (var payment in list)
            {
                var item = new PaymentItem();
                item.pid = payment.Id;
                item.name = payment.Name;
                item.description = payment.Description;

                data.paymentlist.Add(item);
            }

            JsonTransfer jt = new JsonTransfer();
            jt.AddSuccessParam();
            jt.Add("data", data);
            Response.Write(DesEncrypt(jt));
            Response.End();
        }
        #endregion

        #region 添加订单
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

            var gidlist = Utility.GetListint(gids);
            var numlist = Utility.GetListint(nums);
            if (gidlist.Count != numlist.Count)
            {
                ReturnErrorMsg("参数错误");
                return;
            }
            int totalcount;
            var goodslist = GoodsHelper.GetGoodsList(sellerId, out totalcount, string.Format(" and a.Id in({0}) ", gids),
                "", 0);
            var orders = new Orders();
            orders.UserId = uid;
            foreach (var goods in goodslist)
            {
                orders.Gids += goods.Id + ",";
                orders.Imgs += goods.LogoUrl + ",";
                orders.Titles += goods.Title + ",";
                orders.NowPrices += goods.Nowprice + ",";
                orders.OriginalPrices += goods.OriginalPrice + ",";
                var num = Utility.GetValueByList(gidlist, numlist, goods.Id);
                orders.Nums += num + ",";

                orders.StotalPrice += goods.Nowprice * num;
            }
            orders.Imgs = orders.Imgs.TrimEnd(',');
            orders.Titles = orders.Titles.TrimEnd(',');
            orders.NowPrices = orders.NowPrices.TrimEnd(',');
            orders.OriginalPrices = orders.OriginalPrices.TrimEnd(',');
            orders.Gids = orders.Gids.TrimEnd(',');
            orders.Nums = orders.Nums.TrimEnd(',');
            orders.TotalPrice = orders.StotalPrice;
            orders.SellerId = sellerId;

            var orderid = OrdersHelper.SaveOrders(orders);
            if (orderid == 0)
            {
                ReturnErrorMsg("生成订单失败");
                return;
            }
            //删除购物车列表
            ShoppingCartHelper.DeleteShoppingCartByGid(gids);

            var data = new AddOrdersData();
            data.orderid = orderid;

            JsonTransfer jt = new JsonTransfer();
            jt.AddSuccessParam();
            jt.Add("data", data);
            Response.Write(DesEncrypt(jt));
            Response.End();
        }
        #endregion

        #region 获取订单详情
        public class OrderDetailData
        {
            public int orderid { get; set; }
            public float totalprice { get; set; }
            public float stotalprice { get; set; }
            public int pid { get; set; }
            public int ordertime { get; set; }
            public int ordertype { get; set; }
            public int orderpeople { get; set; }
            public int couponid { get; set; }
            public float ctotalprice { get; set; }
            public int createtime { get; set; }
            public string address { get; set; }
            public string mobile { get; set; }
            public string linkman { get; set; }
            public int status { get; set; }

            public List<OrderGoddsItem> goodslist { get; set; }

            public OrderDetailData()
            {
                goodslist = new List<OrderGoddsItem>();
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
        }
        public void GetOrdersDetail()
        {
            var uid = GetInt("uid");
            var orderId = GetInt("orderid");

            var orders = OrdersHelper.GetOrders(orderId, uid);

            if (orders == null)
            {
                ReturnErrorMsg("参数出错");
                return;
            }

            var gidlist = Utility.GetListint(orders.Gids);
            var numlist = Utility.GetListint(orders.Nums);
            var titlelist = Utility.GetListstring(orders.Titles);
            var imglist = Utility.GetListstring(orders.Imgs);
            var originalpricelist = Utility.GetListfloat(orders.OriginalPrices);
            var nowpricelist = Utility.GetListfloat(orders.NowPrices);

            var data = new OrderDetailData();
            for (int i = 0; i < gidlist.Count; i++)
            {
                var item = new OrderGoddsItem();
                item.gid = gidlist[i];
                item.num = numlist[i];
                item.title = titlelist[i];
                item.img = imglist[i];
                item.nowprice = nowpricelist[i];
                item.originalprice = originalpricelist[i];
                item.totalprice = item.nowprice * item.num;

                data.goodslist.Add(item);
            }

            data.orderid = orders.Id;
            data.totalprice = orders.TotalPrice;
            data.stotalprice = orders.StotalPrice;
            data.pid = orders.Pid;
            data.ordertime = orders.OrderTime.GetUnixTime();
            data.orderpeople = orders.OrderPeople;
            data.ordertype = (int)orders.OrderType;
            data.couponid = orders.CouponId;
            data.ctotalprice = orders.CtotalPrice;
            data.address = orders.Address;
            data.linkman = orders.LinkMan;
            data.mobile = orders.Mobile;
            data.createtime = orders.CreateTime.GetUnixTime();
            data.status = (int)orders.Status;

            JsonTransfer jt = new JsonTransfer();
            jt.AddSuccessParam();
            jt.Add("data", data);
            Response.Write(DesEncrypt(jt));
            Response.End();
        }
        #endregion

        #region 更新订单
        public void UpdateOrders()
        {
            var ordertime = GetTime("ordertime");
            var orderpeople = GetInt("orderpeople");
            var ordertype = GetInt("ordertype");
            var couponid = GetInt("couponid");
            var address = GetString("address");
            var linkman = GetString("linkman");
            var mobile = GetString("mobile");
            var pid = GetInt("pid");
            var remark = GetString("remark");
            var uid = GetInt("uid");
            var orderId = GetInt("orderid");

            var orders = OrdersHelper.GetOrders(orderId, uid);

            if (orders == null)
            {
                ReturnErrorMsg("参数出错");
                return;
            }

            var clist = PaymentHelper.GetList(orders.SellerId);
            if (clist == null)
            {
                ReturnErrorMsg("商户还没有充值类型列表");
                return;
            }
            var payMent = clist.FirstOrDefault(o => o.Id == pid);
            if (payMent == null)
            {
                ReturnErrorMsg("不存在该充值类型");
                return;
            }

            orders.OrderTime = ordertime;
            orders.OrderType = (OrderType)ordertype;
            orders.OrderPeople = orderpeople;
            orders.Address = address;
            orders.LinkMan = linkman;
            orders.Mobile = mobile;
            orders.CouponId = couponid;
            //获取优惠券优惠的价格
            var coupon = CouponHelper.GetItem(orders.CouponId);
            bool ifdiscount = coupon == null ? false : true;
            if (coupon != null)
            {//判断是否是优惠产品
                var gidlist = Utility.GetListint(orders.Gids);
                foreach (var i in gidlist)
                {
                    if (coupon.GoodsIds.Contains(i))
                        ifdiscount = false;
                }
            }
            float discount = 0;
            if (ifdiscount)
            {
                discount = (float)(coupon.Extcredit * 1.0) / 100;
            }
            orders.TotalPrice -= discount;
            orders.CtotalPrice = discount;
            if (orders.TotalPrice < 0) orders.TotalPrice = 0;
            orders.Pid = pid;
            orders.Remark = remark;
            orders.Status++;

            OrdersHelper.SaveOrders(orders);

            ReturnCorrectMsg("更新成功");
        }
        #endregion

        #region 更新订单状态
        public void UpdateOrdersStatus()
        {
            var uid = GetInt("uid");
            var orderId = GetInt("orderid");
            var status = GetInt("status");

            var orders = OrdersHelper.GetOrders(orderId, uid);

            if (orders == null || status <= 1 || ((int)orders.Status + 1) != status)
            {
                ReturnErrorMsg("参数出错");
                return;
            }
            orders.Status = (OrderStatus)status;
            var user = AccountHelper.GetUser(uid);
            if (user == null)
            {
                ReturnErrorMsg(string.Format("不存在Id={0}的用户", uid));
                return;
            }

            if (orders.Status == OrderStatus.Pay && orders.Pid == 0)
            {//余额付款
                if (user.Money < orders.TotalPrice)
                {
                    ReturnErrorMsg("余额不足");
                    return;
                }
                user.Money -= orders.TotalPrice;
                //保存用户信息
                AccountHelper.UpdateUser(user);

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
                //记录充值记录
                ChargeLogHelper.AddChargeLog(chargeLog);
            }

            OrdersHelper.SaveOrders(orders);

            ReturnCorrectMsg("更新订单状态成功");
        }
        #endregion
    }
}