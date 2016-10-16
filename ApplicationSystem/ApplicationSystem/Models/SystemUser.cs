using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ApplicationSystem.Models
{
    public class SystemUser
    {
        public Guid SystemUserId { get; set; }
        public string Name { get; set; }
        public string Email { get; set; }
        public virtual ICollection<Role> Roles { get; set; }
    }
}