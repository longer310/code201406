using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Backstage.Core;
using Backstage.Core.Entity;
using System.Net.Mail;

namespace Backstage.Handler
{
    public class LoginHandler : BaseHandler
    {
        public override void ProcessRequest(HttpContext context)
        {
            FreeActions = ",login,";
            base.ProcessRequest(HttpContext.Current);
            switch (Action)
            {
                case "login":
                    Login(); break;
                case "logout":
                    Logout(); break;
                case "getUserList":
                    GetUserList(); break;
                case "getpwd":
                    GetPwd();
                    break;
                default: break;
            }
        }

        private void GetPwd()
        {
            string mail = GetString("mail");
            //AccountHelper.GetUser()

            //var mSmtpClient = new SmtpClient();
            ////mSmtpClient.Host = "smtp." + mMailMessage.From.Host;
            //mSmtpClient.Host = 
            //mSmtpClient.Port = this.mSenderPort;
            //mSmtpClient.UseDefaultCredentials = false;
            //mSmtpClient.EnableSsl = this.mEnableSsl;
            //if (this.mEnablePwdAuthentication)
            //{
            //    System.Net.NetworkCredential nc = new System.Net.NetworkCredential(this.mSenderUsername, this.mSenderPassword);
            //    //mSmtpClient.Credentials = new System.Net.NetworkCredential(this.mSenderUsername, this.mSenderPassword);
            //    //NTLM: Secure Password Authentication in Microsoft Outlook Express
            //    mSmtpClient.Credentials = nc.GetCredential(mSmtpClient.Host, mSmtpClient.Port, "NTLM");
            //}
            //else
            //{
            //    mSmtpClient.Credentials = new System.Net.NetworkCredential(this.mSenderUsername, this.mSenderPassword);
            //}
            //mSmtpClient.DeliveryMethod = System.Net.Mail.SmtpDeliveryMethod.Network;
            //mSmtpClient.Send(mMailMessage);

        }
        private void Login()
        {
            //string str = DesAlgorithm.EncryptString("1235678");
            string userName = GetString("userName");
            string pwd = GetString("pwd");

            Account user = AccountHelper.FindUser(userName);
            JsonTransfer jt = new JsonTransfer();
            if (user == null)
                jt.SetError("不存在此用户");
            else if (user.Pwd != pwd)
                jt.SetError("密码错误");
            else
            {
                //设置已登录
                AccountHelper.SetLogOn(user.Id, true, AccountHelper.GetStringFromEntity(user), DateTime.Now.AddDays(1));
                jt.Add("success", "登录成功");
            }
            Response.Write(jt.ToJson());
        }

        private void Logout()
        {
            AccountHelper.SetLogOut();
            //Response.Redirect("../login.aspx");
            JsonTransfer jt = new JsonTransfer();
            jt.Add("success", "退出成功");
            Response.Write(jt.ToJson());
        }

        private void GetUserList()
        {
            string startTime = GetString("startTime");
            string endTime = GetString("endTime");

            var list = new List<Account>();
            list.Add(new Account() { Id = 1, UserName = "张三" });
            list.Add(new Account() { Id = 2, UserName = "李四" });

            Response.Write(JsonHelpr.ResponseData("1", "0", list));
        }
    }
}