﻿using System;
using System.Collections.Generic;
using System.EnterpriseServices;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Xml.Serialization;
using Backstage.Core;
using Backstage.Core.Entity;
using Backstage.Core.Handler;
using Backstage.Core.Logic;
using Backstage.View.User;

namespace Backstage.Handler
{
    public class UserHandler : BaseHandler
    {
        public override void ProcessRequest(HttpContext context)
        {
            //FreeActions = ",saveGoodsList,";
            RoleType = RoleType.Merchant;//需商家管理权限 暂定权限管理
            base.ProcessRequest(HttpContext.Current);
            switch (Action)
            {
                #region 会员列表
                case "getUserList":
                    GetUserList(); break;
                case "getUserDetail":
                    GetUserDetail(); break;
                case "delUserList":
                    DelUserList(); break;
                case "saveUser":
                    SaveUser(); break;
                #endregion

                #region 商户广告设置
                case "getAdCfg":
                    GetAdCfg(); break;
                case "saveAdCfg":
                    SaveAdCfg(); break;
                #endregion

                default: break;
            }
        }

        #region 会员列表
        /// <summary>
        /// 获取订单列表
        /// </summary>
        public void GetUserList()
        {
            int start = GetInt("start");
            int limit = GetInt("limit");

            string wheresql = string.Format(" where SellerId = {0} and Status = 0", CurSellerId);
            var result = AccountHelper.GetUserList(wheresql, "", start * limit, limit, 1);
            //var list = new List<OrdersItem>();
            //foreach (var item in result.Results)
            //{
            //    var i = new OrdersItem();
            //    i.Id = item.Id;
            //    i.UserId = item.UserId;
            //    i.Money = item.TotalPrice;
            //    i.CreateTime = item.CreateTime.ToString("yyyy-M-d HH:mm:ss");
            //    i.GoodsCount = item.NumList.Sum(o => o);
            //    i.Status = (int)item.GetReqStatus();
            //    i.Type = (int)item.OrderType;

            //    list.Add(i);
            //}

            var jt = new JsonTransfer();
            jt.Add("list", result.Results);
            jt.Add("count", result.TotalCount);
            Response.Write(jt.ToJson());
            Response.End();
        }

        public class RetUserDetail
        {
            public Account User { get; set; }
            public List<UserLevel> UserLevels { get; set; }
        }
        /// <summary>
        /// 获取用户详情
        /// </summary>
        public void GetUserDetail()
        {
            var userid = GetInt("userid");
            var user = AccountHelper.GetUser(userid);
            if (user == null)
            {
                ReturnErrorMsg("用户不存在");
                return;
            }
            if (user.SellerId == 0 && CurrentUser.RoleType > RoleType.Manage)
            {
                ReturnErrorMsg("无权访问该商户");
                return;
            }
            var data = new RetUserDetail();
            data.User = user;
            data.UserLevels = SystemHelper.GetUserLevels(user.SellerId).ToList();

            var jt = new JsonTransfer();
            jt.Add("data", data);
            Response.Write(jt.ToJson());
            Response.End();
        }

        /// <summary>
        /// 删除会员列表
        /// </summary>
        public void DelUserList()
        {
            var userids = GetString("ids");
            var useridList = Utility.GetListint(userids);
            if (useridList.Count == 0)
            {
                ReturnErrorMsg("需传用户id");
                return;
            }
            var wheresql = Utility.GetWhereSql(useridList);
            var userList = AccountHelper.GetUserList(wheresql);
            if (userList == null || useridList.Count() != userList.Results.Count)
            {
                ReturnErrorMsg("会员不存在");
                return;
            }
            if (userList.Results.Any(o => o.Status < 0))
            {
                ReturnErrorMsg("已有会员已删除");
                return;
            }

            if (AccountHelper.DelUserList(useridList))
                ReturnCorrectMsg("删除成功");
            else
                ReturnErrorMsg("删除失败");
        }

        /// <summary>
        /// 保存会员
        /// </summary>
        public void SaveUser()
        {
            var uid = GetInt("uid");
            var discount = GetFloat("discount");
            var roletype = GetInt("roletype");
            var remark = GetString("remark");
            var user = AccountHelper.GetUser(uid);
            if (user == null)
            {
                ReturnErrorMsg(string.Format("不存在Id={0}的用户", uid));
                return;
            }

            user.Discount = discount;
            user.RoleType = (RoleType)((int)(user.RoleType) / 10 * 10 + roletype);
            user.Remark = remark;

            if (AccountHelper.SaveAccount(user) > 0)
                ReturnCorrectMsg("保存成功");
            else
                ReturnErrorMsg("保存失败");
        }
        #endregion

        #region 商户广告设置
        /// <summary>
        /// 获取商户广告配置
        /// </summary>
        public void GetAdCfg()
        {
            var merchant = MerchantHelper.GetMerchant(CurSellerId);
            if (merchant == null)
            {
                ReturnErrorMsg("不存在改id的商户");
                return;
            }
            //var cfg = ParamHelper.GetMerchantCfgData(CurSellerId, merchant.Name);//ParamHelper.MerchantCfgData;

            var jt = new JsonTransfer();
            jt.Add("data", merchant);
            var str = jt.ToJson();
            Response.Write(str);
            Response.End();
        }
        /// <summary>
        /// 商户广告设置
        /// </summary>
        public void SaveAdCfg()
        {
            var type = GetInt("type");
            var imgs = GetString("imgs");
            var staytime = GetInt("staytime");
            var jumpurls = GetString("jumpurls");
            var types = GetString("types");
            var typeids = GetString("typeids");

            if (type > 2 || string.IsNullOrEmpty(imgs) || staytime == 0)
            {
                ReturnErrorMsg("传参有误");
                return;
            }

            var merchant = MerchantHelper.GetMerchant(CurSellerId);
            if (merchant == null)
            {
                ReturnErrorMsg("不存在改id的商户");
                return;
            }
            //var cfg = ParamHelper.GetMerchantCfgData(CurSellerId, merchant.Name);
            if (type == 0)
            {
                //登录页广告设置
                merchant.LoginAdStayTime = staytime;
                merchant.LoginAdUrl = imgs;
            }
            else if (type == 1)
            {
                //wifi广告
                merchant.WifiAdStayTime = staytime;
                var list = Utility.GetListstring(imgs);
                var jumplist = Utility.GetListstring(jumpurls);
                if (list.Count == 0 || jumplist.Count == 0 || list.Count != jumplist.Count)
                {
                    ReturnErrorMsg("传参有误");
                    return;
                }
                merchant.WifiAds = new List<PicJumpItem>();
                var i = 0;
                foreach (var str in list)
                {
                    var pitem = new PicJumpItem();
                    pitem.PicUrl = str;
                    pitem.JumpUrl = jumplist[i];
                    merchant.WifiAds.Add(pitem);
                    i++;
                }
            }
            else
            {
                //轮播广告
                merchant.SlideAdStayTime = staytime;
                var list = Utility.GetListstring(imgs);
                var typelist = Utility.GetListstring(types);
                var typeidlist = Utility.GetListstring(typeids);
                if (typelist.Count == 0 || list.Count == 0 || typeidlist.Count == 0 || typelist.Count != typeidlist.Count || list.Count != typeidlist.Count)
                {
                    ReturnErrorMsg("传参有误");
                    return;
                }
                merchant.SlideAds = new List<SlideAdItem>();
                var i = 0;
                foreach (var str in typelist)
                {
                    var sitem = new SlideAdItem();
                    sitem.img = list[i];
                    sitem.type = Convert.ToInt32(str);
                    sitem.typeid = Convert.ToInt32(typeidlist[i]);
                    merchant.SlideAds.Add(sitem);
                    i++;
                }
            }

            //ParamHelper.SaveParamvalue("MerchantCfg", cfg);
            //ParamHelper.UpdateMerchantCfg(CurSellerId, cfg);
            MerchantHelper.SaveMerchant(merchant);

            ReturnCorrectMsg("更改成功");
        }
        #endregion
    }
}
