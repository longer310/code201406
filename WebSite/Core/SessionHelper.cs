using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace Backstage.Core
{
    public class SessionHelper
    {
        private HttpSessionState curSession;

        public SessionHelper(HttpSessionState session)
        {
            this.curSession = session;
        }

        public static SessionHelper CreateInstance(HttpSessionState session)
        {
            return new SessionHelper(session);
        }
        public string UserID
        {
            get { return this.curSession["UserID"].ToString(); }
            set { this.curSession["UserID"] = value; }
        }
        public int UserName
        {
            get { return (int)this.curSession["UserAge"]; }
            set { this.curSession["UserAge"] = value; }
        }
        public RoleType UserRoleType
        {
            get { return (RoleType)this.curSession["UserRoleType"]; }
            set { this.curSession["UserRoleType"] = (int)value; }
        }
    }
}