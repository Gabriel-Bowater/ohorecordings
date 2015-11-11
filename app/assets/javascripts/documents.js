$(function() {
  $('#s3_uploader').S3Uploader();
  
  $('#s3_uploader').bind('s3_upload_failed', function(e, content) {
    return alert(content.filename + ' failed to upload');
  });
});