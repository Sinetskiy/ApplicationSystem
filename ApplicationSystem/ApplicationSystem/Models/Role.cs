using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ApplicationSystem.Models
{
    public class Role
    {
        public Role()
        {
            this.SystemUsers = new HashSet<SystemUser>();
        }

        public Guid RoleId { get; set; }
        public string Name { get; set; }

        public virtual ICollection<SystemUser> SystemUsers { get; set; }
    }
}