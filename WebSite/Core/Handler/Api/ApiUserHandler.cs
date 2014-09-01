using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Security.Cryptography.X509Certificates;
using System.Web;
using System.Web.UI.WebControls;
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
                case "getregistercode"://首页 7.1
                    GetRegisterCode();
                    break;
                case "register"://注册 7.2
                    Register();
                    break;
                case "login"://登录接口 7.3 
                    Login();
                    break;
                case "thirdlogin"://第三方登录接口 7.4
                    ThirdLogin(context);
                    break;
                case "usercharge"://充值金额 7.5
                    UserCharge();
                    break;
                case "getmymoney"://获取可用余额 7.6 
                    GetMyMoney();
                    break;
                case "getmoneylog"://资金使用明细 7.7
                    GetMoneyLog();
                    break;
                case "getmerchant"://商家信息 7.8
                    GetMerchant();
                    break;
                case "getusercouponlist"://获取用户的电子券 7.9
                    GetUserCouponList();
                    break;
                case "getextcreditlog"://积分使用明细 7.10
                    GetExtcreditLog();
                    break;
                case "updatereceiptinfo"://编辑收货信息 7.11
                    UpdateReceiptInfo();
                    break;
                case "getreceiptinfo"://获取收货信息 7.12
                    GetReceiptInfo();
                    break;
                case "getmycomment"://我的评论 7.13
                    GetMyComment();
                    break;
                case "delfavorite"://删除收藏 7.14
                    DelFavorite();
                    break;
                case "getorderslist"://获取未完成/历史订单 7.15
                    GetOrdersList();
                    break;
                case "modifypwd"://修改密码 7.16
                    ModifyPwd();
                    break;
                case "modifyphone"://更改绑定号码 7.17
                    ModifyPhone();
                    break;
                case "getmodifyphoneCode"://更改绑定号码_发送短信验证码 7.18
                    GetModifyPhoneCode();
                    break;
                case "modifyuserinfo"://会员资料提交 7.19
                    ModifyUserInfo(context);
                    break;
                case "getuserinfo"://获取会员信息 7.20
                    GetUserInfo();
                    break;
                case "userregist"://签到接口 7.21
                    UserRegist();
                    break;
                case "delmycommentlist"://删除我的评论列表 7.22
                    DelMyCommentList();
                    break;
                case "myfavorite"://我的收藏 7.23（7.20日补充的 by lintao)
                    MyFavorite();
                    break;
                case "getordercouponlist"://获取可兑换的电子券 7.24
                    GetOrderCouponList();
                    break;
                case "modifymerchant"://更新商户信息 7.25
                    ModifyMerchant();
                    break;
                //case "addpaypalrecord":// 支付宝同步返回接口 11
                //    AddPaypalRecord();
                //    break;
                default: break;
            }
        }

        //private void AddPaypalRecord()
        //{
        //    var orderid = GetInt("orderid");
        //    var status = GetString("status");
        //    var trade_no = GetString("trade_no");

        //    var paypalRecord = new PaypalRecord();
        //    paypalRecord.OrderId = orderid;
        //    paypalRecord.Status = status;
        //    paypalRecord.Trade_no = trade_no;
        //    if(PaypalRecordHelper.AddPaypalRecord(paypalRecord))
        //        ReturnCorrectMsg("同步成功");
        //    else ReturnErrorMsg("同步失败");
        //}

        #region 返回积分的公用类
        public class IntegralData
        {
            public int integral { get; set; }

            public IntegralData(int i)
            {
                integral = i;
            }
        }
        #endregion

        #region 获取注册验证码 7.1
        public void GetRegisterCode()
        {
            var phone = GetString("phone");
            var sellerId = GetInt("sellerid");

            if (string.IsNullOrEmpty(phone))
            {
                ReturnErrorMsg("phone参数没传");
                return;
            }
            var user = AccountHelper.FindUserByPhone(phone);
            if (user != null)
            {
                ReturnErrorMsg("此电话已注册");
                return;
            }
            var merchant = MerchantHelper.GetMerchant(sellerId);
            if (merchant == null)
            {
                ReturnErrorMsg("不存在该商户");
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
                //Utility.SendMsg(verificationCode.Code, verificationCode.Phone, Utility._register_message);
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
            //保存验证信息
            VerificationCodeHelper.SaveVerificationCode(verificationCode);

            //返回
            ReturnCorrectMsg("注册码已发送");
        }
        #endregion

        #region 注册 7.2
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
            account.NickName = username;//默认等于用户名
            account.Pwd = password;
            account.RoleType = RoleType.User;
            account.SellerId = sellerid;
            //保存用户
            AccountHelper.SaveAccount(account);

            ReturnCorrectMsg("注册成功");
        }
        #endregion

        #region 登录接口 7.3
        public class LoginData
        {
            public int uid { get; set; }
            public int sellerid { get; set; }
            public string phone { get; set; }
            public string nickname { get; set; }
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
            data.nickname = user.NickName;

            //修改登录次数
            user.TotalLoginCount++;
            user.LastLoginTime = DateTime.Now;
            AccountHelper.SaveAccount(user);

            //返回信息
            ReturnCorrectData(data);
        }
        #endregion

        #region 第三方登录 7.4
        public void ThirdLogin(HttpContext context)
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
                user.Avatar = avatar;
                user.RoleType = RoleType.ThirdUser;
                user.Sex = (SexType)sex;
                user.SellerId = sellerid;

                var id = AccountHelper.SaveAccount(user);
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
            data.nickname = user.NickName;

            //修改登录次数
            user.TotalLoginCount++;
            user.LastLoginTime = DateTime.Now;
            AccountHelper.SaveAccount(user);

            //返回信息
            ReturnCorrectData(data);
        }
        #endregion

        #region 充值金额 7.5
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
            var payMent = PaymentHelper.GetPayment(pid);
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

            //记录充值记录
            var rid = ChargeLogHelper.AddChargeLog(chargeLog);


            //user.Integral = rid; //log.Extcredit;

            //user.Money += money;
            //user.TotalRecharge += money;
            //保存用户信息
            //AccountHelper.SaveAccount(user);

            //返回信息 为充值记录的id
            ReturnCorrectData(new IntegralData(rid));
        }
        #endregion

        #region 获取可用余额 7.6
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

            //返回信息
            ReturnCorrectData(data);
        }
        #endregion

        #region 资金使用明细 7.7
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

            //返回信息
            ReturnCorrectData(data);
        }
        #endregion

        #region 商家信息 7.8
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
            public string appid { get; set; }
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
            /// <summary>
            /// 位置信息
            /// </summary>
            public string pointx { get; set; }

            public string pointy { get; set; }
            public int mertypeid { get; set; }
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
            data.pointx = merchant.PointX;
            data.pointy = merchant.PointY;
            //商户类型
            data.mertypeid = (int)merchant.MerType;

            //返回信息
            ReturnCorrectData(data);
        }
        #endregion

        #region 获取用户优惠券列表 7.9
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
            public int id { get; set; }
            public string title { get; set; }
            public string description { get; set; }
            public string img { get; set; }
            public int expiry { get; set; }
            public int extcredit { get; set; }
            public int sellerid { get; set; }
            public int status { get; set; }
        }
        public void GetUserCouponList()
        {
            var uid = GetInt("uid");
            var sellerid = GetInt("sellerid");
            var start = GetInt("start");
            var limit = GetInt("limit");
            var status = GetInt("status");

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
            data.extcredit = user.Integral;

            var result = CouponHelper.GetUserCouponList(uid, sellerid, start * limit, limit, status);
            foreach (var coupon in result.Results)
            {
                var item = new CouponItem();
                item.id = coupon.Id;
                item.title = coupon.Title;
                item.description = coupon.Description;
                item.img = coupon.ImgUrl;
                item.expiry = coupon.Expiry.GetUnixTime();
                item.sellerid = sellerid;
                item.status = coupon.Status;

                data.couponlist.Add(item);
            }

            //返回信息
            ReturnCorrectData(data);
        }
        #endregion

        #region 积分使用明细 7.10
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
            public int type { get; set; }
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

            //返回信息
            ReturnCorrectData(data);
        }
        #endregion

        #region 编辑收货信息 7.11
        public void UpdateReceiptInfo()
        {
            var uid = GetInt("uid");
            var sellerid = GetInt("sellerid");
            var linkman = GetString("linkman");
            var phone = GetString("phone");
            var address = GetString("address");

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
            user.LinkMan = linkman;
            user.Phone = phone;
            user.Address = address;

            //保存收获信息
            AccountHelper.SaveAccount(user);

            ReturnCorrectMsg("编辑成功");
        }
        #endregion

        #region 获取收货信息 7.12
        public class ReceiptInfoData
        {
            public string linkMan { get; set; }
            public string phone { get; set; }
            public string address { get; set; }
            public int sellerid { get; set; }
        }
        public void GetReceiptInfo()
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
            var data = new ReceiptInfoData();
            data.linkMan = user.LinkMan;
            data.phone = user.Phone;
            data.address = user.Address;
            data.sellerid = sellerid;

            //返回信息
            ReturnCorrectData(data);
        }
        #endregion

        #region 我的评论 7.13
        public class MyCommentData
        {
            public List<MyCommentItem> commmentlist { get; set; }

            public MyCommentData()
            {
                commmentlist = new List<MyCommentItem>();
            }
        }
        public class MyCommentItem
        {
            public int id { get; set; }
            public int createtime { get; set; }
            public int type { get; set; }
            public string content { get; set; }
            public string img { get; set; }
            public string title { get; set; }
        }
        public void GetMyComment()
        {
            var uid = GetInt("uid");
            var sellerid = GetInt("sellerid");
            var start = GetInt("start");
            var limit = GetInt("limit");
            var type = (CommentType)GetInt("type");

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

            var data = new MyCommentData();
            var ucommentlist = CommentHelper.GetList(uid, sellerid, type, start * limit, limit);
            foreach (var c in ucommentlist.Results)
            {
                var item = new MyCommentItem();
                item.id = c.Id;
                item.createtime = c.CreateTime.GetUnixTime();
                item.type = (int)c.Type;
                item.content = c.Content;
                item.img = c.Img;
                item.title = c.Title;

                data.commmentlist.Add(item);
            }

            //返回信息
            ReturnCorrectData(data);
        }
        #endregion

        #region 删除收藏 7.14
        public void DelFavorite()
        {
            var uid = GetInt("uid");
            var sellerId = GetInt("sellerid");
            var gids = GetString("gids");

            if (!CheckUserByIdAndSellerId(uid, sellerId)) return;

            var gidlist = Utility.GetListint(gids);
            if (gidlist.Count == 0)
            {
                ReturnErrorMsg("物品id列表传参错误");
                return;
            }
            var favorite = FavoriteHelper.GetFavorite(uid);

            foreach (var i in gidlist)
            {
                if (favorite.GidList.Contains(i))
                    favorite.GidList.Remove(i);
                else
                {
                    ReturnErrorMsg(string.Format("传参出错，会员没有收藏id为{0}的物品", i));
                    return;
                }
                var goods = GoodsHelper.GetGoods(i);
                goods.FavCount--;
                //保存商品收藏个数
                GoodsHelper.SaveGoods(goods);
            }

            FavoriteHelper.SaveFavorite(favorite);

            ReturnCorrectMsg("删除收藏成功");
        }
        #endregion

        #region 未完成订单/历史订单 7.15
        public class OrdersListData
        {
            public List<ApiGoodsHandler.OrderDetailData> orderslist { get; set; }

            public OrdersListData()
            {
                orderslist = new List<ApiGoodsHandler.OrderDetailData>();
            }
        }
        public void GetOrdersList()
        {
            var uid = GetInt("uid");
            var sellerid = GetInt("sellerid");
            var start = GetInt("start");
            var limit = GetInt("limit");

            if (!CheckUserByIdAndSellerId(uid, sellerid)) return;

            string wheresql = string.Format(" where Status > 0 and UserId={0} and SellerId={1} ", uid, sellerid);
            var orderslist = OrdersHelper.GetOrdersList(wheresql, "", start * limit, limit, 0);
            var data = new OrdersListData();
            foreach (var orderse in orderslist.Results)
            {
                data.orderslist.Add(new ApiGoodsHandler.OrderDetailData(orderse));
            }

            //返回信息
            ReturnCorrectData(data);
        }
        #endregion

        #region 修改密码 7.16
        public void ModifyPwd()
        {
            var uid = GetInt("uid");
            var sellerid = GetInt("sellerid");
            var oldpwd = GetString("oldpwd");
            var newpwd = GetString("newpwd");

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

            if (!user.Pwd.Equals(oldpwd))
            {
                ReturnErrorMsg("原密码错误");
                return;
            }
            if (oldpwd.Equals(newpwd))
            {
                ReturnErrorMsg("密码未改变");
                return;
            }
            if (newpwd.Length < 3 || newpwd.Length > 20)
            {
                ReturnErrorMsg("密码长度为3~20个字符");
                return;
            }

            user.Pwd = newpwd;
            AccountHelper.SaveAccount(user);

            ReturnCorrectMsg("修改密码成功");
        }
        #endregion

        #region 更改绑定号码 7.17
        private void ModifyPhone()
        {
            var uid = GetInt("uid");
            var code = GetString("code");
            var sellerid = GetInt("sellerid");

            if (string.IsNullOrEmpty(code) || sellerid == 0)
            {
                ReturnErrorMsg("参数有误");
                return;
            }

            var user = AccountHelper.GetUser(uid);
            if (user == null)
            {
                ReturnErrorMsg(string.Format("不存在Id={0}的用户", uid));
                return;
            }
            var verificationCode = VerificationCodeHelper.GetVerificationCodeByUid(sellerid, uid);

            if (verificationCode == null)
            {
                ReturnErrorMsg("验证码错误或已过期");
                return;
            }

            user.Phone = verificationCode.Phone;
            //保存用户
            AccountHelper.SaveAccount(user);

            ReturnCorrectMsg("更改绑定号码成功");
        }
        #endregion

        #region 更改绑定号码_发送短信验证码 7.18
        public void GetModifyPhoneCode()
        {
            var phone = GetString("phone");
            var sellerId = GetInt("sellerid");
            var uid = GetInt("uid");

            var user = AccountHelper.GetUser(uid);
            if (user == null)
            {
                ReturnErrorMsg(string.Format("不存在Id={0}的用户", uid));
                return;
            }
            if (string.IsNullOrEmpty(phone))
            {
                ReturnErrorMsg("传参错误，电话为空");
                return;
            }
            var euser = AccountHelper.FindUserByPhone(phone);
            if (euser != null)
            {
                ReturnErrorMsg("此电话已注册");
                return;
            }
            var merchant = MerchantHelper.GetMerchant(sellerId);
            if (merchant == null)
            {
                ReturnErrorMsg("不存在该商户");
                return;
            }
            var verificationCode = VerificationCodeHelper.GetVerificationCode(sellerId, phone, uid);
            bool needgen = false;
            if (verificationCode == null)
            {
                verificationCode = new VerificationCode();
                verificationCode.Phone = phone;
                verificationCode.SellerId = sellerId;
                verificationCode.UserId = uid;
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
                //Utility.SendMsg(verificationCode.Code, verificationCode.Phone, Utility._modifyphone_message);
            {
                SendMsgClass3 jsobject = new SendMsgClass3();
                jsobject.param1 = merchant.Name;
                jsobject.param2 = verificationCode.Code;
                jsobject.param3 = "30";

                if (Utility.SendMsg(verificationCode.Phone, MsgTempleId.UserModifyPhone, jsobject) != "发送成功")
                {
                    ReturnErrorMsg("短信发送失败");
                    return;
                }
            }
            //保存验证信息
            VerificationCodeHelper.SaveVerificationCode(verificationCode);

            //返回
            ReturnCorrectMsg("验证码已发送");
        }
        #endregion

        #region 会员资料提交 7.19
        public void ModifyUserInfo(HttpContext context)
        {
            var avatar = GetString("avatar");
            var username = GetString("username");
            var nickname = GetString("nickname");
            var uid = GetInt("uid");
            var sex = GetInt("sex");
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

            if (!string.IsNullOrEmpty(avatar))
            {//保存头像
                user.Avatar = Utility.GetAvatar(context, uid, avatar);
                //var dirPath = context.Server.MapPath(string.Format("../../File/{0}/image/", uid));
                //if (!Directory.Exists(dirPath))
                //{
                //    Directory.CreateDirectory(dirPath);
                //}
                //Utility.Base64StringToImage(avatar, dirPath + "head");
                //user.Avatar = Utility._domainurl + "/File/" + uid + "/image/head.jpg";
            }

            user.Sex = (SexType)sex;
            user.UserName = username;
            if (nickname != "")
                user.NickName = nickname;
            AccountHelper.SaveAccount(user);

            //返回
            ReturnCorrectMsg("更新会员资料成功");
        }
        #endregion

        #region 获取会员信息 7.20
        public class UserInfoData
        {
            public string username { get; set; }
            public string phone { get; set; }
            public string avatar { get; set; }
            public int sex { get; set; }
            public float money { get; set; }
            public int integral { get; set; }
            public int sellerid { get; set; }
            public int signin { get; set; }
            public int signintegral { get; set; }

            public string nickname { get; set; }
        }
        public void GetUserInfo()
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
            var data = new UserInfoData();
            data.username = user.UserName;
            data.nickname = user.NickName;
            data.phone = user.Phone;
            data.avatar = user.Avatar;
            data.sex = (int)user.Sex;
            data.money = user.Money;
            data.integral = user.Integral;
            data.sellerid = user.SellerId;
            var sourceId = DateTime.Today.GetUnixTime();
            if (ExtcreditLogHelper.JudgeExtcreditGet(ExtcreditSourceType.Register, sourceId, uid))
                data.signin = 1;
            data.signintegral = ParamHelper.ExtcreditCfgData.Register;

            //返回信息
            ReturnCorrectData(data);
        }
        #endregion

        #region 签到接口 7.21
        public void UserRegist()
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

            ExtcreditLog log = new ExtcreditLog();
            var sourceId = DateTime.Today.GetUnixTime();
            if (!ExtcreditLogHelper.JudgeExtcreditGet(ExtcreditSourceType.Register, sourceId, uid))
            {
                //积分获得
                log.UserId = uid;
                log.SellerId = user.SellerId;
                log.SourceId = sourceId;
                log.Extcredit = ParamHelper.ExtcreditCfgData.Register;
                log.Type = ExtcreditSourceType.Register;

                ExtcreditLogHelper.AddExtcreditLog(log);

                user.Integral += log.Extcredit;
                AccountHelper.SaveAccount(user);
            }
            else
            {
                ReturnErrorMsg("今日已签到");
                return;
            }

            //返回信息
            ReturnCorrectData(new IntegralData(log.Extcredit));
        }
        #endregion

        #region 删除评论列表 7.22
        public void DelMyCommentList()
        {
            var uid = GetInt("uid");
            var ids = GetString("ids");

            var user = AccountHelper.GetUser(uid);
            if (user == null)
            {
                ReturnErrorMsg(string.Format("不存在Id={0}的用户", uid));
                return;
            }
            var idList = Utility.GetListint(ids);
            if (idList.Count == 0)
            {
                ReturnErrorMsg("参数错误，无id列表");
                return;
            }

            var list = CommentHelper.GetList(uid, ids);
            if (list.Count != idList.Count)
            {
                ReturnErrorMsg("存在不属于该用户的评论id或者找不到该id的评论");
                return;
            }
            //删除评论
            CommentHelper.DelList(uid, ids);

            ReturnCorrectMsg("删除评论成功");
        }
        #endregion

        #region 我的收藏7.23
        public class MyFavoriteData
        {
            public int num { get; set; }
            public List<MyFavoriteItem> lists { get; set; }

            public MyFavoriteData()
            {
                lists = new List<MyFavoriteItem>();
            }
        }
        public class MyFavoriteItem
        {
            public int gid { get; set; }
            public string img { get; set; }
            public string title { get; set; }
            public float nowprice { get; set; }
            public float originalprice { get; set; }
            public int sales { get; set; }
            public string content { get; set; }
        }
        private void MyFavorite()
        {
            var uid = GetInt("uid");
            var start = GetInt("start");
            var limit = GetInt("limit");
            var user = AccountHelper.GetUser(uid);
            if (user == null)
            {
                ReturnErrorMsg(string.Format("不存在Id={0}的用户", uid));
                return;
            }
            var favorite = FavoriteHelper.GetFavorite(uid);
            var gidList = favorite.GidList.Skip(start * limit).Take(limit).ToList();
            var data = new MyFavoriteData();
            data.num = favorite.GidList.Count;
            if (gidList.Count > 0)
            {
                var wheresql = string.Format(" and Id in({0})", Utility.GetString(gidList));
                var goodslist = GoodsHelper.GetGoodsList(user.SellerId, wheresql).Results;
                foreach (var goods in goodslist)
                {
                    //Goods goods = GoodsHelper.GetGoods(gid);
                    var o = new MyFavoriteItem()
                    {
                        gid = goods.Id,
                        img = goods.LogoUrl,
                        title = goods.Title,
                        nowprice = goods.Nowprice,
                        originalprice = goods.OriginalPrice,
                        sales = goods.Sales,
                        content = goods.Content
                    };
                    data.lists.Add(o);
                }
            }

            //返回信息
            ReturnCorrectData(data);
        }
        #endregion

        #region 获取可用于订单的优惠券列表 7.24
        public void GetOrderCouponList()
        {
            var uid = GetInt("uid");
            var sellerid = GetInt("sellerid");
            var orderid = GetInt("orderid");

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
            var orders = OrdersHelper.GetOrders(orderid);
            if (orders == null)
            {
                ReturnErrorMsg(string.Format("不存在Id={0}的订单", orderid));
                return;
            }
            var gids = Utility.GetString(orders.GidList);
            var data = new UserCouponData();
            data.extcredit = user.Integral;

            var result = CouponHelper.GetOrderCouponList(uid, sellerid, gids);
            foreach (var coupon in result.Results)
            {
                if (coupon.FullMoney <= orders.StotalPrice)
                {
                    var item = new CouponItem();
                    item.id = coupon.Id;
                    item.title = coupon.Title;
                    item.description = coupon.Description;
                    item.img = coupon.ImgUrl;
                    item.expiry = coupon.Expiry.GetUnixTime();
                    item.sellerid = sellerid;

                    data.couponlist.Add(item);
                }
            }

            //返回数据
            ReturnCorrectData(data);
        }
        #endregion

        #region 更新商户信息 7.25
        public void ModifyMerchant()
        {
            var accesstoken = GetString("accesstoken");
            var sellerid = GetInt("sellerid");
            var accessexpire = GetInt("accessexpire");

            var merchant = MerchantHelper.GetMerchant(sellerid);
            if (merchant == null)
            {
                ReturnErrorMsg(string.Format("不存在Id={0}的商户", sellerid));
                return;
            }
            merchant.AccessExpire = Utility.FromUnixTime(accessexpire);
            merchant.AccessToken = accesstoken;

            MerchantHelper.SaveMerchant(merchant);

            ReturnCorrectMsg("更新商户信息成功");
        }
        #endregion
    }
}