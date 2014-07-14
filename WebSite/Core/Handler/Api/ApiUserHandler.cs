using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Security.Cryptography.X509Certificates;
using System.Web;
using System.Web.UI.WebControls.WebParts;
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
                case "thirdlogin"://登录接口
                    ThirdLogin();
                    break;
                case "usercharge"://登录接口
                    UserCharge();
                    break;
                case "getmymoney"://获取可用余额
                    GetMyMoney();
                    break;
                case "getmoneylog"://资金使用明细
                    GetMoneyLog();
                    break;
                case "getmerchant"://商家信息
                    GetMerchant();
                    break;
                case "getusercouponlist"://获取可兑换的电子券
                    GetUserCouponList();
                    break;
                case "getextcreditlog"://积分使用明细
                    GetExtcreditLog();
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

        #region 第三方登录
        public void ThirdLogin()
        {
            var username = GetString("username");
            var sex = GetInt("sex");
            var avatar = GetString("avatar");
            var sellerid = GetInt("sellerid");
            var openid = GetString("openid");
            var type = GetInt("type");

            var userbinding = AccountBindingHelper.GetAccountBindingByIdentity(openid);
            var user = new Account();
            if (userbinding == null)
            {//没有绑定 先添加用户
                userbinding = new AccountBinding();
                user.UserName = username;
                user.Pwd = "123456";
                user.RoleType = RoleType.ThirdUser;
                user.Avatar = avatar;
                user.Sex = (SexType)sex;
                user.SellerId = sellerid;

                var id = AccountHelper.UpdateUser(user);
                user.Id = id;
                if (id == 0)
                {
                    ReturnErrorMsg("添加账号失败");
                    return;
                }
                userbinding.Id = id;
                userbinding.AccountType = (AccountType)type;
                userbinding.UserIdentity = openid;
                //添加第三方绑定
                AccountBindingHelper.AddAccountBinding(userbinding);
            }
            else
            {//查找用户
                user = AccountHelper.GetUser(userbinding.Id);
                if (user == null)
                {
                    ReturnErrorMsg("账号异常");
                    return;
                }
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

        #region 充值金额
        public void UserCharge()
        {
            var uid = GetInt("uid");
            var money = GetInt("money");
            var pid = GetInt("pid");
            var sellerid = GetInt("sellerid");
            var orderid = GetString("orderid");//第三方订单号 使用字符串！

            var user = AccountHelper.GetUser(uid);
            if (user == null)
            {
                ReturnErrorMsg(string.Format("不存在Id={0}的用户", uid));
                return;
            }

            var clist = PaymentHelper.GetList(sellerid);
            if (clist == null)
            {
                ReturnErrorMsg("商户还没有充值类型列表");
                return;
            }
            var payMent = clist.FirstOrDefault(o => o.Id == pid);
            if (payMent == null)
            {
                ReturnErrorMsg("不存在该充值类型");
                return;
            }

            var chargeLog = new ChargeLog();
            chargeLog.UserId = uid;
            chargeLog.Money = money;
            chargeLog.Pid = pid;
            chargeLog.SellerId = sellerid;
            chargeLog.OrderId = orderid;
            chargeLog.PayName = payMent.Name;

            user.Money += money;
            //保存用户信息
            AccountHelper.UpdateUser(user);

            //记录充值记录
            ChargeLogHelper.AddChargeLog(chargeLog);

            ReturnCorrectMsg("添加余额成功");
        }
        #endregion

        #region 获取可用余额
        public class MyMoneyData
        {
            public float money { get; set; }
        }
        public void GetMyMoney()
        {
            var uid = GetInt("uid");
            var sellerid = GetInt("sellerid");

            var user = AccountHelper.GetUser(uid);
            if (user == null)
            {
                ReturnErrorMsg(string.Format("不存在Id={0}的用户", uid));
                return;
            }
            if (user.SellerId != sellerid)
            {
                ReturnErrorMsg("商户无此用户");
                return;
            }

            var data = new MyMoneyData();
            data.money = user.Money;

            JsonTransfer jt = new JsonTransfer();
            jt.AddSuccessParam();
            jt.Add("data", data);
            Response.Write(DesEncrypt(jt));
            Response.End();
        }
        #endregion

        #region 资金使用明细
        public class MoneyLogData
        {
            public List<MoneyLogItem> moneylogs { get; set; }

            public MoneyLogData()
            {
                moneylogs = new List<MoneyLogItem>();
            }
        }
        public class MoneyLogItem
        {
            public int createtime { get; set; }
            public string orderid { get; set; }
            public float money { get; set; }
        }
        public void GetMoneyLog()
        {
            var uid = GetInt("uid");
            var sellerid = GetInt("sellerid");
            var start = GetInt("start");
            var limit = GetInt("limit");

            var user = AccountHelper.GetUser(uid);
            if (user == null)
            {
                ReturnErrorMsg(string.Format("不存在Id={0}的用户", uid));
                return;
            }
            if (user.SellerId != sellerid)
            {
                ReturnErrorMsg("商户无此用户");
                return;
            }

            var data = new MoneyLogData();

            var result = ChargeLogHelper.GetChargeLogList(sellerid, uid, start * limit, limit);

            foreach (var chargeLog in result.Results)
            {
                var item = new MoneyLogItem();
                item.createtime = chargeLog.CreateTime.GetUnixTime();
                item.orderid = chargeLog.OrderId;
                item.money = chargeLog.Money;

                data.moneylogs.Add(item);
            }

            JsonTransfer jt = new JsonTransfer();
            jt.AddSuccessParam();
            jt.Add("data", data);
            Response.Write(DesEncrypt(jt));
            Response.End();
        }
        #endregion

        #region 商家信息
        public class MerchantData
        {
            /// <summary>
            /// 商户名称
            /// </summary>
            public string name { get; set; }
            /// <summary>
            /// 地址
            /// </summary>
            public string address { get; set; }
            /// <summary>
            /// 联系方式
            /// </summary>
            public string phone { get; set; }
            /// <summary>
            /// 简介描述
            /// </summary>
            public string description { get; set; }
            /// <summary>
            /// 商家地图url（百度地图手机网n站）
            /// </summary>
            public string mapurl { get; set; }
            /// <summary>
            /// 微信开发者 appid
            /// </summary>
            public int appid { get; set; }
            /// <summary>
            /// 微信开发者 app密码
            /// </summary>
            public string appsecret { get; set; }
            /// <summary>
            /// 微信token
            /// </summary>
            public string accesstoken { get; set; }
            /// <summary>
            /// 微信token有效期
            /// </summary>
            public int accessexpire { get; set; }
            /// <summary>
            /// 安卓下载地址
            /// </summary>
            public string androidurl { get; set; }
            /// <summary>
            /// ios下载地址
            /// </summary>
            public string iosurl { get; set; }
            /// <summary>
            /// 关注微信地址
            /// </summary>
            public string wxurl { get; set; }
        }
        public void GetMerchant()
        {
            var sellerid = GetInt("sellerid");

            var user = AccountHelper.GetUser(sellerid);
            if (user == null || user.RoleType != RoleType.Merchant)
            {
                ReturnErrorMsg("不存在该商户");
                return;
            }

            var merchant = MerchantHelper.GetMerchant(sellerid);
            if (merchant == null)
            {
                ReturnErrorMsg("没有商户信息");
                return;
            }

            var data = new MerchantData();
            data.name = merchant.Name;
            data.address = merchant.Address;
            data.phone = merchant.Phone;
            data.description = merchant.Description;
            data.mapurl = merchant.Mapurl;
            data.appid = merchant.AppId;
            data.appsecret = merchant.AppSecret;
            data.accesstoken = merchant.AccessToken;
            data.accessexpire = merchant.AccessExpire.GetUnixTime();
            data.androidurl = merchant.AndroidUrl;
            data.iosurl = merchant.IosUrl;
            data.wxurl = merchant.WxUrl;

            JsonTransfer jt = new JsonTransfer();
            jt.AddSuccessParam();
            jt.Add("data", data);
            Response.Write(DesEncrypt(jt));
            Response.End();
        }
        #endregion

        #region 获取用户优惠券列表
        public class UserCouponData
        {
            public int extcredit { get; set; }
            public List<CouponItem> couponlist { get; set; }

            public UserCouponData()
            {
                couponlist = new List<CouponItem>();
            }
        }
        public class CouponItem
        {
            public string title { get; set; }
            public string description { get; set; }
            public string img { get; set; }
            public int expiry { get; set; }
            public int extcredit { get; set; }
            public int sellerid { get; set; }
        }
        public void GetUserCouponList()
        {
            var uid = GetInt("uid");
            var sellerid = GetInt("sellerid");
            var start = GetInt("start");
            var limit = GetInt("limit");

            var user = AccountHelper.GetUser(uid);
            if (user == null)
            {
                ReturnErrorMsg(string.Format("不存在Id={0}的用户", uid));
                return;
            }
            if (user.SellerId != sellerid)
            {
                ReturnErrorMsg("商户无此用户");
                return;
            }
            var data = new UserCouponData();
            data.extcredit = user.Extcredit;

            var result = CouponHelper.GetUserCouponList(uid, sellerid, start * limit, limit);
            foreach (var coupon in result.Results)
            {
                var item = new CouponItem();
                item.title = coupon.Title;
                item.description = coupon.Description;
                item.img = coupon.ImgUrl;
                item.expiry = coupon.Expiry.GetUnixTime();
                item.sellerid = sellerid;

                data.couponlist.Add(item);
            }
            JsonTransfer jt = new JsonTransfer();
            jt.AddSuccessParam();
            jt.Add("data", data);
            Response.Write(DesEncrypt(jt));
            Response.End();
        }
        #endregion

        #region 资金使用明细
        public class ExtcreditLogData
        {
            public List<ExtcreditLogItem> extcreditlogs { get; set; }

            public ExtcreditLogData()
            {
                extcreditlogs = new List<ExtcreditLogItem>();
            }
        }
        public class ExtcreditLogItem
        {
            public int createtime { get; set; }
            public int sourceid { get; set; }
            public float extcredit { get; set; }
            public float type { get; set; }
        }
        public void GetExtcreditLog()
        {
            var uid = GetInt("uid");
            var sellerid = GetInt("sellerid");
            var start = GetInt("start");
            var limit = GetInt("limit");

            var user = AccountHelper.GetUser(uid);
            if (user == null)
            {
                ReturnErrorMsg(string.Format("不存在Id={0}的用户", uid));
                return;
            }
            if (user.SellerId != sellerid)
            {
                ReturnErrorMsg("商户无此用户");
                return;
            }

            var data = new ExtcreditLogData();

            var result = ExtcreditLogHelper.GetExtcreditLogList(sellerid, uid, start * limit, limit);

            foreach (var extcreditLog in result.Results)
            {
                var item = new ExtcreditLogItem();
                item.createtime = extcreditLog.CreateTime.GetUnixTime();
                item.sourceid = extcreditLog.SourceId;
                item.extcredit = extcreditLog.Extcredit;
                item.type = (int)extcreditLog.Type;

                data.extcreditlogs.Add(item);
            }

            JsonTransfer jt = new JsonTransfer();
            jt.AddSuccessParam();
            jt.Add("data", data);
            Response.Write(DesEncrypt(jt));
            Response.End();
        }
        #endregion

        #region 编辑收货信息
        public void UpdateUserInfo()
        {
            var uid = GetInt("uid");
            var sellerid = GetInt("sellerid");
        }
        #endregion
    }
}