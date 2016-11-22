<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="WebAppAjax.Index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <style type="text/css">@import url(Scripts/plupload/jquery.plupload.queue/css/jquery.plupload.queue.css);</style>
    <script type="text/javascript" src="http://www.google.com/jsapi"></script>
    <script type="text/javascript">
        google.load("jquery", "1.3");
    </script>
    <script type="text/javascript" src="/plupload/js/gears_init.js"></script>
    <script type="text/javascript" src="http://bp.yahooapis.com/2.4.21/browserplus-min.js"></script>
    <script type="text/javascript" src="Scripts/plupload/plupload.full.min.js"></script>
    <script type="text/javascript" src="Scripts/plupload/jquery.plupload.queue/jquery.plupload.queue.min.js"></script>
    <script type="text/javascript">
        $(function () {

            $("#click").click(function (e) {

                var uploader = $('#uploader').pluploadQueue();
                uploader.start();
                //$('#uploader').plupload('start');
                e.preventDefault();
            });
            

        $("#uploader").pluploadQueue({
            // General settings
            runtimes : 'gears,flash,silverlight,browserplus,html5',
            url : '/upload.ashx',
            max_file_size : '10mb',
            chunk_size : '1mb',
            unique_names : true,
            // Resize images on clientside if we can
            //resize : {width : 320, height : 240, quality : 90},
            // Specify what files to browse for
            filters : [
                {title : "Image files", extensions : "jpg,gif,png"},
                {title : "Zip files", extensions : "zip"}
            ],
            // Flash settings
            flash_swf_url : 'Scripts/plupload/Moxie.swf',
            // Silverlight settings
            silverlight_xap_url: '/Scripts/plupload/Moxie.xap'
        });

        // Client side form validation
        $('form').submit(function(e) {
            var uploader = $('#uploader').pluploadQueue();
            // Validate number of uploaded files
            if (uploader.total.uploaded == 0) {
                // Files in queue upload them first
                if (uploader.files.length > 0) {
                    // When all files are uploaded submit form
                    uploader.bind('UploadProgress', function() {
                        if (uploader.total.uploaded == uploader.files.length)
                            $('form').submit();
                    });
                    uploader.start();
                } else
                    alert('You must at least upload one file.');
                e.preventDefault();
            }
        });
    });
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <div id="uploader">
                <p>You browser doesn't have Flash, Silverlight, Gears, BrowserPlus or HTML5 support.</p>
         </div>
        <div>
           <span>
               <a id="click" href="#" ">Confirm</a>
           </span>
        </div>
    </form>
</body>
</html>
