<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<!-- Bootstrap core CSS -->
	<link href="../resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	
	<!-- Additional CSS Files -->
	<link rel="stylesheet" href="../resources/assets/css/fontawesome.css">
	<link rel="stylesheet" href="../resources/assets/css/first-default.css">
	<link rel="stylesheet" href="../resources/assets/css/owl.css">
	<link rel="stylesheet" href="../resources/assets/css/lightbox.css">
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

	
	<title>SEEK.PARTNERs</title>
</head>
<body>



	<div class="container" style="display:none;">
		<div class="row">
			<div class="col-md-4 col-md-offset-4">
				<div class="login-panel panel panel-default">0
					<div class="panel-heading">
						<h3 class="panel-title">Logout Page</h3>
					</div>
					<div class="panel-body">
						<form role="form" name="logoutToMain" method='post' action="/member/seekMemberLogout">
							<fieldset>
								
								<!-- Change this to a button or input when using this as a form -->
								<a href="index.html" class="btn btn-lg btn-success btn-block">Logout</a>
							</fieldset>
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

<!-- jQuery -->
<script src="/resources/vendor/jquery/jquery.min.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="/resources/vendor/bootstrap/js/bootstrap.min.js"></script>

<!-- Metis Menu Plugin JavaScript -->
<script src="/resources/vendor/metisMenu/metisMenu.min.js"></script>

<!-- Custom Theme JavaScript -->
<script src="/resources/dist/js/sb-admin-2.js"></script>

<script>
	document.logoutToMain.submit();
</script>
</body>
</html>