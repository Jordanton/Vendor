<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<div class="form-group row">
	<label class="col-12 col-form-label">Please carefully read and
		select one or more Business Activity categories that best match to
		your business from below. If none of the Business Activities apply to
		your business, you will be redirected to our Regular Business
		Registration page.</label>
</div>
<hr />
<fieldset id="group-1" class="fund-class-group">
	<legend class="legend-fund-class">&nbsp 1 &nbsp</legend>
	<div class="form-group">
		<h5 class="text-underline">Child Care and Social Assistance</h5>
		<p>
			You provide <strong>non-medical</strong> child care in a daycare
			setting.
		</p>
	</div>
	<div class="form-group">
		<h5 class="text-underline">Tugboat Services</h5>
		<p>You provide tugboat services.</p>
	</div>
	<div class="form-group">
		<h5 class="text-underline">Wholesale sales</h5>
		<p>
			You provide <strong>wholesale</strong> sales of goods, wares, or
			merchandise for the purpose of resale.
		</p>
		<div class="form-check-inline checkbox-highlight">
			<form:checkbox class="form-check-input fund-class-input"
				path="fundClass" value="LGR1" />
			<label class="form-check-label">Check here if your business
				belongs in this category.</label>
		</div>
	</div>
</fieldset>
<fieldset id="group-2" class="fund-class-group">
	<legend class="legend-fund-class">&nbsp 2 &nbsp</legend>
	<div class="form-group">
		<h5 class="text-underline">Property Rentals</h5>
		<p>You provide rentals of commercial, hotel, or residential units.</p>
	</div>
	<div class="form-group">
		<h5 class="text-underline">Radio, Television, and Theater</h5>
		<p>You assist radio or television shows, either as a
			service for the show or actual production of the show.</p>
		<p>Also covered are businesses operating theaters for live
			entertainment or motion picture movie theaters including drive-in
			theaters.</p>
	</div>
	<div class="form-group">
		<h5 class="text-underline">Retail Sales</h5>
		<p>
			You provide <strong>retail</strong> sales of goods, wares, or
			merchandise for any purpose NOT INCLUDING resale.
		</p>
	</div>
	<div class="form-group">
		<h5 class="text-underline">Swap Meet and Antique Sales</h5>
		<p>You operate swap meets and antique sales, including shops and
			shows.</p>
	</div>
	<div class="form-group">
		<h5 class="text-underline">Telecommunications</h5>
		<p>You provide phone and internet services.</p>
		<div class="form-check-inline checkbox-highlight">
			<form:checkbox class="form-check-input fund-class-input"
				path="fundClass" value="LGR2" />
			<label class="form-check-label">Check here if your business
				belongs in this category.</label>
		</div>
	</div>
</fieldset>
<fieldset id="group-3" class="fund-class-group">
	<legend class="legend-fund-class">&nbsp 3 &nbsp</legend>
	<div class="form-group">
		<h5 class="text-underline">Educational and Medical Institutions</h5>
		<p>You run a school or similar educational facility, or medical
			facility such as a hospital or nursing home.</p>
		<h5 class="text-underline">LAWA Airline Carriers</h5>
		<p>
			You run an air carrier service with Los Angeles World Airport
			(LAWA). <strong>Air Carrier Operating Permit is
				required.</strong>
		</p>
		<h5 class="text-underline">Professions, Occupations</h5>
		<p>You provide professional or occupational services and skilled
			work. Examples include but are not limited to: attorneys, auto
			mechanics, barbers, teachers, and medical professionals.</p>
		<h5 class="text-underline">Vessel Speed Reduction</h5>
		<p>You will be applying for the Vessel Speed Reduction incentive.</p>
		<div class="form-check-inline checkbox-highlight">
			<form:checkbox class="form-check-input fund-class-input"
				id="L049-checkbox" path="fundClass" value="L049" />
			<label class="form-check-label">Check here if your business
				belongs in this category.</label>
		</div>
		<div class="form-group row" id="acop-div">
			<label class="col-12 my-3 form-check-label">Provide your
				Airline Carrier Operating Permit here, if applicable.</label>
			<div class="col-12">
				<input type="file" id="acop-upload" name="file" accept="image/*,.pdf" onchange="checkFileSize('#acop-upload')" data-toggle="tooltip" data-placement="right" title="File does not meet restrictions"/> <label
					class="form-text text-danger">Only PDF files or PNG,
					JPEG/JPG images are accepted.</label>
			</div>
		</div>
	</div>
</fieldset>
<fieldset class="fund-class-group">
	<legend class="legend-fund-class">&nbsp 4 &nbsp</legend>
	<div class="form-group">
		<h5 class="text-underline"> Transporting Persons for Hire or Trucking/Hauling</h5>
		<p>You will be providing transportation for up to 9 passengers by
			motor vehicles. <strong>Public Utilities Commission Permit is
				required.</strong></p>
		<div class="form-check-inline checkbox-highlight">
			<form:checkbox class="form-check-input fund-class-input"
				id="puc-checkbox" path="fundClass" value="L194" />
			<label class="form-check-label">Check here if your business
				belongs in this category.</label>
		</div>
	</div>
	<div class="form-group row" id="puc-div">
		<label class="col-12 mb-3 form-check-label">Provide your
			Public Utilities Commission Permit here.</label>
		<div class="col-12">
			<input type="file" id="puc-upload" name="file" accept="image/*,.pdf" onchange="checkFileSize('#puc-upload')" data-toggle="tooltip" data-placement="right" title="File does not meet restrictions"/> <label
				class="form-text text-danger">Only PDF files or PNG,
				JPEG/JPG images are accepted.</label>
		</div>
	</div>
	<div class="form-group">
		<p>You will be providing transportation of goods and materials by
			motor vehicles.  <strong>Motor Carrier Permit is
				required.</strong></p>
		<div class="form-check-inline checkbox-highlight">
			<form:checkbox class="form-check-input fund-class-input"
				id="mc-checkbox" path="fundClass" value="L195" />
			<label class="form-check-label">Check here if your business
				belongs in this category.</label>
		</div>
	</div>
	<div class="form-group row" id="mc-div">
		<label class="col-12 mb-3 form-check-label">Provide your
			Motor Carrier Permit here.</label>
		<div class="col-12">
			<input type="file" id="mc-upload" name="file" accept="image/*,.pdf" onchange="checkFileSize('#mc-upload')" data-toggle="tooltip" data-placement="right" title="File does not meet restrictions"/> <label
				class="form-text text-danger">Only PDF files or PNG,
				JPEG/JPG images are accepted.</label>
		</div>
	</div>
</fieldset>