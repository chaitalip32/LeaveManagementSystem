using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net;
using System.Net.Mail;
using System.Configuration;

namespace LeaveManagementSystem.Helpers
{
    public class EmailHelper
    {     
        public static bool SendPasswordSetupEmail(string email, string token,out string errorMessage)
        {
            errorMessage = "";

            try
            {
                string emailUser = ConfigurationManager.AppSettings["EmailUser"];
                string emailPassword = ConfigurationManager.AppSettings["EmailPassword"];

                string link = "http://localhost:64671/Account/SetPassword.aspx?token=" + token;

                MailMessage mail = new MailMessage();
                mail.To.Add(email);
                mail.Subject = "Set your Password";

                mail.Body = "Click below link to set your password:\n\n" + link;

                // this is system email
                mail.From = new MailAddress(emailUser, "Leave Management System");

                SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
                smtp.Credentials = new NetworkCredential(emailUser, emailPassword);
                smtp.EnableSsl = true;

                smtp.Send(mail);

                return true;
            }
            catch(SmtpException ex)
            {
                errorMessage = "Email service error: " + ex.Message;
                return false;
            }
            catch(Exception ex)
            {
                errorMessage = "unexpected error while sending email: " + ex.Message;
                return false;
            }
        }

        public static bool SendLeaveApplicationEmail(string employeeEmail, string ccEmail, string subject, string body, out string errorMessage)
        {
            errorMessage = "";

            try
            {
                string emailUser = ConfigurationManager.AppSettings["EmailUser"];
                string emailPassword = ConfigurationManager.AppSettings["EmailPassword"];

                MailMessage mail = new MailMessage();
                mail.From = new MailAddress(emailUser);

                mail.To.Add(emailUser);// main receiver like HR
                
                if(!string.IsNullOrEmpty(ccEmail)) //manager and HR emails
                {
                    foreach(string email in ccEmail.Split(','))
                    {
                        string trimmedEmail = email.Trim();
                        if(!string.IsNullOrEmpty(trimmedEmail))
                        {
                            mail.CC.Add(new MailAddress(trimmedEmail));
                        }                       
                    }
                }

                if(!string.IsNullOrEmpty(employeeEmail))
                {
                    mail.ReplyToList.Add(new MailAddress(employeeEmail));
                }

                mail.Subject = subject;
                mail.Body = body;
                mail.IsBodyHtml = true;

                SmtpClient smtp = new SmtpClient("smtp.gmail.com",587);
                smtp.Credentials = new NetworkCredential(emailUser, emailPassword);
                smtp.EnableSsl = true;

                smtp.Send(mail);

                return true;
            }
            catch(SmtpException ex)
            {
                errorMessage = "Email service error: " + ex.Message;
                return false;
            }
            catch(Exception ex)
            {
                errorMessage = "Unexpected error while sending email:" + ex.Message;
                return false;
            }
        }
    }
}