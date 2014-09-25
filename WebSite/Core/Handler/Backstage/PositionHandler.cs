using Backstage.Core.Entity;
using Backstage.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Handler.Backstage
{
    public class BoxTypeForUI
    {
        public int Id { get; set; }

        public string Title { get; set; }
    }

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
                case "getitem":
                    GetItem(); break;
                case "update":
                    Update(); break;
                case "add":
                    Add(); break;
                case "del":
                    Delete(); break;
                case "categorys":
                    GetCategorys(); break;
                case "updatecategory":
                    UpdateCategory(); break;
                case "addCateory":
                    AddCategory(); break;
                case "deletecategory":
                    DeleteCategory(); break;
                case "savetypes":
                    SaveTypes(); break;
                case "times":
                    GetTimes(); break;
                case "addTime":
                    AddTime(); break;
                case "editTime":
                    EditTime(); break;
                case "deltimes":
                    DeleteTime(); break;
                default: break;
            }
        }


        private void SaveTypes()
        {
            var list = Tools.Json.JsonTransfer.DeserializeObject<List<BoxTypeForUI>>(GetString("list"));
            var sellerId = GetInt("sellerId");

            foreach (var item in list)
            {
                var type = PositionHelper.GetBoxType(item.Id);
                type.Title = item.Title;
                PositionHelper.UpdateBoxType(type);
            }

        }

        private void Delete()
        {
            var ids = Utility.GetListint(GetString("ids"));
            foreach (var id in ids)
            {
                PositionHelper.Delete(id);
            }
        }

        private void Add()
        {
            var item = new Position();
            item.BoxNumber = GetString("box");
            item.BoxTypeId = GetInt("boxType");
            item.Description = GetString("description");
            item.ImgUrls = GetString("imgurls");
            //item.Phone = GetString("phone");
            //item.Price = GetFloat("price");
            //item.SellerId = GetInt("selllerId");
            item.Status = 0;
            item.CreateTime = DateTime.Now;

            PositionHelper.Create(item);
        }

        private void GetItem()
        {
            var id = GetInt("id");
            var item = PositionHelper.GetItem(id);
            JsonTransfer jt = new JsonTransfer();
            var type = PositionHelper.GetBoxType(item.BoxTypeId);
            item.BoxTypeTitle = type.Title;
            jt.Add("data", item);
            Response.Write(DesEncrypt(jt));
            Response.End();
        }

        private void Update()
        {
            var id = GetInt("id");
            var item = PositionHelper.GetItem(id);
            item.BoxNumber = GetString("box");
            item.BoxTypeId = GetInt("boxType");
            item.Description = GetString("description");
            item.ImgUrls = GetString("imgurls");

            PositionHelper.Update(item);
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
            var boxTypes = PositionHelper.GetListBoxTypes(sellerId, 0, 0);
            results.TotalCount = list.TotalCount;
            foreach (var item in list.Results)
            {
                var boxType = boxTypes.FirstOrDefault(b => b.Id == item.BoxTypeId);

                var o = new
                {
                    Id = item.Id,
                    BoxNumber = item.BoxNumber,
                    BoxTypeId = item.BoxTypeId,
                    BoxTypeTitle = boxType.Title,
                    Lowest = boxType.Lowest
                };

                results.Results.Add(o);
            }
            JsonTransfer jt = new JsonTransfer();
            jt.Add("data", results);
            Response.Write(DesEncrypt(jt));
            Response.End();
        }

        private void DeleteCategory()
        {
            var ids = Utility.GetListint(GetString("ids"));
            foreach (var id in ids)
            {
                PositionHelper.DeleteBoxType(id);
            }
        }

        private void AddCategory()
        {
            var title = GetInt("title");
            var item = new BoxType();
            item.CreateTime = DateTime.Now;
            item.HoldNum = GetInt("holdnum");
            item.Lowest = GetInt("lowest");
            item.SellerId = GetInt("sellerId");
            item.Title = GetString("title");

            PositionHelper.CreateBoxType(item);
        }

        private void GetCategorys()
        {
            var sellerId = GetInt("sellerId");
            var list = PositionHelper.GetListBoxTypes(sellerId, 0, 0);

            JsonTransfer jt = new JsonTransfer();
            jt.Add("data", list);
            Response.Write(DesEncrypt(jt));
            Response.End();
        }

        private void UpdateCategory()
        {
            var id = GetInt("id");
            var item = PositionHelper.GetBoxType(id);
            item.HoldNum = GetInt("holdnum");
            item.Lowest = GetInt("lowest");
            item.SellerId = GetInt("sellerId");
            item.Title = GetString("title");

            PositionHelper.UpdateBoxType(item);
        }

        private void DeleteTime()
        {
            var ids = Utility.GetListint(GetString("ids"));
            foreach (var id in ids)
            {
                PositionHelper.DeleteTimeline(id);
            }
        }

        private void EditTime()
        {
            var id = GetInt("id");
            var item = PositionHelper.GetTimeLine(id);
            item.BeginTime = GetTime("begin");
            item.EndTime = GetTime("end");
            item.Date = GetTime("date");
            item.Title = GetString("title");
            item.Status = GetInt("status");

            PositionHelper.UpdateTimeline(item);
        }

        private void AddTime()
        {
            var item = new Timeline();
            item.BeginTime = GetTime("begin");
            item.EndTime = GetTime("end");
            item.Date = item.BeginTime.Date;
            item.Title = GetString("title");
            item.Status = GetInt("status");
            item.SellerId = GetInt("sellerId");
            item.PositionId = GetInt("positionId");
            PositionHelper.CreateTimeline(item);
        }

        private void GetTimes()
        {
            var sellerId = GetInt("sellerId");
            var positionId = GetInt("positionId");
            var list = PositionHelper.GetTimeLines(positionId);

            JsonTransfer jt = new JsonTransfer();
            var results = new List<object>();
            foreach (var item in list)
            {
                results.Add(new
                {
                    Id = item.Id,
                    Title = item.Title,
                    Time = item.BeginTime.ToString("HH:mm") + "--" + item.EndTime.ToString("HH:mm")
                });
            }
            jt.Add("data", results);
            Response.Write(DesEncrypt(jt));
            Response.End();
        }

    }
}