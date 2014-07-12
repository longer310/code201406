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
                case "register"://注册
                    Register();
                    break;
                case "login"://登录接口
                    Login();
                    break;
                default: break;
            }

        }

        #region 获取注册验证码
        public void GetRegisterCode()
        {
            var phone = GetString("phone");
            var sellerId = GetInt("sellerid");

            var user = AccountHelper.FindUserByPhone(phone);
            if (string.IsNullOrEmpty(phone) || user != null)
            {
                ReturnErrorMsg("此电话已注册");
                return;
            }
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
                verificationCode.Code = Utility.GetVerificationCode(6);
                verificationCode.ExpiredTime = DateTime.Now.AddMinutes(30);
            }
            //发送短信
            if (Utility._msg_opensend == "1")
                Utility.SendMsg(verificationCode.Code, verificationCode.Phone);
            //保存验证信息
            VerificationCodeHelper.SaveVerificationCode(verificationCode);

            //返回
            ReturnCorrectMsg("注册码已发送");
        }
        #endregion

        #region 注册
        private void Register()
        {
            var phone = GetString("phone");
            var code = GetString("code");
            var username = GetString("username");
            var password = GetString("password");
            var sellerid = GetInt("sellerid");

            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(phone) || string.IsNullOrEmpty(code) ||
                string.IsNullOrEmpty(password) || sellerid == 0)
            {
                ReturnErrorMsg("参数有误");
                return;
            }

            if (AccountHelper.JudgeUser(phone, username))
            {
                ReturnErrorMsg("已存在该昵称或电话号码的用户");
                return;
            }

            if (!VerificationCodeHelper.JudgyVerificationCode(sellerid, phone, code))
            {
                ReturnErrorMsg("验证码错误或已过期");
                return;
            }


            var account = new Account();
            account.Phone = phone;
            account.UserName = username;
            account.Pwd = password;
            account.RoleType = RoleType.User;
            account.SellerId = sellerid;
            //保存用户
            AccountHelper.UpdateUser(account);

            ReturnCorrectMsg("注册成功");
        }
        #endregion

        #region 登录接口
        public class LoginData
        {
            public int uid { get; set; }
            public int sellerid { get; set; }
            public string phone { get; set; }
            public string username { get; set; }
            public int sex { get; set; }
            public string avatar { get; set; }
        }
        public void Login()
        {
            var phone = GetString("phone");
            var password = GetString("password");
            var sellerid = GetInt("sellerid");

            if (!AccountHelper.JudgeUserLogin(phone, password, sellerid))
            {
                ReturnErrorMsg("电话号码或密码错误");
                return;
            }

            var user = AccountHelper.FindUserByPhone(phone);
            if (user == null)
            {
                ReturnErrorMsg("该用户不存在");
                return;
            }

            var data = new LoginData();
            data.uid = user.Id;
            data.sellerid = user.SellerId;
            data.avatar = user.Avatar;
            data.phone = user.Phone;
            data.sex = (int)user.Sex;
            data.username = user.UserName;

            JsonTransfer jt = new JsonTransfer();
            jt.AddSuccessParam();
            jt.Add("data", data);
            Response.Write(DesEncrypt(jt));
            Response.End();
        }
        #endregion
    }
}