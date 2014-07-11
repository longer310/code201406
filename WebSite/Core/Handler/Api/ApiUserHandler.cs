using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Web;
using Backstage.Core;
using Backstage.Core.Entity;
using Backstage.Core.Handler;
using Backstage.Core.Logic;

namespace Backstage.Handler
{
    public class ApiUserHandler : BaseApiHandler
    {
        public override void ProcessRequest(HttpContext context)
        {
            base.SetApiName("ApiUserHandler");
            base.ProcessRequest(HttpContext.Current);
            switch (Action)
            {
                case "getregistercode"://首页
                    GetRegisterCode();
                    break;
                default: break;
            }

        }
        #region 获取注册验证码
        public void GetRegisterCode()
        {
            var phone = GetString("phone");
            var sellerId = GetInt("sellerid");

            var verificationCode = VerificationCodeHelper.GetVerificationCode(sellerId, phone);
            bool needgen = false;
            if (verificationCode == null)
            {
                verificationCode = new VerificationCode();
                verificationCode.Phone = phone;
                verificationCode.SellerId = sellerId;
                needgen = true;
            }
            else
            {
                if (verificationCode.ExpiredTime < DateTime.Now)
                    needgen = true;
            }
            if (needgen)
            {//重新生成验证码 和 过期时间
                verificationCode.Code = "111111"; //Utility.GetVerificationCode(6);
                verificationCode.ExpiredTime = DateTime.Now.AddSeconds(30);
            }
            //TODO:发送短信
            //保存验证信息
            VerificationCodeHelper.SaveVerificationCode(verificationCode);

            //返回
            ReturnCorrectMsg("注册码已发送");
        }
        #endregion
    }
}