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
using Backstage.Core.Handler;
using Backstage.Core.Logic;
using Backstage.View.Dev.Merchant;
using Backstage.View.User;
using log4net;

namespace Backstage.Handler
{
    public class AnnouncementHandler : BaseHandler
    {
        private static ILog logger = LogManager.GetLogger("AnnouncementHandler");
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
                case "saveMerchantTypeList":
                    SaveMerchantTypeList(); break;
                #endregion

                #region 商户
                case "getMerchantList":
                    GetMerchantList(); break;
                case "saveMerchant":
                    SaveMerchant(); break;
                case "getMerchant":
                    GetMerchant(); break;
                case "getCfgList":
                    GetCfgList(); break;
                case "delMerchantList":
                    DelMerchantList(); break;
                #endregion

                #region 模板
                case "getTempleList":
                    GetTempleList(); break;
                case "addTemple":
                    AddTemple(); break;
                case "updateTemple":
                    UpdateTemple(); break;
                case "getTemple":
                    GetTemple(); break;
                case "delTempleList":
                    DelTempleList(); break;
                #endregion

                #region 结算管理
                case "getsettlementlist":
                    GetSettleMentList(); break;
                case "updateextractmoney":
                    UpdateExtractMoney(); break;
                #endregion

                #region 支付方式
                case "getpaymentlist":
                    GetPaymentList(); break;
                case "delpayment":
                    DelPayment(); break;
                case "addpayment":
                    AddPayment(); break;
                case "getpayment":
                    GetPayment(); break;
                case "updatepayment":
                    UpdatePayment(); break;
                case "updatepaymentstatus":
                    UpdatePaymentStatus(); break;
                #endregion
                default: break;
            }
        }


        #region 支付方式
        private void GetPayment()
        {
            var id = GetInt("id");

            var payment = PaymentHelper.GetPayment(id);
            if (payment == null)
            {
                ReturnErrorMsg("不存在该支付方式");
                return;
            }

            var result = PaymentHelper.GetPayment(id);

            var jt = new JsonTransfer();
            jt.Add("data", result);
            Response.Write(jt.ToJson());
            Response.End();
        }
        /// <summary>
        /// 获得支付方式列表
        /// </summary>
        private void GetPaymentList()
        {
            var result = PaymentHelper.GetList();

            var jt = new JsonTransfer();
            jt.Add("list", result);
            jt.Add("totalcount", result.Count);
            Response.Write(jt.ToJson());
            Response.End();
        }

        private void DelPayment()
        {
            var id = GetInt("id");

            var payment = PaymentHelper.GetPayment(id);
            if (payment == null)
            {
                ReturnErrorMsg("不存在该支付方式");
                return;
            }
            if (PaymentHelper.DeletePayment(id))
                ReturnCorrectMsg("删除成功");
            else
                ReturnErrorMsg("删除失败");

        }
        /// <summary>
        /// 新增支付方式
        /// </summary>
        private void AddPayment()
        {
            var name = GetString("name");
            var description = GetString("description");
            var imgurl = GetString("imgurl");
            var account = GetString("account");
            var privatekey = GetString("privatekey");
            var pid = GetString("pid");
            var accounttype = GetInt("accounttype");

            if (string.IsNullOrEmpty(name) || name.Length > 50)
            {
                ReturnErrorMsg("支付方式名称不合法");
                return;
            }
            if (string.IsNullOrEmpty(description) || description.Length > 200)
            {
                ReturnErrorMsg("支付方式描述不合法");
                return;
            }
            if (string.IsNullOrEmpty(imgurl) || imgurl.Length > 200)
            {
                ReturnErrorMsg("支付方式logo不合法");
                return;
            }
            if (string.IsNullOrEmpty(account) || account.Length > 100)
            {
                ReturnErrorMsg("支付方式账号不合法");
                return;
            }
            if (string.IsNullOrEmpty(privatekey))
            {
                ReturnErrorMsg("支付方式私钥不合法");
                return;
            }
            if (string.IsNullOrEmpty(pid))
            {
                ReturnErrorMsg("支付方式PID不合法");
                return;
            }
            if (accounttype == 0)
            {
                ReturnErrorMsg("支付方式类型不合法");
                return;
            }

            var payment = new Payment();
            payment.Name = name;
            payment.Description = description;
            payment.ImgUrl = imgurl;
            payment.Account = account;
            payment.PrivateKey = privatekey;
            payment.Pid = pid;
            payment.AccountType = accounttype;
            payment.Status = 1;

            if (PaymentHelper.SavePayment(payment))
                ReturnCorrectMsg("新增成功");
            else
                ReturnErrorMsg("新增失败");
        }

        /// <summary>
        /// 编辑支付方式
        /// </summary>
        private void UpdatePayment()
        {
            var id = GetInt("id");
            var name = GetString("name");
            var description = GetString("description");
            var imgurl = GetString("imgurl");
            var account = GetString("account");
            var privatekey = GetString("privatekey");
            var pid = GetString("pid");
            var accounttype = GetInt("accounttype");


            if (string.IsNullOrEmpty(name) || name.Length > 50)
            {
                ReturnErrorMsg("支付方式名称不合法");
                return;
            }
            if (string.IsNullOrEmpty(description) || description.Length > 200)
            {
                ReturnErrorMsg("支付方式描述不合法");
                return;
            }
            if (string.IsNullOrEmpty(imgurl) || imgurl.Length > 200)
            {
                ReturnErrorMsg("支付方式logo不合法");
                return;
            }
            if (string.IsNullOrEmpty(account) || account.Length > 100)
            {
                ReturnErrorMsg("支付方式账号不合法");
                return;
            }
            if (string.IsNullOrEmpty(privatekey))
            {
                ReturnErrorMsg("支付方式私钥不合法");
                return;
            }
            if (string.IsNullOrEmpty(pid))
            {
                ReturnErrorMsg("支付方式PID不合法");
                return;
            }
            if (accounttype == 0)
            {
                ReturnErrorMsg("支付方式类型不合法");
                return;
            }

            var payment = PaymentHelper.GetPayment(id);
            if (payment == null)
            {
                ReturnErrorMsg("不存在该支付方式");
                return;
            }
            payment.Name = name;
            payment.Description = description;
            payment.ImgUrl = imgurl;
            payment.Account = account;
            payment.PrivateKey = privatekey;
            payment.Pid = pid;
            payment.AccountType = accounttype;

            if (PaymentHelper.SavePayment(payment))
                ReturnCorrectMsg("编辑成功");
            else
                ReturnErrorMsg("编辑失败");
        }
        /// <summary>
        /// 更新支付方式是否启用
        /// </summary>
        private void UpdatePaymentStatus()
        {
            var id = GetInt("id");
            var status = GetInt("status");

            if (status != 0 && status != 1)
            {
                ReturnErrorMsg("支付方式类型不合法");
                return;
            }

            var payment = PaymentHelper.GetPayment(id);
            if (payment == null)
            {
                ReturnErrorMsg("不存在该支付方式");
                return;
            }
            if (status == payment.Status)
            {
                ReturnErrorMsg("状态未改变");
                return;
            }
            payment.Status = status;

            if (PaymentHelper.SavePayment(payment))
                ReturnCorrectMsg("新增成功");
            else
                ReturnErrorMsg("新增失败");
        }
        #endregion

        #region 结算管理
        /// <summary>
        /// 获取结算记录列表
        /// </summary>
        private void GetSettleMentList()
        {
            var status = GetInt("status");
            var start = GetInt("start");
            var limit = GetInt("limit");

            var wheresql = "";
            if (status == 0)
            {
                wheresql = string.Format(" where Status = {0} ", status);
            }
            else
            {
                wheresql = " where Status <> 0 ";
            }
            var result = ExtractMoneyHelper.GetPagings(0, start * limit, limit, "", wheresql);

            var jt = new JsonTransfer();
            jt.Add("list", result.Results);
            jt.Add("totalcount", result.TotalCount);
            Response.Write(jt.ToJson());
            Response.End();
        }
        /// <summary>
        /// 商户提现确认
        /// </summary>
        public void UpdateExtractMoney()
        {
            if (CurrentUser.RoleType != RoleType.SuperManage)
            {
                ReturnErrorMsg("无权限打款，请联系超级管理员");
                return;
            }
            var status = GetInt("status");
            var id = GetInt("id");
            var extractmoney = ExtractMoneyHelper.GetItem(id);
            if (extractmoney == null)
            {
                ReturnErrorMsg("提现id有误");
                return;
            }
            if (status == extractmoney.Status)
            {
                ReturnErrorMsg("无状态变化");
                return;
            }
            if (status != 1 && status != -1)
            {
                ReturnErrorMsg("修改的状态有误");
                return;
            }
            extractmoney.Status = status;

            var user = AccountHelper.GetUser(extractmoney.SellerId);
            if (user == null)
            {
                ReturnErrorMsg("不存在该用户");
                return;
            }
            //打款成功
            if (user.Money < extractmoney.Money)
            {
                ReturnErrorMsg("提现失败，金额不足");
                return;
            }
            user.Money -= extractmoney.Money;
            AccountHelper.SaveAccount(user);

            if (ExtractMoneyHelper.Update(extractmoney))
                ReturnCorrectMsg("处理成功");
            else
                ReturnErrorMsg("处理失败");
        }
        #endregion

        #region 公告
        /// <summary>
        /// 获取公告列表
        /// </summary>
        public void GetAnnouncemmentList()
        {
            var start = GetInt("start");
            var limit = GetInt("limit");
            var result = AnnouncementHelper.GetList(start * limit, limit);

            var jt = new JsonTransfer();
            jt.Add("list", result.Results);
            jt.Add("totalcount", result.TotalCount);
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
                cfg.MerchantAds = new List<PicJumpItem>();
                var i = 0;
                foreach (var str in list)
                {
                    var pitem = new PicJumpItem();
                    pitem.PicUrl = str;
                    pitem.JumpUrl = jumplist[i];
                    cfg.MerchantAds.Add(pitem);
                    i++;
                }
            }

            ParamHelper.UpdateParamvalue("PlatformCfg", cfg);

            ReturnCorrectMsg("更改成功");
        }
        #endregion

        #region 商户类型
        /// <summary>
        /// 获取商户类型列表
        /// </summary>
        public void GetMerchantTypeList()
        {
            var type = GetInt("type");
            var result = MerchantTypeHelper.GetList();

            if (type == 0) result.Insert(0, new MerchantType() { Id = 0, Name = "全部分类" });

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
        [Serializable]
        public class SaveMerchantTypeItem
        {
            [XmlElement("Id")]
            public int Id { get; set; }
            [XmlElement("Name")]
            public string Name { get; set; }
        }
        /// <summary>
        /// 保存商户分类列表
        /// </summary>
        public void SaveMerchantTypeList()
        {
            string data_save = GetString("data_save");
            if (string.IsNullOrEmpty(data_save))
            {
                ReturnErrorMsg("没有选择需要保存的商户分类");
                return;
            }

            var json = new JavaScriptSerializer();
            var list = json.Deserialize(data_save, typeof(List<SaveMerchantTypeItem>)) as List<SaveMerchantTypeItem>;
            if (list == null)
            {
                ReturnErrorMsg("没有选择需要保存的商户分类");
                return;
            }

            var merTypeList = MerchantTypeHelper.GetList();
            var saveTypeList = new List<MerchantType>();
            foreach (var saveMerchantTypeItem in list)
            {
                var item = merTypeList.FirstOrDefault(o => o.Id == saveMerchantTypeItem.Id);
                if (item == null)
                {
                    ReturnErrorMsg("上传了不存在商户类型id");
                    return;
                }
                item.Name = saveMerchantTypeItem.Name;

                saveTypeList.Add(item);
            }

            if (saveTypeList.Count == 0)
            {
                ReturnErrorMsg("没有选择需要保存的商户分类");
                return;
            }

            if (MerchantTypeHelper.SaveMerchantTypeList(saveTypeList))
                ReturnCorrectMsg("保存成功");
            else
                ReturnErrorMsg("保存失败");
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

            var merresult = MerchantHelper.GetMerchantList(mid, orderby, orderbytype, start * limit, limit);
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


        [Serializable]
        public class SaveMerchantInfo
        {
            [XmlElement("Id")]
            public int Id { get; set; }
            [XmlElement("Name")]
            public string Name { get; set; }
            [XmlElement("UserName")]
            public string UserName { get; set; }
            [XmlElement("LogoUrl")]
            public string LogoUrl { get; set; }
            [XmlElement("Mid")]
            public int Mid { get; set; }
            [XmlElement("Tid")]
            public int Tid { get; set; }
            [XmlElement("CreateTime")]
            public DateTime CreateTime { get; set; }
            [XmlElement("ServerEndTime")]
            public DateTime ServerEndTime { get; set; }
            [XmlElement("HasWifi")]
            public int HasWifi { get; set; }
            [XmlElement("HasPrint")]
            public int HasPrint { get; set; }
            [XmlElement("DevName")]
            public string DevName { get; set; }
            [XmlElement("Sid")]
            public int Sid { get; set; }
            [XmlElement("Phone")]
            public string Phone { get; set; }
            [XmlElement("ManagerPhone")]
            public string ManagerPhone { get; set; }
            [XmlElement("Address")]
            public string Address { get; set; }
            [XmlElement("WinXinAccount")]
            public string WinXinAccount { get; set; }
            [XmlElement("Qq")]
            public string Qq { get; set; }
            [XmlElement("Email")]
            public string Email { get; set; }
            [XmlElement("IosUrl")]
            public string IosUrl { get; set; }
            [XmlElement("AndroidUrl")]
            public string AndroidUrl { get; set; }
            [XmlElement("MachineCode")]
            public string MachineCode { get; set; }
            [XmlElement("MachineKey")]
            public string MachineKey { get; set; }
            [XmlElement("CnameList")]
            public List<string> CnameList { get; set; }
            [XmlElement("HasDelivery")]
            public int HasDelivery { get; set; }
            [XmlElement("WifiAccount")]
            public string WifiAccount { get; set; }
        }
        /// <summary>
        /// 保存商户信息
        /// </summary>
        public void SaveMerchant()
        {
            string data_save = GetString("data_save");
            if (string.IsNullOrEmpty(data_save))
            {
                ReturnErrorMsg("商户信息为空");
                return;
            }

            var json = new JavaScriptSerializer();
            var merchantinfo = json.Deserialize<SaveMerchantInfo>(data_save);
            if (merchantinfo == null)
            {
                ReturnErrorMsg("商户信息为空");
                return;
            }

            var user = new Account();

            var id = merchantinfo.Id;
            if (id == 0)
            {
                user.UserName = merchantinfo.UserName;
                user.Pwd = "111111";
                user.RoleType = RoleType.Merchant;
                user.Phone = merchantinfo.Phone;
                user.Address = merchantinfo.Address;

                merchantinfo.Id = AccountHelper.SaveAccount(user);
            }
            else user = AccountHelper.GetUser(merchantinfo.Id);
            if (user == null)
            {
                ReturnErrorMsg("不存在该商户");
                return;
            }
            var merchant = MerchantHelper.GetMerchant(merchantinfo.Id);
            var isadd = 0;
            var changeCountList = new List<GoodsHandler.ChangeCountItem>();
            if (merchant == null)
            {
                merchant = new Merchant();
                merchant.Id = merchantinfo.Id;
                isadd = 1;

                changeCountList.Add(new GoodsHandler.ChangeCountItem() { Id = merchantinfo.Mid, Change = 1 });
            }

            user.UserName = merchantinfo.UserName;

            merchant.Name = merchantinfo.Name;
            merchant.LogoUrl = merchantinfo.LogoUrl;
            if (id > 0 && merchantinfo.Mid != merchant.Mid)
            {
                if (merchant.Mid > 0) changeCountList.Add(new GoodsHandler.ChangeCountItem() { Id = merchant.Mid, Change = -1 });
                changeCountList.Add(new GoodsHandler.ChangeCountItem() { Id = merchantinfo.Mid, Change = 1 });
            }
            merchant.Mid = merchantinfo.Mid;

            merchant.Tid = merchantinfo.Tid;
            merchant.ServerEndTime = merchantinfo.ServerEndTime;
            merchant.HasWifi = merchantinfo.HasWifi;
            merchant.HasPrint = merchantinfo.HasPrint;
            merchant.HasDelivery = merchantinfo.HasDelivery;
            merchant.Sid = merchantinfo.Sid;
            merchant.Phone = merchantinfo.Phone;
            merchant.ManagerPhone = merchantinfo.ManagerPhone;
            merchant.Address = merchantinfo.Address;
            merchant.WinXinAccount = merchantinfo.WinXinAccount;
            merchant.Qq = merchantinfo.Qq;
            merchant.Email = merchantinfo.Email;
            merchant.IosUrl = merchantinfo.IosUrl;
            merchant.AndroidUrl = merchantinfo.AndroidUrl;
            merchant.MachineCode = merchantinfo.MachineCode;
            merchant.MachineKey = merchantinfo.MachineKey;
            if (string.IsNullOrEmpty(merchantinfo.CnameList[0])) merchantinfo.CnameList[0] = "活动咨询";
            if (string.IsNullOrEmpty(merchantinfo.CnameList[1])) merchantinfo.CnameList[1] = "商品展示";
            if (string.IsNullOrEmpty(merchantinfo.CnameList[2])) merchantinfo.CnameList[2] = "快速预约";
            if (string.IsNullOrEmpty(merchantinfo.CnameList[3])) merchantinfo.CnameList[3] = "图片墙";
            if (string.IsNullOrEmpty(merchantinfo.CnameList[4])) merchantinfo.CnameList[4] = "包厢";
            merchant.CnameList = merchantinfo.CnameList;
            merchant.DevName = merchantinfo.DevName;
            merchant.WifiAccount = merchantinfo.WifiAccount;

            AccountHelper.SaveAccount(user);
            if (MerchantHelper.SaveMerchant(merchant, isadd))
            {
                MerchantTypeHelper.UpdateMerchantCount(changeCountList);
                if (id == 0)
                {
                    if (Utility._msg_opensend == "1")
                    {
                        //发送短信给商户
                        SendMsgClass5 jsobject = new SendMsgClass5();
                        jsobject.param1 = merchant.Name;
                        jsobject.param2 = Utility._domainurl + "/view/dev/Index.aspx";
                        jsobject.param3 = user.UserName;
                        jsobject.param4 = user.Pwd;
                        jsobject.param5 = Utility._3vurl;

                        if (Utility.SendMsg(merchant.Phone, MsgTempleId.AddMerchant, jsobject) != "发送成功")
                        {
                            logger.InfoFormat("短信模板：{0},Phone:{3},发送失败merchantId：{1},Name:{2}",
                                (int)MsgTempleId.AddMerchant, merchant.Id, merchant.Name, merchant.Phone);
                        }
                    }
                    ReturnCorrectMsg("添加成功");
                }
                else
                    ReturnCorrectMsg("更新成功");
            }
            else
                if (id == 0)
                    ReturnErrorMsg("添加失败");
                else
                    ReturnErrorMsg("更新失败");
        }

        /// <summary>
        /// 获取商户信息
        /// </summary>
        public void GetMerchant()
        {
            var id = GetInt("id");

            var user = AccountHelper.GetUser(id);
            var merchant = MerchantHelper.GetMerchant(id);
            if (merchant == null || user == null)
            {
                ReturnErrorMsg("商户不存在");
                return;
            }

            var jt = new JsonTransfer();
            jt.Add("mer", merchant);
            jt.Add("user", user);

            Response.Write(jt.ToJson());
            Response.End();
        }

        /// <summary>
        /// 获取商户详情页面的一些配置列表
        /// </summary>
        public void GetCfgList()
        {
            var result = MerchantTypeHelper.GetList();
            var tresult = TempleHelper.GetList();
            var signlist = ParamHelper.PlatformCfgData.SignList;
            var jt = new JsonTransfer();
            var nowdate = DateTime.Now.ToString("yyyy-MM-d");
            var serverdata = DateTime.Now.AddYears(1).ToString("yyyy-MM-d"); ;
            jt.Add("mertypelist", result);
            jt.Add("templelist", tresult.Results);
            jt.Add("signlist", signlist);
            jt.Add("nowdate", nowdate);
            jt.Add("serverdata", serverdata);

            Response.Write(jt.ToJson());
            Response.End();
        }

        /// <summary>
        /// 删除商户列表
        /// </summary>
        public void DelMerchantList()
        {
            //暂且不做
        }
        #endregion

        #region 模板类型
        /// <summary>
        /// 获取模板列表
        /// </summary>
        public void GetTempleList()
        {
            var typeid = GetInt("typeid");
            var start = GetInt("start");
            var limit = GetInt("limit");
            var result = TempleHelper.GetList(typeid, start * limit, limit);

            var jt = new JsonTransfer();
            jt.Add("list", result.Results);
            jt.Add("totalcount", result.TotalCount);
            Response.Write(jt.ToJson());
            Response.End();
        }

        /// <summary>
        /// 删除模板列表
        /// </summary>
        public void DelTempleList()
        {
            var ids = GetString("ids");
            var idlist = Utility.GetListint(ids);
            if (idlist.Count == 0)
            {
                ReturnErrorMsg("删除的模板id不能为空");
                return;
            }

            if (TempleHelper.DelTempleList(ids))
                ReturnCorrectMsg("删除成功");
            else
                ReturnErrorMsg("删除失败");
        }

        /// <summary>
        /// 添加模板
        /// </summary>
        public void AddTemple()
        {
            var logourl = GetString("logourl");
            var name = GetString("name");
            var typeid = GetInt("typeid");
            if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(logourl))
            {
                ReturnErrorMsg("参数有误");
                return;
            }
            var temple = new Temple();
            temple.TypeId = typeid;
            temple.Name = name;
            temple.LogoUrl = logourl;

            if (TempleHelper.AddTemple(temple))
                ReturnCorrectMsg("新增成功");
            else
                ReturnErrorMsg("新增失败");
        }

        /// <summary>
        /// 更新模板
        /// </summary>
        public void UpdateTemple()
        {
            var id = GetInt("id");
            var logourl = GetString("logourl");
            var name = GetString("name");
            var typeid = GetInt("typeid");
            if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(logourl) || id == 0)
            {
                ReturnErrorMsg("参数有误");
                return;
            }
            var temple = TempleHelper.GetTemple(id);
            if (temple == null)
            {
                ReturnErrorMsg("找不到模板");
                return;
            }

            temple.TypeId = typeid;
            temple.Name = name;
            temple.LogoUrl = logourl;

            if (TempleHelper.UpdateTemple(temple))
                ReturnCorrectMsg("更新成功");
            else
                ReturnErrorMsg("更新失败");
        }
        /// <summary>
        /// 获取模板信息
        /// </summary>
        public void GetTemple()
        {
            var id = GetInt("id");
            var temple = TempleHelper.GetTemple(id);
            if (temple == null)
            {
                ReturnErrorMsg("找不到模板");
                return;
            }
            var jt = new JsonTransfer();
            jt.Add("data", temple);
            Response.Write(jt.ToJson());
            Response.End();
        }
        #endregion
    }
}
