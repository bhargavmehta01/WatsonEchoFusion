<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">   
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<link rel="stylesheet" 
href="http://cdn.datatables.net/1.10.2/css/jquery.dataTables.min.css"></style>
<script type="text/javascript" 
src="http://cdn.datatables.net/1.10.2/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" 
src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

<style>
.btn-file {
    position: relative;
    overflow: hidden;
}
.btn-file input[type=file] {
    position: absolute;
    top: 0;
    right: 0;
    min-width: 100%;
    min-height: 100%;
    font-size: 100px;
    text-align: right;
    filter: alpha(opacity=0);
    opacity: 0;
    outline: none;
    background: white;
    cursor: inherit;
    display: block;
}
</style>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Upload Image</title>
</head>
<body>
	
	
	<form id="form1">	 
		<label for="sampleFile">Select a profile picture</label>
		<span class="btn btn-default btn-file">
   		 Browse <input type="file" id="sampleFile" name="sampleFile" >
   
		</span>
	  <!--  <input id="sampleFile" name="sampleFile" type="file"/> <br/> -->	
		<button type="button" class="btn btn-primary" id="uploadBtn" value="Upload Profile Picture" onClick="performAjaxSubmit();">Upload</button>
	<!--  	<input id="uploadBtn" type="button" value="Upload Profile Picture" onClick="performAjaxSubmit();"></input> -->
	</form>
	
	<div id="imgdiv" style="display:none">
	<p>Profile Picture:</p>
		<img src="<%=request.getContextPath() %>/img/" id="img1" style="height:100px;width:100px;">
	</div>
	
	
	
	<script type="text/javascript">
        function performAjaxSubmit() {
        	var sampleFile = document.getElementById("sampleFile").files[0];
        	var filsrc="";	
        	var formdata = new FormData();
        	formdata.append("sampleFile", sampleFile);	        		
        		
        	var xhr = new XMLHttpRequest();
        		
        	xhr.open("POST","upload", true);
        	xhr.send(formdata);
        		
        	xhr.onload = function(e) {
	       		if (this.status == 200) {
	       			filesrc=this.responseText;
	       			document.getElementById("form1").style.display="none";
	       			var imgsrc=document.getElementById("img1").getAttribute("src");
	       			var finalsrc=imgsrc+"/"+filesrc;
	       			document.getElementById("img1").setAttribute("src", finalsrc);
	       			document.getElementById("imgdiv").style.display="";
	       		}
	        };	        		
        }
        	
	</script>
	
	

</body>
</html>