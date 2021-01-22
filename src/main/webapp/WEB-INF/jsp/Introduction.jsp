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
	href="<c:url value="/resources/css/bootstrap.min.css" />" />
<link rel="stylesheet"
	href="<c:url value="/resources/css/registration.css?v=08192020" />" />
<link rel="icon"
	href="<c:url value="/resources/images/LACitySealColor_small.png"/>" />
<title>Introduction</title>
<jsp:include page="header.jsp" />
</head>
<body>
	<div class="container">
		<h3 class="text-center">Vendor Registration Requirements</h3>
		<div class="card">
			<div class="card-body">
				<h5 class="font-weight-bold">I. CRITERIA FOR ONLINE
					REGISTRATION OF VENDOR SERVICES</h5>
				<p>The online registration process requires that you meet all of
					the criteria listed below to be able to use the online process:</p>
				<ul>
					<li>You are only opening one business location at this time.</li>
					<li>You have <strong>never</strong> registered your business
						with the City of Los Angeles, Office of Finance. The online form
						is meant for first-time registrants only.
					</li>
					<li><strong>FINANCIAL INSTITUTIONS - </strong> <strong>DO
							NOT</strong> use this online application. If you are a Financial
						Institution seeking an exemption:
						<ol>
							<li><a
								href="https://finance.lacity.org/sites/g/files/wph1051/f/Vendor%20Registration%202%20Page%20Packet.pdf">Please
									click here to fill out the paper form.</a></li>
							<li><a href="<c:url value="/resources/pdfs/Financial Institution Requirements.pdf"/>"
								target="_blank">Prepare the required information in this
									packet.</a></li>
							<li>Then email it to <a
								href="mailto:Finance.CustomerService@lacity.org">Finance.CustomerService@lacity.org</a>
								to begin your registration.
							</li>
						</ol></li>
					<li>To qualify as a Vendor, your business address cannot be located in the City of Los Angeles.</li>
					<li class="text-danger"><strong>It is strongly
							advised that you have a printer ready or are using a device in
							which you are able to save files.</strong> A temporary business tax
						registration certificate will be issued for you to print and
						display at your place of business. A permanent certificate will be
						sent via mail and should arrive within 4 weeks from completing
						your online registration. <strong>PLEASE PRINT OR SAVE
							THE CERTIFICATE WHEN IT IS SHOWN.</strong></li>
				</ul>
				<p>
					If you do not meet all of the criteria listed above or if you
					prefer, you may instead <a
						href="https://finance.lacity.org/sites/g/files/wph1051/f/Vendor%20Registration%202%20Page%20Packet.pdf">click
						here to fill out the paper form </a> and email it to <a
						href="mailto:Finance.CustomerService@lacity.org">Finance.CustomerService@lacity.org</a>.
					This allows you to request a business tax registration but you will
					not immediately get a temporary certificate like you will with this
					application.
				</p>
				<hr />
				<h5 class="font-weight-bold">II. INFORMATION YOU WILL NEED TO
					PROVIDE TO REGISTER A VENDOR SERVICE ONLINE</h5>
				<p>Through this online registration process you will be asked to
					provide information about your business. Please have the following
					information at hand for your registration:</p>
				<ul>
					<li>Description of your Business activities</li>
					<li>Legal Business Name
						<div class="ml-3">Business Name - Doing Business As (DBA)
							(optional)</div>
					</li>
					<li>Business Start Date or services rendered inside the city
						of Los Angeles. This is the date that <strong>you will
							begin</strong> your business activities within the city of Los Angeles or the day your bid was approved by the City department.
					</li>
					<li>Business Type (such as Sole Proprietorship, Partnership,
						Corporation, etc.)</li>
					<li>Primary Business Address
						<div class="ml-3">Mailing Address - if different from your
							primary business address</div>
					</li>
					<li>FEIN/Tax ID number</li>
					<li>Supporting documents</li>
				</ul>
				<hr />
				<h5 class="font-weight-bold">III. DOCUMENTS YOU WILL NEED FOR
					YOUR APPLICATION</h5>
				<p>
					Digital copies in <strong>PDF or JPEG/PNG image format</strong>
					will be needed for the following documents depending on answers you
					select for your business:
				</p>
				<ul>
					<li>Public Utilities Commission Permit</li>
					<li>Motor Carrier Permit</li>
					<li>Air Carrier Operating Permit</li>
					<li>Please contact the Exemption Unit at (213) 978-3050 if you need assistance in identifying these documents.</li>
				</ul>
				<hr />
				<h5 class="font-weight-bold">IV. STEPS TO COMPLETE A VENDOR
					SERVICES ONLINE REGISTRATION</h5>
				<ol type="1">
					<li>Exemption Form
						<p>You will be asked to specify whether or not you will be
							within the city of Los Angeles for 7 or more days, business
							activities, required documents, and FEIN/Tax ID Number</p>
					</li>
					<li>Business Form
						<p>You will be asked to provide the following information
							needed to register a new business: Legal Business Name, Business
							Name/Doing Business As (optional), Business Start Date, Business
							Type, Primary Business Address, Mailing Address (if different
							from primary business address), Filer's Contact Information.</p>
					</li>
					<li>Confirmation
						<p>You will be asked to confirm your answers.</p>
					</li>
					<li>Temporary Tax Registration Certificate
						<p>A temporary business tax registration certificate will be
							issued for you to print and display at your place of business. A
							permanent certificate will be sent via mail and should arrive
							within 4 weeks from completing your on-line registration. Please
							remove the temporary certificate and replace it with the
							permanent certificate.</p>
					</li>
				</ol>
			</div>
			<div class="card-footer text-center">
				<button class="btn btn-secondary" type="button"
					onclick="history.back()">Back</button>
				<button class="btn btn-primary" type="button"
					onclick="window.location='exemption'">Next</button>
			</div>
		</div>
	</div>
	<!-- /.container -->
	<jsp:include page="footer.jsp" />
	<script src="<c:url value="/resources/js/jquery.min.js"/>"></script>
	<script src="<c:url value="/resources/js/popper.min.js"/>"></script>
	<script src="<c:url value="/resources/js/bootstrap.min.js"/>"></script>
	<script src="<c:url value="/resources/js/registration.js?v=08192020"/>"></script>
</body>
</html>