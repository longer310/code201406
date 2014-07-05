using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Web;
using Backstage.Core;
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
                default: break;
            }
        }
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
            var ads = GoodsHelper.GetGoodsList(sellerid,out totalnum, "", 5);
        }

        private void GetGoodsList()
        {
            
        }
    }
}