using Backstage.Core.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Handler
{
    public class GeneralHandler : BaseApiHandler
    {
        public override void ProcessRequest(HttpContext context)
        {
            base.SetApiName("GeneralHandler");
            base.ProcessRequest(HttpContext.Current);
            switch (Action)
            {
                case "generatewifi":
                    Generate_Wifi(); break;
                case "verificatewifi":
                    Verificate_Wifi(); break;
                case "updateweixin":
                    UpdateWeixin(); break;
                default: break;
            }
        }

        private void UpdateWeixin()
        {
            string access_token = GetString("access_token");
            int token_expire = GetInt("token_expire");
            int sellerId = GetInt("sellerid");

            var item = GeneralHelper.GetWeixinToken(access_token, sellerId);
            if (item.Id == 0)
            {
                item.Access_token = access_token;
                item.Token_Expire = DateTime.FromFileTimeUtc(token_expire);
                item.SellerId = sellerId;

                GeneralHelper.CreateWeixinToken(item);
            }
            else
            {
                GeneralHelper.UpdateWeixinToken(item);
            }
            JsonTransfer jt = new JsonTransfer();
            jt.AddSuccessParam();
            Response.Write(DesEncrypt(jt).ToLower());
            Response.End();
        }

        private void Verificate_Wifi()
        {
            int userId = GetInt("uid");
            int sellerId = GetInt("sellerid");
            string pwd = GetString("pwd");
            var user_wifi = new UserWifi()
            {
                Pwd = pwd,
                SellerId = sellerId,
                UserId = userId
            };
            var item = GeneralHelper.GetUserWifiItem(userId, sellerId);
            JsonTransfer jt = new JsonTransfer();
            if (item.Pwd == Utility.MD5_Encrypt(item.Pwd))
            {
                var data = new
                {
                    expir = item.Expiry
                };

                jt.AddSuccessParam();
                jt.Add("data", data);
            }
            else
            {
                jt.Add("status", 0);
                jt.Add("message", "密码错误");
            }

            Response.Write(DesEncrypt(jt).ToLower());
            Response.End();
        }

        private void Generate_Wifi()
        {
            int userId = GetInt("uid");
            int sellerId = GetInt("sellerid");
            var random = new Random();
            var pwd = random.Next(100000, 999999).ToString();
            var user_wifi = new UserWifi()
            {
                Pwd = Utility.MD5_Encrypt(pwd),
                SellerId = sellerId,
                UserId = userId,
                Expiry = DateTime.Now.AddDays(1)
            };
            var item = GeneralHelper.GetUserWifiItem(userId, sellerId);
            if (item.Id != 0)
                GeneralHelper.GenerateWifi(user_wifi);
            else
            {
                user_wifi.Id = item.Id;
                GeneralHelper.UpdateWifi(user_wifi);
            }

            var data = new
            {
                pwd = pwd,
                expir = user_wifi.Expiry
            };
            JsonTransfer jt = new JsonTransfer();
            jt.AddSuccessParam();
            Response.Write(DesEncrypt(jt).ToLower());
            Response.End();
        }


    }
}