using Backstage.Core.Logic;
using Backstage.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Backstage.Core.Handler.Backstage
{
    public class DevSystemHandler : BaseApiHandler
    {
        public override void ProcessRequest(HttpContext context)
        {
            base.SetApiName("SystemHandler");
            base.ProcessRequest(HttpContext.Current);
            switch (Action)
            {
                case "getrules": //获取规则
                    GetRules(); break;
                case "getcashs":
                    GetCashs();break;
                case "updatecash":
                    UpdateCash();break;
                default: break;
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
                    Status = c.Status == 1 ?  "已处理": "未处理",
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