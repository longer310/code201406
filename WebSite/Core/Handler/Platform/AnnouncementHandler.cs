using System;
using System.Collections.Generic;
using System.EnterpriseServices;
using System.Linq;
using System.Runtime.InteropServices.WindowsRuntime;
using System.Security.Permissions;
using System.Web;
using System.Web.Script.Serialization;
using System.Xml.Serialization;
using Backstage.Core;
using Backstage.Core.Entity;
using Backstage.Core.Logic;
using Backstage.View.Dev.Merchant;
using Backstage.View.User;

namespace Backstage.Handler
{
    public class AnnouncementHandler : BaseHandler
    {
        public override void ProcessRequest(HttpContext context)
        {
            //FreeActions = ",saveGoodsList,";
            RoleType = RoleType.Manage;//需管理员权限 暂定权限管理
            base.ProcessRequest(HttpContext.Current);
            switch (Action)
            {
                #region 公告
                case "getAnnouncemmentList":
                    GetAnnouncemmentList(); break;
                case "delAnnouncemmentList":
                    DelAnnouncemmentList(); break;
                case "addAnnouncemment":
                    AddAnnouncemment(); break;
                #endregion

                #region 平台广告设置
                case "getAdCfg":
                    GetAdCfg(); break;
                case "saveAdCfg":
                    SaveAdCfg(); break;
                #endregion

                #region 商户分类
                case "getMerchantTypeList":
                    GetMerchantTypeList(); break;
                case "delMerchantTypeList":
                    DelMerchantTypeList(); break;
                case "addMerchantType":
                    AddMerchantType(); break;
                #endregion

                #region 商户
                case "getMerchantList":
                    GetMerchantList(); break;
                case "saveMerchant":
                    SaveMerchant(); break;
                #endregion

                default: break;
            }
        }

        #region 公告
        /// <summary>
        /// 获取公告列表
        /// </summary>
        public void GetAnnouncemmentList()
        {
            var result = AnnouncementHelper.GetList();

            var jt = new JsonTransfer();
            jt.Add("list", result.Results);
            jt.Add("count", result.TotalCount);
            Response.Write(jt.ToJson());
            Response.End();
        }

        /// <summary>
        /// 删除公告列表
        /// </summary>
        public void DelAnnouncemmentList()
        {
            var ids = GetString("ids");
            var idlist = Utility.GetListint(ids);
            if (idlist.Count == 0)
            {
                ReturnErrorMsg("删除的公告id不能为空");
                return;
            }

            if (AnnouncementHelper.DelAnnouncementList(ids))
                ReturnCorrectMsg("删除成功");
            else
                ReturnErrorMsg("删除失败");
        }

        /// <summary>
        /// 新增公告
        /// </summary>
        public void AddAnnouncemment()
        {
            var content = GetString("content");
            if (string.IsNullOrEmpty(content))
            {
                ReturnErrorMsg("公告内容不能为空");
                return;
            }
            var announcement = new Announcement();
            announcement.Content = content;
            announcement.CreateTime = DateTime.Now;
            if (AnnouncementHelper.AddAnnouncement(announcement))
                ReturnCorrectMsg("新增成功");
            else
                ReturnErrorMsg("新增失败");
        }
        #endregion

        #region 平台广告设置
        /// <summary>
        /// 获取平台广告配置
        /// </summary>
        public void GetAdCfg()
        {
            var cfg = ParamHelper.PlatformCfgData;

            var jt = new JsonTransfer();
            jt.Add("data", cfg);
            Response.Write(jt.ToJson());
            Response.End();
        }
        /// <summary>
        /// 平台广告设置
        /// </summary>
        public void SaveAdCfg()
        {
            var type = GetInt("type");
            var imgs = GetString("imgs");
            var staytime = GetInt("staytime");
            var jumpurls = GetString("jumpurls");

            if (type > 1 || string.IsNullOrEmpty(imgs) || staytime == 0)
            {
                ReturnErrorMsg("传参有误");
                return;
            }

            var cfg = ParamHelper.PlatformCfgData;
            if (type == 0)
            {//软件端广告设置
                cfg.PhoneAd.PicUrl = imgs;
                cfg.PhoneAd.JumpUrl = jumpurls;
            }
            else
            {//商户首页广告
                cfg.MerchantAdStayTime = staytime;
                var list = Utility.GetListstring(imgs);
                var jumplist = Utility.GetListstring(jumpurls);
                if (list.Count == 0 || jumplist.Count == 0 || list.Count != jumplist.Count)
                {
                    ReturnErrorMsg("传参有误");
                    return;
                }
                cfg.MerchantAds = new List<ParamHelper.PicJumpItem>();
                var i = 0;
                foreach (var str in list)
                {
                    var pitem = new ParamHelper.PicJumpItem();
                    pitem.PicUrl = str;
                    pitem.JumpUrl = jumplist[i];
                    cfg.MerchantAds.Add(pitem);
                    i++;
                }
            }

            ParamHelper.SaveParamvalue("PlatformCfg", cfg);

            ReturnCorrectMsg("更改成功");
        }
        #endregion

        #region 商户类型
        /// <summary>
        /// 获取商户类型列表
        /// </summary>
        public void GetMerchantTypeList()
        {
            var result = MerchantTypeHelper.GetList();

            result.Insert(0, new MerchantType() { Id = 0, Name = "全部分类" });

            var jt = new JsonTransfer();
            jt.Add("list", result);
            Response.Write(jt.ToJson());
            Response.End();
        }

        /// <summary>
        /// 删除商户类型列表
        /// </summary>
        public void DelMerchantTypeList()
        {
            var ids = GetString("ids");
            var idlist = Utility.GetListint(ids);
            if (idlist.Count == 0)
            {
                ReturnErrorMsg("删除的商户类型id不能为空");
                return;
            }

            if (MerchantTypeHelper.DelMerchantTypeList(ids))
                ReturnCorrectMsg("删除成功");
            else
                ReturnErrorMsg("删除失败");
        }

        /// <summary>
        /// 新增商户类型
        /// </summary>
        public void AddMerchantType()
        {
            var name = GetString("name");
            var typeid = GetInt("typeid");
            if (string.IsNullOrEmpty(name) || typeid == 0)
            {
                ReturnErrorMsg("参数有误");
                return;
            }
            var merchantType = new MerchantType();
            merchantType.TypeId = typeid;
            merchantType.Name = name;
            if (MerchantTypeHelper.AddMerchantType(merchantType))
                ReturnCorrectMsg("新增成功");
            else
                ReturnErrorMsg("新增失败");
        }
        #endregion

        #region 商户
        public class MerchantItem
        {
            public int Id { get; set; }
            public int UserCount { get; set; }
            public float Money { get; set; }
            public string Cname { get; set; }
            public DateTime ServerEndTime { get; set; }
            public string Name { get; set; }
            public string LogoUrl { get; set; }
        }
        /// <summary>
        /// 获取商户列表
        /// </summary>
        public void GetMerchantList()
        {
            var mid = GetInt("mid");
            var orderby = GetInt("orderby");
            var orderbytype = GetInt("orderbytype");
            var start = GetInt("start");
            var limit = GetInt("limit");

            var merresult = MerchantHelper.GetMerchantList(mid, orderby, orderbytype, start*limit, limit);
            var mertyperesult = MerchantTypeHelper.GetList();

            var data = new List<MerchantItem>();
            var idlist = merresult.Results.Select(o => o.Id).ToList();
            var users = AccountHelper.GetUserList(Utility.GetWhereSql(idlist));
            foreach (var merchant in merresult.Results)
            {
                var merchantitem = new MerchantItem();
                merchantitem.Id = merchant.Id;
                merchantitem.UserCount = merchant.UserCount;
                var user = users.Results.FirstOrDefault(o => o.Id == merchant.Id);
                if (user == null)
                {
                    ReturnErrorMsg("数据出错");
                    return;
                }
                merchantitem.Money = user.Money;
                var mertype = mertyperesult.FirstOrDefault(o => o.Id == merchant.Mid);
                if (mertype == null)
                {
                    ReturnErrorMsg("数据出错");
                    return;
                }
                merchantitem.Cname = mertype.Name;
                merchantitem.ServerEndTime = merchant.ServerEndTime;
                merchantitem.Name = merchant.Name;
                merchantitem.LogoUrl = merchant.LogoUrl;

                data.Add(merchantitem);
            }
            var jt = new JsonTransfer();
            jt.Add("list", data);
            jt.Add("totalcount", merresult.TotalCount);

            Response.Write(jt.ToJson());
            Response.End();
        }

        /// <summary>
        /// 保存商户信息
        /// </summary>
        public void SaveMerchant()
        {

        }
        #endregion
    }
}
