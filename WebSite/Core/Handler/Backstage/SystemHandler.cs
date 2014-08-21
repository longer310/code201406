﻿using Backstage.Core.Entity;
using Backstage.Core.Logic;
using Backstage.Model;
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
                case "getcashlist": //获取提现记录
                    GetCashList(); break;
                case "getseller":
                    GetMerchant(); break;
                case "withdraw ": //提现
                    Withdraw(); break;
                case "getannouncement":
                    GetAnnouncement(); break;
                default: break;
            }
        }

        private void GetMerchant()
        {
            var sellerid = GetInt("sellerid");
            var seller = MerchantHelper.GetMerchant(sellerid);
            JsonTransfer jt = new JsonTransfer();
            jt.Add("data", seller);
            Response.Write(DesEncrypt(jt));
            Response.End();
        }

        private void Withdraw()
        {
            var item = new ExtractMoney();
            item.SellerId = GetInt("sellerid");
            item.Money = GetFloat("money");
            item.Bank = GetString("bank");
            item.CardNumber = GetLong("cardnumber");
            item.AccountName = GetString("accountname");
            item.CreateTime = DateTime.Now;

            var user = AccountHelper.GetUser(item.SellerId);
            if (user == null)
                throw new ArgumentNullException("user为空：" + item.SellerId);

            //目前商户的用户信息分两张表存储
            user.Money -= item.Money;
            AccountHelper.UpdateUser(user);
            item.Balance = user.Money;

            ExtractMoneyHelper.Create(item);
        }


        private void GetCashList()
        {
            var sellerId = GetInt("sellerid");
            var start = GetInt("start");
            var limit = GetInt("limit");

            var result = ExtractMoneyHelper.GetPagings(sellerId, start * limit, limit);
            var data = new PagResults<object>();
            data.TotalCount = result.TotalCount;
            foreach (var item in result.Results.OrderByDescending(o => o.CreateTime))
            {
                var d = new
                {
                    Id = item.Id,
                    CreateTime = item.CreateTime.ToString("yyyy-MM-dd HH:mm:ss"),
                    Money = item.Money,
                    Balance = item.Balance,
                    Bank = item.Bank,
                    CardNumber = item.CardNumber,
                    SellerId = item.SellerId
                };
                data.Results.Add(d);
            }

            JsonTransfer jt = new JsonTransfer();
            jt.Add("data", data);
            Response.Write(DesEncrypt(jt));
            Response.End();
        }

        private void GetAnnouncement()
        {
            var data = AnnouncementHelper.GetList(0,1);
            JsonTransfer jt = new JsonTransfer();
            jt.Add("data", data);
            Response.Write(DesEncrypt(jt));
            Response.End();
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