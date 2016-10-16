using ApplicationSystem.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ApplicationSystem.Models
{
    public class Application
    {
        public Guid ApplicationId { get; set; }
        public string ClientName { get; set; }
        public string ClientEmail { get; set; }
        public string Text { get; set; }
        public DateTime CreatedOn { get; set; }
        public DateTime ModifiedOn { get; set; }
        public ApplicationStatus Status { get; set; }
    }
}