﻿using Backstage.Core.Entity;
using Backstage.Core.Logic;
using Backstage.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using log4net;

namespace Backstage.Core.Handler.Backstage
{
    public class SystemHandler : BaseHandler
    {
        private static ILog logger = LogManager.GetLogger("SystemHandler");
        public override void ProcessRequest(HttpContext context)
        {
            //base.SetApiName("SystemHandler");
            base.ProcessRequest(HttpContext.Current);
            switch (Action)
            {
                case "getrules": //获取规则
                    GetRules(); break;
                case "updaterules": //规则更新
                    UpdateRules(); break;
                case "sellerinfo":  //更新商家资料
                    UpdateSellerInfo(); break;
                case "getcashlist": //获取提现记录
                    GetCashList(); break;
                case "getseller":
                    GetMerchant(); break;
                case "withdraw": //提现
                    Withdraw(); break;
                case "bankedit":
                    BankEdit(); break;
                case "getannouncement":
                    GetAnnouncement(); break;
                case "getpushs":
                    GetPushs(); break;
                case "addpush":
                    CreatePush(); break;
                case "editpush":
                    UpdatePush(); break;
                case "updatepwd":
                    UpdateMerchantPwd(); break;
                default: break;
            }
        }


        private void UpdateMerchantPwd()
        {
            var oldpwd = GetString("oldpwd");
            var newpwd = GetString("newpwd");

            var user = AccountHelper.GetCurUser();
            user = AccountHelper.GetUser(user.Id);
            if (oldpwd != user.Pwd)
                ReturnErrorMsg("原密码错误，请重新输入");
            user.Pwd = newpwd;
            AccountHelper.SaveAccount(user);
            ReturnCorrectMsg("修改成功");
        }

        private void UpdatePush()
        {
            var push = new Push();
            push.Id = GetInt("id");
            push.Title = GetString("title");
            //push.Content = GetString("content");
            push.PushType = (PushType)GetInt("pushtype");
            push.SellerId = GetInt("sellerid");
            push.TypeId = GetInt("typeId");

            SystemHelper.UpdatePush(push);
        }

        private void CreatePush()
        {
            var push = new Push();
            push.Id = GetInt("id");
            push.Title = GetString("title");
            //push.Content = GetString("content");
            push.PushType = (PushType)GetInt("pushtype");
            push.SellerId = GetInt("sellerid");
            push.TypeId = GetInt("typeId");
            push.CreateTime = DateTime.Now;

            SystemHelper.CreatePush(push);
        }

        private void GetPushs()
        {
            var sellerId = GetInt("sellerid");
            var start = GetInt("start");
            var limit = GetInt("limit");
            var list = SystemHelper.GetPagPushs(sellerId, start * limit, limit);
            var items = new PagResults<object>();
            foreach (var l in list.Results)
            {
                var o = new
                {
                    Id = l.Id,
                    CreateTime = l.CreateTime.ToString("yyyy-MM-dd HH:mm:ss"),
                    Title = l.Title,
                    Content = l.Content,
                    PushType = l.PushType,
                    SellerId = l.SellerId,
                    TypeId = l.TypeId
                };
                items.Results.Add(o);
            }
            items.TotalCount = list.TotalCount;
            JsonTransfer jt = new JsonTransfer();
            jt.Add("data", list);
            Response.Write(DesEncrypt(jt).ToLower());
            Response.End();
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

        private void BankEdit()
        {
            int sellerId = GetInt("sellerid");
            var seller = MerchantHelper.GetMerchant(sellerId);
            seller.CardNumber = GetLong("cardnumber");
            seller.Bank = GetString("bank");
            seller.AccountName = GetString("accountname");

            MerchantHelper.SaveMerchant(seller);
        }

        private void Withdraw()
        {
            var item = new ExtractMoney();
            item.SellerId = GetInt("sellerId");
            item.Money = GetFloat("money");
            item.Bank = GetString("bank");
            item.CardNumber = GetLong("cardnumber");
            item.AccountName = GetString("accountname");
            item.CreateTime = DateTime.Now;

            var user = AccountHelper.GetUser(item.SellerId);
            if (user == null)
                throw new ArgumentNullException("user为空：" + item.SellerId);
            if (item.CardNumber <= 0 || item.Bank.Length < 1 || item.AccountName.Length < 1)
                ReturnErrorMsg("提现失败，卡号、开户行、开户名等信息是必填项，请填写正确");


            //目前商户的用户信息分三张表存储
            //提现确认打款后才扣钱
            //user.Money -= item.Money;
            //AccountHelper.SaveAccount(user);

            //商家更新
            var seller = MerchantHelper.GetMerchant(item.SellerId);
            seller.CardNumber = item.CardNumber;
            seller.Bank = item.Bank;
            seller.AccountName = item.AccountName;
            float fee = ParamHelper.PlatformCfgData.SignList.FirstOrDefault(s => s.Id == seller.Sid).Prec * item.Money / 100;
            item.Fee = fee;
            if (seller.Money < (item.Money + item.Fee))
            {
                ReturnErrorMsg(string.Format("提现失败，没有这么多的资金可以提现，提现金额:{0}，手续费:{1}", item.Money, item.Fee));
                return;
            }

            seller.Money = seller.Money - item.Money - item.Fee;
            MerchantHelper.SaveMerchant(seller);



            //提现表更新
            item.Balance = seller.Money;
            item.UserAccount = user.UserName;//存储商户账户
            ExtractMoneyHelper.Create(item);
            ReturnCorrectMsg(string.Format("提现{0}申请成功，手续费：{1}，请耐心等待后台人员处理", item.Money, item.Fee));

            //发短信
            if (Utility._msg_opensend == "1")
            //Utility.SendMsg(verificationCode.Code, verificationCode.Phone, Utility._modifyphone_message);
            {
                SendMsgClass4 jsobject = new SendMsgClass4();

                jsobject.param1 = string.IsNullOrEmpty(seller.Name) ? "商户名称为空" : seller.Name;
                jsobject.param2 = item.Money.ToString();
                jsobject.param3 = "3~5";
                jsobject.param4 = Utility._3vurl;

                if (Utility.SendMsg(seller.Phone, MsgTempleId.MerchantWithdraw, jsobject) != "发送成功")
                {
                    logger.InfoFormat("短信模板：{0},Phone:{3},发送失败merchantId：{1},Name:{2}",
                        (int)MsgTempleId.MerchantWithdraw, seller.Id, seller.Name, seller.Phone);
                    //ReturnErrorMsg("短信发送失败");
                    //return;
                }
            }
            ReturnCorrectMsg(string.Format("提现{0}申请成功，手续费：{1}，请耐心等待后台人员处理", item.Money, item.Fee));
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
                    Fee = item.Fee,
                    Balance = item.Balance,
                    Bank = item.Bank,
                    CardNumber = item.CardNumber,
                    Status = item.Status == 1 ? "提现成功" : "处理中",
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
            var data = AnnouncementHelper.GetList(0, 1);
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
            var setting = SystemHelper.GetMerchantExtend(sellerId);

            var data = new
            {
                Userlevels = userlevels.ToList(),
                CommentIntegral = setting != null ? setting.CommentIntegral : 0,
                ConsumptionIntegral = setting != null ? setting.ConsumeIntegral : 0,
                Freight = seller.Freight,
                NeedToFreeFreight = seller.NeedToFreeFreight,
                ReChargeIntegral = setting != null ? setting.ChargeIntegral : 0,
                ShareIntegral = setting != null ? setting.ShareIntegral : 0,
                RegisteIntegaral = setting != null ? setting.RegisteIntegaral : 0
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
            var userlevels = Newtonsoft.Json.JsonConvert.DeserializeObject<List<UserLevel>>(GetString("levels"));
            var merchantExtend = SystemHelper.GetMerchantExtend(sellerId);
            if (merchantExtend == null)
            {
                merchantExtend = new MerchantExtend();
                merchantExtend.SellerId = sellerId;
                merchantExtend.CommentIntegral = GetInt("cmi");
                merchantExtend.ConsumeIntegral = GetInt("costi");
                merchantExtend.ChargeIntegral = GetInt("ci");
                merchantExtend.ShareIntegral = GetInt("si");
                merchantExtend.RegisteIntegaral = GetInt("ri");
                SystemHelper.CreateMerchantExtend(merchantExtend);
            }
            else
            {
                merchantExtend.CommentIntegral = GetInt("cmi");
                merchantExtend.ConsumeIntegral = GetInt("costi");
                merchantExtend.ChargeIntegral = GetInt("ci");
                merchantExtend.ShareIntegral = GetInt("si");
                merchantExtend.RegisteIntegaral = GetInt("ri");
                SystemHelper.UpdateMerchantExtend(merchantExtend);
            }

            seller.Freight = GetInt("fe");
            seller.NeedToFreeFreight = GetInt("nffe");
            MerchantHelper.SaveMerchant(seller);
            SystemHelper.UpdateUserLevels(userlevels);
        }


        private void UpdateSellerInfo()
        {
            var sellerId = GetInt("sellerid");
            var merchant = MerchantHelper.GetMerchant(sellerId);
            if (merchant == null)
                throw new ArgumentNullException("merchant");

            merchant.Name = GetString("title");
            merchant.LogoUrl = GetString("logourl");
            merchant.Phone = GetString("phone");
            merchant.ManagerPhone = GetString("managephone");
            merchant.Address = GetString("address");
            merchant.WinXinAccount = GetString("weixin");
            merchant.WxQRCode = GetString("wxqrcode");
            merchant.Qq = GetString("qq");
            merchant.Remark = GetString("email");//直接把商户邮箱改为备注了 邮箱字段建勇说不需要
            merchant.Description = GetString("content");

            MerchantHelper.SaveMerchant(merchant);
        }



    }


}