using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;

namespace WebAppAjax
{
    /// <summary>
    /// Summary description for upload
    /// </summary>
    public class upload : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            int chunk = context.Request["chunk"] != null ? int.Parse(context.Request["chunk"]) : 0;
            //string fileName = context.Request["name"] != null ? context.Request["name"] : string.Empty;

            string fileName = context.Request.Form["name"];

            HttpPostedFile fileUpload = context.Request.Files[0];
            //string fileName = fileUpload.FileName;

            var uploadPath = context.Server.MapPath("~/TicketUploads");
            using (var fs = new FileStream(Path.Combine(uploadPath, fileName), chunk == 0 ? FileMode.Create : FileMode.Append))
            {
                var buffer = new byte[fileUpload.InputStream.Length];
                fileUpload.InputStream.Read(buffer, 0, buffer.Length);

                fs.Write(buffer, 0, buffer.Length);
            }

            context.Response.ContentType = "text/plain";
            context.Response.Write("Success");
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}