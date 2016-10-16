using ApplicationSystem.EF;
using ApplicationSystem.Enums;
using ApplicationSystem.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.Mvc;

namespace ApplicationSystem.Controllers
{
    public class ApplicationController : Controller
    {
        Dal _dal = new Dal();

        // GET: Application
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public JsonResult GetApplications()
        {            
            return getApplications();
        }

        [HttpPost]
        public JsonResult CreateApplication(Application application)
        {
            application.ApplicationId = Guid.NewGuid();
            application.CreatedOn = DateTime.Now;
            application.ModifiedOn = DateTime.Now;
            application.Status = ApplicationStatus.New;
            _dal.Applications.Add(application);
            _dal.SaveChanges();

            return new JsonResult();
        }

        [HttpPost]
        public JsonResult GetApplicationByID(Guid id)
        {
            Application application = _dal.Applications.Find(id);
            return Json(application, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult UpdateApplication(Application application)
        {
            application.ModifiedOn = DateTime.Now;
            _dal.Entry(application).State = System.Data.Entity.EntityState.Modified;
            _dal.SaveChanges();

            sendEmailNotification(application);

            return getApplications();
        }

        [HttpPost]
        public JsonResult DeleteApplication(Guid id)
        {
            Application application = _dal.Applications.Find(id);
            _dal.Entry(application).State = System.Data.Entity.EntityState.Deleted;
            _dal.SaveChanges();

            return getApplications();
        }

        private JsonResult getApplications()
        {
            List<Application> listOfApplication = _dal.Applications.ToList();
            return Json(listOfApplication, JsonRequestBehavior.AllowGet);
        }

        private void sendEmailNotification(Application application)
        {
            if (application.Status == ApplicationStatus.Accept)
            {
                // TODO: Отправляем письмо с подтверждением
                var email = getEmailFromTemplate(application, ConfigurationManager.AppSettings["AcceptSubject"], ConfigurationManager.AppSettings["AcceptBody"]);
                //sendEmail(application, email); // можно из БД брать шаблоны
                return;
            }

            if (application.Status == ApplicationStatus.Reject)
            {
                // TODO: Отправляем письмо с отклонением
                var email = getEmailFromTemplate(application, ConfigurationManager.AppSettings["RejectSubject"], ConfigurationManager.AppSettings["RejectBody"]);
                //sendEmail(application, email); 
                return;
            }

            return;
        }

        private Email getEmailFromTemplate(Application application, string templateSubject, string templateBody)
        {
            // TODO: создаем сообщение из шаблона
            return new Email();
        }

        private void sendEmail(Application application, Email email) // либо через Exchange 
        {
            MailMessage mail = new MailMessage(ConfigurationManager.AppSettings["AdminEmail"], application.ClientEmail); // либо SystemUsers.Email
            SmtpClient client = new SmtpClient(); 
            client.Port = 25;
            client.DeliveryMethod = SmtpDeliveryMethod.Network;
            client.UseDefaultCredentials = false;
            client.Host = ConfigurationManager.AppSettings["SmtpHost"];
            mail.Subject = email.Subject;
            mail.Body = email.Body;
            client.Send(mail);

        }
    }
}