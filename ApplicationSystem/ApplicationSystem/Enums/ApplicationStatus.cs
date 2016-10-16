using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace ApplicationSystem.Enums
{
    public enum ApplicationStatus
    {
        /// <summary>
        /// Новое
        /// </summary>
        [Display(Name = "Новое")]
        New = 0,
        /// <summary>
        /// Удовлетворить 
        /// </summary>
        [Display(Name = "Удовлетворить")]
        Accept,

        /// <summary>
        /// Откланить
        /// </summary>
        [Display(Name = "Откланить")]
        Reject

    }
}