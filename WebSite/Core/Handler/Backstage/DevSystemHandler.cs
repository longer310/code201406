using Backstage.Core.Entity;
using Backstage.Core.Logic;
using Backstage.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Handler.Backstage
{
    public class DevSystemHandler : BaseHandler
    {
        public override void ProcessRequest(HttpContext context)
        {
            base.ProcessRequest(HttpContext.Current);
            switch (Action)
            {
                case "getrules": //获取规则
                    GetRules(); break;
                case "getcashs":
                    GetCashs(); break;
                case "updatecash":
                    UpdateCash(); break;
                case "getadmins":
                    GetAdmins(); break;
                case "pwdedit":
                    PwdEdit(); break;
                case "addadmin":
                    AddAdmin(); break;
                case "updateadmin":
                    UpdateAdmin(); break;
                case "deladmin":
                    DeleteAdmin(); break;
                case "delfastlinks":
                    DeleteFastlinks(); break;
                case "createfastlinks":
                    CreateFastlinks(); break;
                case "getfastlinkslist":
                    GetFastlinksList(); break;
                case "getfastlinksitem":
                    GetFastlinksItem(); break;
                case "updatefastlinks":
                    UpdateFastlinks(); break;
                case "styleinfo":
                    StyleInfo(); break;
                default: break;
            }
        }

        private void StyleInfo()
        {
            var cfg = ParamHelper.PlatformCfgData;
            
            for (var i = 0; i < cfg.SignList.Count; i++)
            {
                switch (i)
                { 
                    case 0:
                        cfg.SignList[i].Prec = GetFloat("first");break;
                    case 1:
                        cfg.SignList[i].Prec = GetFloat("second"); break;
                    case 2:
                        cfg.SignList[i].Prec = GetFloat("third"); break;
                }
            }
            cfg.ServiceProtocol = GetString("sp");
            cfg.DevInfo = GetString("di");
            cfg.SpecialExplain = GetString("se");
                //List<ParamHelper.SignTypeItem> items = new List<ParamHelper.SignTypeItem>();
                //items.Add(new ParamHelper.SignTypeItem()
                //{
                //    Id = signList.First().Id,
                //    Name = signList.First().Name,
                //    Prec = GetFloat("first")
                //});
                //items.Add(new ParamHelper.SignTypeItem()
                //{
                //    Id = signList.First().Id,
                //    Name = signList.First().Name,
                //    Prec = GetFloat("second")
                //});
                //items.Add(new ParamHelper.SignTypeItem()
                //{
                //    Id = signList.First().Id,
                //    Name = signList.First().Name,
                //    Prec = GetFloat("third")
                //});
            ParamHelper.UpdateParamvalue("PlatformCfg", ParamHelper.PlatformCfgData);
        }

        private void UpdateFastlinks()
        {
            int id = GetInt("id");
            var item = DevSystemHelper.GetFastlinksItem(id);
            if (item == null)
                throw new ArgumentNullException("fasklinks为空Id:" + id);
            item.Title = GetString("title");
            item.ImgUrl = GetString("imgurl");
            item.Url = GetString("url");
            item.CreateTime = DateTime.Now;
            DevSystemHelper.UpdateFasklinks(item);
        }

        private void GetFastlinksItem()
        {
            var id = GetInt("id");
            var item = DevSystemHelper.GetFastlinksItem(id);
            JsonTransfer jt = new JsonTransfer();
            jt.Add("data", item);
            Response.Write(DesEncrypt(jt));
            Response.End();
        }

        private void GetFastlinksList()
        {
            var index = GetInt("start");
            var size = GetInt("limit");
            var items = DevSystemHelper.GetPagFastlinks(index * size, size);
            JsonTransfer jt = new JsonTransfer();
            jt.Add("data", items);
            Response.Write(DesEncrypt(jt));
            Response.End();
        }

        private void CreateFastlinks()
        {
            var item = new Fastlinks();
            item.Title = GetString("title");
            item.ImgUrl = GetString("imgurl");
            item.Url = GetString("url");
            item.CreateTime = DateTime.Now;
            DevSystemHelper.CreateFastlinks(item);
        }

        private void DeleteFastlinks()
        {
            var ids = Utility.GetListint("ids");
            foreach (var id in ids)
            {
                DevSystemHelper.DeleteFastlinks(id);
            }
        }

        private void DeleteAdmin()
        {
            var ids = Utility.GetListint(GetString("ids"));
            foreach (var id in ids)
            {
                var admin = AccountHelper.GetUser(id);
                if (admin == null)
                    throw new ArgumentNullException("管理员为空Id:" + id);
                AccountHelper.DelUser(id);
            }
        }

        private void UpdateAdmin()
        {
            int id = GetInt("id");
            var admin = AccountHelper.GetUser(id);
            admin.RoleType = (RoleType)GetInt("roletype");
            admin.NickName = GetString("nickname");
            admin.UserName = GetString("username");
            AccountHelper.SaveAccount(admin);
        }

        private void AddAdmin()
        {
            var admin = new Account();
            admin.RoleType = (RoleType)GetInt("roletype");
            admin.LastLoginTime = DateTime.Now;
            admin.NickName = GetString("nickname");
            admin.UserName = GetString("username");
            admin.Pwd = GetString("pwd");
            admin.RegisterTime = DateTime.Now;
            var user = AccountHelper.FindUser(admin.UserName);
            if (user != null)
            {
                JsonTransfer jt = new JsonTransfer();
                jt.Add("data", new  { status=false,msg="账户已经存在,登录名重复:" +admin.UserName});
                Response.Write(DesEncrypt(jt));
                Response.End();
                return;
            }
            else
            {
                AccountHelper.SaveAccount(admin);
                JsonTransfer jt = new JsonTransfer();
                jt.Add("data", new { status = true, msg = "添加成功！" });
                Response.Write(DesEncrypt(jt));
                Response.End();
                
            }
        }

        private void PwdEdit()
        {
            int id = GetInt("id");
            var admin = AccountHelper.GetUser(id);
            var orignPwd = GetString("prepassw");
            var newPwd = GetString("newpassw");
            if (admin.Pwd != orignPwd)
            {
                throw new ArgumentException("原始密码错误");
            }
            admin.Pwd = newPwd;
            AccountHelper.SaveAccount(admin);
        }

        private void GetAdmins()
        {
            int index = GetInt("start");
            int size = GetInt("limit");
            var admins = AccountHelper.GetPagAdmins(index * size, size);

            var result = new PagResults<object>();
            result.TotalCount = admins.TotalCount;
            foreach (var admin in admins.Results)
            {
                result.Results.Add(new
                {
                    Id = admin.Id,
                    NickName = admin.NickName,
                    RoleType = GetRoleTypeName(admin.RoleType),
                    LastLoginTime = admin.LastLoginTime.ToString("yyyy-MM-dd HH:mm:ss")
                });
            }


            JsonTransfer jt = new JsonTransfer();
            jt.Add("data", result);
            Response.Write(DesEncrypt(jt));
            Response.End();

        }

        string GetRoleTypeName(RoleType type)
        {
            switch (type)
            {
                case RoleType.Manage:
                    return "管理员";
                case RoleType.SuperManage:
                    return "超级管理员";
                case RoleType.Merchant:
                    return "商家";
                default:
                    return "";
            }
        }

        private void UpdateCash()
        {
            var id = GetInt("id");
            var cash = ExtractMoneyHelper.GetItem(id);
            cash.Status = 1;
            ExtractMoneyHelper.Update(cash);
            var merchant = MerchantHelper.GetMerchant(cash.SellerId);
            merchant.Money -= cash.Fee;
            MerchantHelper.SaveMerchant(merchant);
        }

        private void GetCashs()
        {
            int index = GetInt("start");
            int size = GetInt("limit");
            var cashs = ExtractMoneyHelper.GetPagings(0, index * size, size);
            var results = new PagResults<object>();
            results.TotalCount = cashs.TotalCount;
            foreach (var c in cashs.Results)
            {
                var item = new
                {
                    Id = c.Id,
                    Fee = c.Fee,
                    Bank = c.Bank,
                    CardNumber = c.CardNumber,
                    AccountName = c.AccountName,
                    Money = c.Money,
                    SellerId = c.SellerId,
                    Status = c.Status == 1 ? "已处理" : "未处理",
                    CreateTime = c.CreateTime.ToString("yyyy-MM-dd HH:mm:ss")
                };
                results.Results.Add(item);

            }

            JsonTransfer jt = new JsonTransfer();
            jt.Add("data", results);
            Response.Write(DesEncrypt(jt));
            Response.End();
        }

        private void GetRules()
        {
            throw new NotImplementedException();
        }



    }
}