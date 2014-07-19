using System;
using System.Collections.Generic;
using System.EnterpriseServices;
using System.Linq;
using System.Web;
using Backstage.Core;
using Backstage.Core.Entity;
using Backstage.Core.Logic;

namespace Backstage.Handler
{
    public class GoodsHandler : BaseHandler
    {
        public override void ProcessRequest(HttpContext context)
        {
            FreeActions = "";
            RoleType = RoleType.Merchant;//需商家管理权限 暂定权限管理
            base.ProcessRequest(HttpContext.Current);
            switch (Action)
            {
                case "getGoodsCategoriesList":
                    GetGoodsCategoriesList(); break;
                case "addGoodsCategories":
                    AddGoodsCategories(); break;
                case "delGoodsCategories":
                    DelGoodsCategories(); break;
                default: break;
            }
        }
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
            var index = GetInt("index");

            var goodsCategories = new GoodsCategories();
            goodsCategories.Name = name;
            goodsCategories.SellerId = CurrentUser.Id;
            goodsCategories.Index = index;
            if(GoodsCategoriesHelper.SaveGoodsCategories(goodsCategories))
                ReturnCorrectMsg("添加成功");
            else
                ReturnErrorMsg("添加失败");
        }

        private void DelGoodsCategories()
        {
            int id = GetInt("id");
            var goodsCategories = GoodsCategoriesHelper.GetGoodsCategories(id);
            if (goodsCategories.SellerId != CurrentUser.Id)
            {
                ReturnErrorMsg("没有权限删除其他商户分类");
                return;
            }
            if(GoodsCategoriesHelper.DeleteGoodsCategories(id))
                ReturnCorrectMsg("删除成功");
            else
                ReturnErrorMsg("删除失败");
        }
    }
}