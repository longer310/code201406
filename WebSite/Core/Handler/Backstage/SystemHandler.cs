using Backstage.Core.Entity;
using Backstage.Core.Logic;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Handler.Backstage
{
    public class SystemHandler : BaseApiHandler
    {
        public override void ProcessRequest(HttpContext context)
        {
            base.SetApiName("SystemHandler");
            base.ProcessRequest(HttpContext.Current);
            switch (Action)
            {
                case "getrules": //获取规则
                    GetRules(); break;
                case "updaterules": //规则更新
                    UpdateRules(); break;
                case "getsalestat": //获取销售统计
                    GetSaleStat(); break;
                case "rechargestat": //获取充值统计
                    RechargeStat(); break;
                case "sellerinfo":  //更新商家资料
                    UpdateSellerInfo(); break;
                case "addmsg":  //新增商家推送
                    AddSystemMsg(); break;
                case "getmsgs":  //获取商家推送信息
                    GetMsgs(); break;
                default: break;
            }
        }

        private void GetRules()
        {
            var sellerId = GetInt("sellerid");
            var seller = MerchantHelper.GetMerchant(sellerId);
            var userlevels = SystemHelper.GetUserLevels(sellerId);

            var data = new
            {
                userlevels = userlevels.ToList(),
                CommentIntegral = seller.CommentIntegral,
                ConsumptionIntegral = seller.ConsumptionIntegral,
                Freight = seller.Freight,
                NeedToFreeFreight = seller.NeedToFreeFreight,
                ReChargeIntegral = seller.ReChargeIntegral,
                ShareIntegral = seller.ShareIntegral
            };
            JsonTransfer jt = new JsonTransfer();
            jt.Add("data", data);
            Response.Write(DesEncrypt(jt));
            Response.End();
        }

        private void UpdateRules()
        {
            var sellerId = GetInt("sellerid");
            var seller = MerchantHelper.GetMerchant(sellerId);
            //var userlevels = SystemHelper.GetUserLevels(sellerId);
            var userlevels = Newtonsoft.Json.JsonConvert.DeserializeObject<List<UserLevel>>("levels");

            SystemHelper.UpdateUserLevels(userlevels);
            throw new NotImplementedException();
        }

        private void RechargeStat()
        {


            throw new NotImplementedException();
        }

        private void GetSaleStat()
        {
            throw new NotImplementedException();
        }

        

        private void GetMsgs()
        {
            

            throw new NotImplementedException();
        }

        private void AddSystemMsg()
        {

            throw new NotImplementedException();
        }

        private void UpdateSellerInfo()
        {

            throw new NotImplementedException();
        }



    }

    
}