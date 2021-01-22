<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="stylesheet"
	href="<c:url value="/resources/css/bootstrap.min.css" />"/>
<link rel="stylesheet"
	href="<c:url value="/resources/css/registration.css?v=08192020" />"/>
<link rel="icon"
	href="<c:url value="/resources/images/LACitySealColor_small.png"/>"/>
<title>Business Activities</title>
<jsp:include page="header.jsp" />
</head>
<body>
	<div class="container">
		<h3 class="text-center">Vendor Registration Form</h3>
		<form:form class="form-horizontal" id="exemption-form"
			onSubmit="return submitExemption()" modelAttribute="vendorInfo"
			method="post" action="exemption" enctype="multipart/form-data">
			<div class="card">
				<div class="card-body">
					<form:errors cssClass="error"
						cssStyle="color: red; font-weight: bold"></form:errors>
					<div class="form-group row">
						<label class="col-12 form-text required">indicates
							required field</label>
					</div>
					<fieldset>
						<legend class="px-3 legend-section">Business Activities</legend>
						<div class="form-group row">
							<div class="col-md-6">
								<label class="required"> Have you ever
									had a Business Tax Registration Certificate with Los Angeles?</label> <label
									class="text-danger">If you answer 'YES', you will be
									directed to a different application.</label>
							</div>
							<div class="col-md-6">
								<div class="col-md-4 form-check form-check-inline">
									<input type="radio" class="form-check-input" required
										name="new-registration" id="btrc-yes" value="true" /> <label
										class="form-check-label">Yes</label>
								</div>
								<div class="col-md-2 form-check form-check-inline">
									<input type="radio" class="form-check-input"
										name="new-registration" id="btrc-no" value="false" checked/> <label
										class="form-check-label">No</label>
								</div>
							</div>
						</div>
						<div class="form-group row">
							<div class="col-md-6">
								<label class="required">Through physical presence, will
									you or your employees perform work or render services within the City of
									Los Angeles for seven (7) or more days per calendar year?</label> <label
									class="text-danger">If you answer 'YES', you will be
									directed to a different application.</label> 
									<br/><small class="text-underline" data-toggle="help" data-placement="left" title="You
									are engaged in business within the City of Los Angeles when,
									through the physical presence of yourself, your employees, your
									agents, or your equipment, you carry on activities with the
									City of Los Angeles which are designed to solicit, promote,
									stimulate, or otherwise encourage the sale of goods, wares, or
									merchandise seven (7) or more days per calendar year. This
									includes the delivery of your merchandise within the City of
									Los Angeles in vehicles owned and operated by you or your
									employees.">What does this mean?</small>
							</div>
							<hr />
							<div class="col-md-6">
								<div class="col-md-4 form-check form-check-inline">
									<form:radiobutton class="form-check-input" id="will-work-in-LA"
										value="true" path="longerThanAWeek" required="required" />
									<label class="form-check-label" for="will-work-in-LA">Yes</label>
								</div>
								<div class="col-md-2 form-check form-check-inline">
									<form:radiobutton class="form-check-input" id="wont-work-in-LA"
										value="false" path="longerThanAWeek" checked="true" />
									<label class="form-check-label" for="won't-work-in-LA">No</label>
								</div>
							</div>
						</div>
						<hr />
						<jsp:include page="BusinessActivities.jsp" />
					</fieldset>
					<fieldset>
						<legend class="px-3 legend-section">Supporting
							Information</legend>
						<!-- <div class="form-group row">
							<div class="col-md-12">
								<label for="tax-attachment" class="form-check-label">Attached
									hereto or on file with the Office of Finance:</label>
							</div>
						</div>
						<div class="form-group row">
							<div class="col-md-9 offset-md-3 form-check">
								<div>
									<input type="checkbox" id="trucking-form" /> <label>Trucking
										Form</label> <br /> <input type="file" id="trucking-form" name="file" />
								</div>
							</div>
						</div> -->
						<form:errors path="file" cssClass="error" cssStyle="color: red"></form:errors>
						<div class="form-group row">
							<div class="mx-3">
								<label class="required">FEIN/Tax ID Number:</label>
								<form:input class="form-control" type="text" id="fein"
									path="fein" maxlength="9" placeholder="XXXXXXXXX"
									required="required" pattern="^[0-9]{9}$" />
								<label class="form-text text-muted">Please enter WITHOUT
									dashes or symbols</label>
								<form:errors path="fein" cssClass="error"
									cssStyle="color: red; font-weight: bold"></form:errors>
							</div>
						</div>
					</fieldset>
				</div>
				<div class="form-group row">
					<div class="g-recaptcha m-auto" data-sitekey="${siteKey}" data-callback="enableSubmit" data-expired-callback="disableSubmit"></div>
				</div>
				<div class="card-footer text-center">
					<button class="btn btn-secondary" type="button" onclick="window.location.href='../vendor/'">Back</button>
					<button id="submit-button" class="btn btn-danger cursor-not-allowed" type="submit" disabled>Next</button>
				</div>
			</div>
		</form:form>
	</div>
	<!-- /.container -->
	<jsp:include page="footer.jsp" />
	<script src="https://www.google.com/recaptcha/api.js"></script>
	<script
		src="<c:url value="/resources/js/jquery.min.js"/>"></script>
	<script
		src="<c:url value="/resources/js/popper.min.js"/>"></script>
	<script
		src="<c:url value="/resources/js/bootstrap.min.js"/>"></script>
	<script
		src="<c:url value="/resources/js/registration.js?v=08192020"/>"></script>
	<script>
		toggleUpload('#puc-checkbox', '#puc-div', '#puc-upload');
		toggleUpload('#mc-checkbox', '#mc-div', '#mc-upload');
		toggleUpload('#L049-checkbox', '#acop-div', '#acop-upload');

		$(function() {
			$('[data-toggle="tooltip"]').tooltip({trigger: 'manual'})
		})	
		
		$(function() {
			$('[data-toggle="help"]').tooltip()
		})	
	</script>
</body>
</html>