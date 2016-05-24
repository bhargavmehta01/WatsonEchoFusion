<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search Page</title>

<link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">   
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<link rel="stylesheet" 
href="http://cdn.datatables.net/1.10.2/css/jquery.dataTables.min.css"></style>
<script type="text/javascript" 
src="http://cdn.datatables.net/1.10.2/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" 
src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

 <script type="text/javascript">
	function performReg() {
		x=document.getElementById("Name").value;
       	alert(x);
        window.location.href = "register?name="+x;
	}    	
</script>

</head>
<body>

<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="#">HackRU</a>
    </div>
    <!--  <ul class="nav navbar-nav">
      <li class="active"><a href="<%=request.getContextPath() %>/start">Search</a></li>
    </ul>-->
  </div>
</nav>






<div class="container">
<form class="form-horizontal" role="form">
  <div class="form-group">
    <label class="control-label col-sm-2" for="Name">Name:</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" id="Name" placeholder="What do you want me to call you?">
    </div>
  </div>


 
  <div class="form-group"> 
    <div class="col-sm-offset-2 col-sm-10">
   	<iframe src="upload.jsp" frameBorder="0"></iframe><br>
      <button type="button" class="btn btn-success" onclick="performReg()">Submit</button>
    </div>
    
   
	
  </div>
</form>


</div>
</body>
</html>