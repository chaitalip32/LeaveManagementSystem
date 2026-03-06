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
        public static void SendPasswordSetupEmail(string email, string token)
        {
            string link = "https://localhost:44300/SetPassword.aspx?token=" + token;

            MailMessage mail = new MailMessage();
            mail.To.Add(email);
            mail.Subject = "Set your Password";

            mail.Body = "Click below link to set your password:\n\n" + link;

            mail.From = new MailAddress("chaitalipednekar2002@gmail.com");

            SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
            smtp.Credentials = new NetworkCredential("chaitalipednekar2002@gmail.com", "scmyqxjjchtwjalo");
            smtp.EnableSsl = true;

            smtp.Send(mail);

        }
    }
}