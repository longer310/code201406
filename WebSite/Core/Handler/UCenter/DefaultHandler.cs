using System;
using System.Collections.Generic;
using System.EnterpriseServices;
using System.Linq;
using System.Web;
using Backstage.Core;
using Backstage.Core.Entity;
using Backstage.Core.Logic;

namespace Backstage.Handler
{
    public class DefaultHandler : BaseHandler
    {
        public override void ProcessRequest(HttpContext context)
        {
            base.ProcessRequest(HttpContext.Current);
            switch (Action)
            {
                case "getManagerList":
                    GetManagerList(); break;
                case "updatedata":
                    UpdateData(); break;
                case "deldata":
                    DelData(); break;
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

            var verificationCode = new VerificationCode();
            verificationCode.Phone = phone;
            verificationCode.SellerId = sellerid;
            verificationCode.Code = Utility.GetVerificationCode(6);
            verificationCode.ExpiredTime = DateTime.Now.AddMinutes(30);
            verificationCode.UserId = user.Id;
            VerificationCodeHelper.SaveVerificationCode(verificationCode);
            if (Utility._msg_opensend == "1")
                Utility.SendMsg(verificationCode.Code, verificationCode.Phone, Utility._modifyphone_message);
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
            AccountHelper.UpdateUser(user);
            ReturnCorrectMsg("密码修改成功");
        }

        private void GetManagerList()
        {
            JsonTransfer jt = new JsonTransfer();
            var user = AccountHelper.GetCurUser();
            if (user.RoleType != RoleType.SuperManage)
            {
                jt.SetError("无权限");
                Response.Write(jt.ToJson());
                return;
            }

            int pageIndex = GetInt("pageIndex");
            int pageSize = GetInt("pageSize");
            int totalnum;
            var list = AccountHelper.GetUserList(out totalnum, " where (RoleType = 2 or RoleType = 3) ", "",
                pageIndex * pageSize, pageSize);

            jt.Add("list", list);
            jt.Add("count", totalnum);
            jt.Add("curcount", list.Count);
            Response.Write(jt.ToJson());
        }

        private void UpdateData()
        {
            JsonTransfer jt = new JsonTransfer();
            var user = AccountHelper.GetCurUser();
            if (user.RoleType != RoleType.SuperManage)
            {
                jt.SetError("无权限");
                Response.Write(jt.ToJson());
                return;
            }

            Account account = new Account();
            account.Id = GetInt("id");
            account.RoleType = (RoleType)GetInt("roletype");
            account.UserName = GetString("username");
            account.Pwd = GetString("pwd");
            account.Avatar = GetString("avatar");
            account.Sex = (SexType)GetInt("sex");
            account.CreateTime = GetTime("createtime");

            int num = AccountHelper.UpdateUser(account);
            jt.Add("num", num);
            Response.Write(jt.ToJson());
        }

        private void DelData()
        {
            JsonTransfer jt = new JsonTransfer();
            var user = AccountHelper.GetCurUser();
            if (user.RoleType != RoleType.SuperManage)
            {
                jt.SetError("无权限");
                Response.Write(jt.ToJson());
                return;
            }
            int id = GetInt("id");

            int num = AccountHelper.DelUser(id);
            jt.Add("num", num);
            Response.Write(jt.ToJson());
        }
    }
}