using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net;
using System.Net.Mail;

namespace LeaveManagementSystem.Helpers
{
    public class EmailHelper
    {
        public static bool SendPasswordSetupEmail(string email, string token,out string errorMessage)
        {
            errorMessage = "";

            try
            {
                string link = "http://localhost:64671/Account/SetPassword.aspx?token=" + token;

                MailMessage mail = new MailMessage();
                mail.To.Add(email);
                mail.Subject = "Set your Password";

                mail.Body = "Click below link to set your password:\n\n" + link;

                mail.From = new MailAddress("chaitalipednekar2002@gmail.com");

                SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
                smtp.Credentials = new NetworkCredential("chaitalipednekar2002@gmail.com", "scmyqxjjchtwjalo");
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
    }
}