using System;
using System.Collections.Generic;
using System.EnterpriseServices;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Xml.Serialization;
using Backstage.Core;
using Backstage.Core.Entity;
using Backstage.Core.Logic;
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

            if(AnnouncementHelper.DelAnnouncementList(ids))
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
    }
}
