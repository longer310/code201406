﻿using System;
using System.Collections.Generic;
using System.EnterpriseServices;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Xml.Serialization;
using Backstage.Core;
using Backstage.Core.Entity;
using Backstage.Core.Logic;

namespace Backstage.Handler
{
    public class GoodsHandler : BaseHandler
    {
        public override void ProcessRequest(HttpContext context)
        {
            FreeActions = ",saveGoodsList,";
            RoleType = RoleType.ThirdUser;//需商家管理权限 暂定权限管理
            base.ProcessRequest(HttpContext.Current);
            switch (Action)
            {
                #region 上传图片
                case "uploadPic":
                    UploadPic(); break;
                #endregion

                #region 产品分类管理
                case "getGoodsCategoriesList":
                    GetGoodsCategoriesList(); break;
                case "addGoodsCategories":
                    AddGoodsCategories(); break;
                case "delGoodsCategoriesList":
                    DelGoodsCategoriesList(); break;
                case "modifyNameGoodsCategories":
                    ModifyNameGoodsCategories(); break;
                case "modifyIndexGoodsCategories":
                    ModifyIndexGoodsCategories(); break;
                #endregion

                #region 产品列表
                case "getGoodsList":
                    GetGoodsList(); break;
                case "delGoodsList":
                    DelGoodsList(); break;
                case "savegoods":
                    SaveGoods(); break;
                case "saveGoodsList":
                    SaveGoodsList(); break;
                case "getgoods":
                    GetGoods(); break;
                #endregion

                default: break;
            }
        }
        #region 上传图片
        private void UploadPic()
        {
            var localUrl = GetString("localUrl");

        }
        #endregion

        #region 产品分类管理
        /// <summary>
        /// 获取商户产品分类列表
        /// </summary>
        private void GetGoodsCategoriesList()
        {
            JsonTransfer jt = new JsonTransfer();
            //角色为商户时 Id即为商户id 相当于用户的SellerId
            var list = GoodsCategoriesHelper.GetList(CurrentUser.Id);

            jt.Add("list", list.Results);
            jt.Add("count", list.TotalCount);
            Response.Write(jt.ToJson());
        }

        /// <summary>
        /// 添加商品分类
        /// </summary>
        private void AddGoodsCategories()
        {
            var name = GetString("name");
            //var index = GetInt("index");

            var maxIndex = GoodsCategoriesHelper.GetMaxIndex(CurrentUser.Id);
            var index = maxIndex + 1;
            var goodsCategories = new GoodsCategories();
            goodsCategories.Name = name;
            goodsCategories.SellerId = CurrentUser.Id;
            goodsCategories.Index = index;
            if (GoodsCategoriesHelper.SaveGoodsCategories(goodsCategories))
                ReturnCorrectMsg("添加成功");
            else
                ReturnErrorMsg("添加失败");
        }

        /// <summary>
        /// 删除商品分类列表
        /// </summary>
        private void DelGoodsCategoriesList()
        {
            var ids = GetString("ids");
            var idList = Utility.GetListint(ids);
            if (idList.Count == 0)
            {
                ReturnErrorMsg("参数有误");
                return;
            }
            var goodsCategoriesList = GoodsCategoriesHelper.GetList(CurrentUser.Id, string.Format(" and Id in({0})", ids));
            if (goodsCategoriesList.Results.Count != idList.Count)
            {
                ReturnErrorMsg("没有权限删除其他商户分类或分类不存在");
                return;
            }
            if (GoodsCategoriesHelper.DeleteGoodsCategoriesList(CurrentUser.Id, ids))
                ReturnCorrectMsg("删除成功");
            else
                ReturnErrorMsg("删除失败");
        }

        /// <summary>
        /// 修改商品分类名称
        /// </summary>
        private void ModifyNameGoodsCategories()
        {
            int id = GetInt("id");
            string name = GetString("name");
            if (id <= 0 || string.IsNullOrEmpty(name))
            {
                ReturnErrorMsg("参数错误");
                return;
            }
            var goodsCategories = GoodsCategoriesHelper.GetGoodsCategories(id);
            if (goodsCategories == null)
            {
                ReturnErrorMsg("不存在该id的分类");
                return;
            }
            if (goodsCategories.SellerId != CurrentUser.Id)
            {
                ReturnErrorMsg("没有权限修改该商户分类");
                return;
            }
            goodsCategories.Name = name;
            if (GoodsCategoriesHelper.SaveGoodsCategories(goodsCategories))
                ReturnCorrectMsg("修改成功");
            else
                ReturnErrorMsg("修改失败");
        }

        /// <summary>
        /// 修改商品分类排序
        /// </summary>
        private void ModifyIndexGoodsCategories()
        {
            int ida = GetInt("ida");
            int idaIndex = GetInt("idaIndex");
            int idb = GetInt("idb");
            int idbIndex = GetInt("idbIndex");
            if (ida <= 0 || idb <= 0 || idaIndex == idbIndex || Math.Abs(idaIndex - idbIndex) != 1)
            {
                ReturnErrorMsg("参数错误");
                return;
            }
            var goodsCategoriesA = GoodsCategoriesHelper.GetGoodsCategories(ida);
            var goodsCategoriesB = GoodsCategoriesHelper.GetGoodsCategories(idb);
            if (goodsCategoriesA == null || goodsCategoriesB == null)
            {
                ReturnErrorMsg("不存在该id的分类");
                return;
            }
            if (goodsCategoriesA.SellerId != CurrentUser.Id || goodsCategoriesB.SellerId != CurrentUser.Id)
            {
                ReturnErrorMsg("没有权限修改该商户分类");
                return;
            }
            if (goodsCategoriesA.Index != idbIndex || goodsCategoriesB.Index != idaIndex)
            {
                ReturnErrorMsg("替换排序的分类id有误");
                return;
            }
            goodsCategoriesA.Index = idaIndex;
            goodsCategoriesB.Index = idbIndex;
            var list = new List<GoodsCategories>() { goodsCategoriesA, goodsCategoriesB };
            if (GoodsCategoriesHelper.SaveGoodsCategoriesList(list))
                ReturnCorrectMsg("修改成功");
            else
                ReturnErrorMsg("修改失败");
        }
        #endregion

        #region 产品列表
        /// <summary>
        /// 获取产品列表
        /// </summary>
        public void GetGoodsList()
        {
            int cid = GetInt("cid");
            int order = GetInt("order");
            int start = GetInt("start");
            int limit = GetInt("limit");
            int type = GetInt("type");

            string wheresql = string.Empty;
            string shoppingcartql = "";
            if (cid > 0) wheresql += string.Format(" and Cid={0}", cid);
            if (type > 0)
            {
                switch (type)
                {
                    case 1:
                        wheresql += " and IsRecommend>0 "; break;
                    case 2:
                        wheresql += " and IsHot>0 "; break;
                    default: break;
                }
            }
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
            var goodsresult = GoodsHelper.GetGoodsList(CurrentUser.Id, wheresql, shoppingcartql, start * limit, limit, 1);

            var jt = new JsonTransfer();
            jt.Add("list", goodsresult.Results);
            jt.Add("totalcount", goodsresult.TotalCount);
            Response.Write(jt.ToJson());
            Response.End();
        }

        /// <summary>
        /// 删除产品列表
        /// </summary>
        public void DelGoodsList()
        {
            var gids = GetString("gids");

            var gidList = Utility.GetListint(gids);
            if (gidList.Count == 0)
            {
                ReturnErrorMsg("参数有误");
                return;
            }
            var wheresql = string.Format(" and Id in({0})", gids);
            var goodsresult = GoodsHelper.GetGoodsList(CurrentUser.Id, wheresql);
            if (goodsresult.Results.Count != gidList.Count)
            {
                ReturnErrorMsg("没有权限删除其他商户产品或产品不存在");
                return;
            }
            if (GoodsHelper.DelGoodsList(CurrentUser.Id, gids))
                ReturnCorrectMsg("删除成功");
            else
                ReturnErrorMsg("删除失败");
        }

        /// <summary>
        /// 获取商品详情
        /// </summary>
        public void GetGoods()
        {
            var gid = GetInt("gid");
            var goods = GoodsHelper.GetGoods(gid);
            if (goods == null)
            {
                ReturnErrorMsg("不存在该商品");
                return;
            }
            if (goods.SellerId != CurrentUser.Id)
            {
                ReturnErrorMsg("无权访问此商品");
                return;
            }

            goods.InitThumbnails();

            //返回
            ReturnCorrectData(goods);
        }

        /// <summary>
        /// 新增产品
        /// </summary>
        public void SaveGoods()
        {
            var id = GetInt("id");
            var title = GetString("title");
            var imgUrls = GetString("imgUrls");
            var logoUrl = GetString("logoUrl");
            var nowPrice = GetFloat("nowPrice");
            var originalPrice = GetFloat("originalPrice");
            var tags = GetString("tags");
            var cid = GetInt("cid");
            var content = GetString("content");
            var isHot = GetInt("isHot");
            var isRecommend = GetInt("isRecommend");

            var goods = new Goods();
            if (id > 0)
            {
                goods = GoodsHelper.GetGoods(id);
                if (goods.SellerId != CurrentUser.Id)
                {
                    ReturnErrorMsg("没有权限修改改该商户产品");
                    return;
                }
            }
            goods.Title = title;
            goods.ImageUrlList = Utility.GetListstring(imgUrls);
            goods.LogoUrl = logoUrl;
            goods.Nowprice = nowPrice;
            goods.OriginalPrice = originalPrice;
            goods.TagList = Utility.GetListstring(tags);
            goods.Cid = cid;
            goods.Content = content;
            goods.IsHot = isHot;
            goods.IsRecommend = isRecommend;
            goods.SellerId = CurrentUser.Id;
            var num = GoodsHelper.SaveGoods(goods);
            if (num > 0)
                if (id > 0) ReturnCorrectMsg("编辑成功");
                else ReturnCorrectMsg(num.ToString());
            else
                if (id > 0) ReturnErrorMsg("添加失败");
                else ReturnErrorMsg("编辑失败");
        }

        [Serializable]
        public class ChangeGoods
        {
            [XmlElement("Id")]
            public int Id { get; set; }
            [XmlElement("Nowprice")]
            public float Nowprice { get; set; }
            [XmlElement("OriginalPrice")]
            public float OriginalPrice { get; set; }
            [XmlElement("IsRecommend")]
            public int IsRecommend { get; set; }//传大于1的值
            [XmlElement("IsHot")]
            public int IsHot { get; set; }//传大于1的值
        }
        /// <summary>
        /// 一键保存产品列表
        /// </summary>
        public void SaveGoodsList()
        {
            string data_save = GetString("data_save");
            if (string.IsNullOrEmpty(data_save))
            {
                ReturnErrorMsg("没有选择需要保存的商品");
                return;
            }

            var json = new JavaScriptSerializer();
            var list = json.Deserialize(data_save, typeof(List<ChangeGoods>)) as List<ChangeGoods>;
            if (list == null)
            {
                ReturnErrorMsg("没有选择需要保存的商品");
                return;
            }

            var saveList = new List<Goods>();
            foreach (var changeGoodse in list)
            {
                var goods = GoodsHelper.GetGoods(changeGoodse.Id);
                if (goods == null || goods.SellerId != CurrentUser.Id)
                {
                    ReturnErrorMsg("没有权限修改产品或者产品不存在");
                    return;
                }
                goods.Nowprice = changeGoodse.Nowprice;
                goods.OriginalPrice = changeGoodse.OriginalPrice;
                goods.IsRecommend = changeGoodse.IsRecommend;
                goods.IsHot = changeGoodse.IsHot;

                saveList.Add(goods);
            }
            if (saveList.Count > 0)
            {
                if (GoodsHelper.SaveGoodsList(saveList))
                {
                    ReturnCorrectMsg("保存成功");
                    return;
                }
            }
            ReturnCorrectMsg("保存失败");
        }

        #endregion
    }
}