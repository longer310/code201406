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
            RoleType = RoleType.Manage;//需商家管理权限 暂定权限管理
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
        /// 平台广告设置
        /// </summary>
        public void SaveAdCfg()
        {
            var type = GetInt("type");
            var imgs = GetString("imgs");
            var staytime = GetInt("staytime");

            if (type > 1 || string.IsNullOrEmpty(imgs) || staytime == 0)
            {
                ReturnErrorMsg("传参有误");
                return;
            }

            var cfg = ParamHelper.MerchantCfgData;
            if (type == 0)
            {//登录页广告设置
                cfg.LoginAdStayTime = staytime;
                cfg.LoginAdUrl = imgs;
            }
            else
            {//wifi广告
                cfg.WifiAdStayTime = staytime;
                var list = Utility.GetListstring(imgs);
                if (list.Count == 0)
                {
                    ReturnErrorMsg("传参有误");
                    return;
                }
                cfg.WifiAdUrlList = list;
            }

            ParamHelper.SaveParamvalue("MerchantCfg", cfg);

            ReturnCorrectMsg("更改成功");
        }
        #endregion
    }
}
