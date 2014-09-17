using Backstage.Core.Entity;
using Backstage.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Handler.Backstage
{
    public class PositionHandler : BaseApiHandler
    {
        public override void ProcessRequest(HttpContext context)
        {
            base.SetApiName("SystemHandler");
            base.ProcessRequest(HttpContext.Current);
            switch (Action)
            {
                case "getlist": //获取列表
                    GetList(); break;
                case "getitem": //获取规则
                    GetItem(); break;
                case "update": //获取规则
                    Update(); break;
                case "add":
                    Add(); break;
                case "categorys":
                    GetCategorys(); break;
                case "updatecategory":
                    UpdateCategory(); break;
                case "addCateory":
                    AddCategory(); break;
                case "deletecategory":
                    DeleteCategory(); break;
                case "times":
                    GetTimes(); break;
                case "addTime":
                    AddTime(); break;
                case "editTime":
                    EditTime(); break;
                case "deleteTime":
                    DeleteTime(); break;
                default: break;
            }
        }

        private void DeleteCategory()
        {
            throw new NotImplementedException();
        }

        private void AddCategory()
        {
            throw new NotImplementedException();
        }

        private void UpdateCategory()
        {
            throw new NotImplementedException();
        }

        private void DeleteTime()
        {
            throw new NotImplementedException();
        }

        private void EditTime()
        {
            throw new NotImplementedException();
        }

        private void AddTime()
        {
            throw new NotImplementedException();
        }

        private void GetTimes()
        {
            throw new NotImplementedException();
        }

        private void GetCategorys()
        {
            throw new NotImplementedException();
        }

        private void Add()
        {
            var item = new Position();
            item.BoxNumber = GetString("box");
            item.BoxTypeId = GetInt("boxType");
            item.Description = GetString("description");
            item.ImgUrls = GetString("imgurls");
            item.Phone = GetString("phone");
            item.Price = GetFloat("price");
            item.SellerId = GetInt("selllerId");
            item.Status = 0;

        }

        private void GetItem()
        {
            throw new NotImplementedException();
        }

        private void Update()
        {
            throw new NotImplementedException();
        }

        private void GetList()
        {
            var sellerId = GetInt("sellerId");
            var index = GetInt("start");
            var size = GetInt("limit");
            var cid = GetInt("cid");
            var status = GetInt("status");
            var list = PositionHelper.GetPaging(sellerId, index * size, size, cid);
            var results = new PagResults<object>();
            foreach (var item in list.Results)
            {
                var o = new
                {
                    Id = item.Id,
                    BoxNumber = item.BoxNumber,
                    BoxTypeId = item.BoxTypeId,
 
                };
            }


        }
    }
}