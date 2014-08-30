using Backstage.Core.Entity;
using Backstage.Core.Logic;
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
                case "getpwdvercode":
                    GetPwdVerCode(); break;
                case "updatepwd":
                    UpdatePwd(); break;
                default: break;
            }
        }

        private void GetPwdVerCode()
        {
            string phone = GetString("phone");
            int sellerid = GetInt("sellerid");
            var user = AccountHelper.GetUserByPhone(phone, sellerid);
            if (user == null)
            {
                ReturnErrorMsg("手机号码不存在");
            }
            var merchant = MerchantHelper.GetMerchant(sellerid);
            if (merchant == null)
            {
                ReturnErrorMsg("不存在该商户");
                return;
            }

            var verificationCode = new VerificationCode();
            verificationCode.Phone = phone;
            verificationCode.SellerId = sellerid;
            verificationCode.Code = Utility.GetVerificationCode(6);
            verificationCode.ExpiredTime = DateTime.Now.AddMinutes(30);
            verificationCode.UserId = user.Id;
            VerificationCodeHelper.SaveVerificationCode(verificationCode);
            if (Utility._msg_opensend == "1")
                //Utility.SendMsg(verificationCode.Code, verificationCode.Phone, Utility._modifyphone_message);
            {
                SendMsgClass3 jsobject = new SendMsgClass3();
                jsobject.param1 = merchant.Name;
                jsobject.param2 = verificationCode.Code;
                jsobject.param3 = "30";

                if (Utility.SendMsg(verificationCode.Phone, MsgTempleId.UserRegisterCode, jsobject) != "发送成功")
                {
                    ReturnErrorMsg("短信发送失败");
                    return;
                }
            }
            ReturnCorrectMsg("请注意查收验证码");
        }

        private void UpdatePwd()
        {
            string phone = GetString("phone");
            int sellerid = GetInt("sellerid");
            string pwd = GetString("pwd");
            string code = GetString("code");

            var user = AccountHelper.GetUserByPhone(phone, sellerid);
            if (user == null)
            {
                ReturnErrorMsg("手机号码不存在");
            }
            var verificationCode = VerificationCodeHelper.GetVerificationCode(sellerid, phone, user.Id);

            if (verificationCode.ExpiredTime < DateTime.Now)
                ReturnErrorMsg("验证码已经过期了");
            if (code != verificationCode.Code)
                ReturnCorrectMsg("验证码错误");
            user.Pwd = pwd;
            AccountHelper.SaveAccount(user);
            ReturnCorrectMsg("密码修改成功");
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
            //int userId = GetInt("uid");
            int sellerId = GetInt("sellerid");
            string pwd = GetString("pwd");
            var user_wifi = new UserWifi()
            {
                Pwd = pwd,
                SellerId = sellerId
            };
            var item = GeneralHelper.GetUserWifiItem(pwd, sellerId);
            JsonTransfer jt = new JsonTransfer();
            if (item != null)
            {
                var data = new
                {
                    expir = item.Expiry.GetUnixTime()
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
                Pwd = pwd,
                SellerId = sellerId,
                UserId = userId,
                Expiry = DateTime.Now.AddDays(1)
            };
            var item = GeneralHelper.GetUserWifiItem(userId, sellerId);
            if (item == null)
                GeneralHelper.GenerateWifi(user_wifi);
            else
            {
                user_wifi.Id = item.Id;
                GeneralHelper.UpdateWifi(user_wifi);
            }

            var data = new
            {
                pwd = user_wifi.Pwd,
                expir = user_wifi.Expiry.GetUnixTime()
            };
            //JsonTransfer jt = new JsonTransfer();
            //jt.AddSuccessParam();
            //Response.Write(DesEncrypt(jt).ToLower());
            //Response.End();
            //返回信息
            ReturnCorrectData(data);
        }


    }
}