using Backstage.Core;
using Backstage.Core.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Backstage.View.Dev.UserCenter
{
    public partial class PwdEdit : BasePage
    {
        public Account _Account;
        public int Id;

        protected void Page_Load(object sender, EventArgs e)
        {
            _Account = AccountHelper.GetCurUser();
            _Account = AccountHelper.GetUser(_Account.Id);
            Id = _Account.Id;
        }
    }
}