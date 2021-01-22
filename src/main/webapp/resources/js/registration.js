/**
 * 
 */
//Exemption form
function enableSubmit() {
	$('#submit-button').prop('disabled', false);
	$('#submit-button').removeClass('btn-danger');
	$('#submit-button').removeClass('cursor-not-allowed');
	$('#submit-button').addClass('btn-primary');
}

function disableSubmit() {
	$('#submit-button').prop('disabled', true);
	$('#submit-button').addClass('btn-danger');
	$('#submit-button').addClass('cursor-not-allowed');
	$('#submit-button').removeClass('btn-primary');
}

$('#btrc-yes').change(function() {
	if ($('#btrc-yes').is(':checked')) {
		var c = false; 
		c = confirm('This application is for FIRST-TIME registrants only.\n' +
				'You will be sent to the vendor paper form to renew your certificate.\n' +
				'Please complete the form and email to Finance.CustomerService@lacity.org.\n' +
				'Click OK to proceed or Cancel to continue with a new registration.\n');
		if(c) {
			window.location.href='https://finance.lacity.org/sites/g/files/wph1051/f/Vendor%20Registration%202%20Page%20Packet.pdf';
		} else {
			$('#btrc-no').prop('checked', true);
		}
	}
});

$('#will-work-in-LA').change(function() {
	if ($('#will-work-in-LA').is(':checked')) {
		var c = false; 
		c = confirm('Businesses working in LA for more than 7 days must complete a different application.\n' +
					'You will be directed to the Business Tax Registration Certificate form.\n' +
					'Please complete the form and email to Finance.CustomerService@lacity.org.\n' +
					'Click OK to proceed or Cancel to continue with a new registration.\n');
		if(c) {
			window.location.href='https://finance.lacity.org/sites/g/files/wph1051/f/2020%20BTRC%20Application_0.pdf';
		} else {
			$('#wont-work-in-LA').prop('checked', true);
		}
	}
});

function toggleUpload(checkbox, div, upload) {
	if ($(checkbox).is(':checked')) {
		$(div).show();
		if(checkbox != '#L049-checkbox') {
			$(upload).attr('required', true);
		}
	} else {
		$(div).hide();
		$(upload).attr('required', false);
		$(upload).tooltip('hide');
	}
}

$('#puc-checkbox').change(function() {
	toggleUpload('#puc-checkbox', '#puc-div', '#puc-upload');
});

$('#mc-checkbox').change(function() {
	toggleUpload('#mc-checkbox', '#mc-div', '#mc-upload');
});

$('#L049-checkbox').change(function() {
	toggleUpload('#L049-checkbox', '#acop-div', '#acop-upload');
});

function disableForVessel() {
	$('#business-description').attr('readonly', true);
}

function checkFileSize(id) {
	var field = $(id);
	if(field[0].files[0].size > 10000000 || (field[0].files[0].type != 'image/png' && field[0].files[0].type != 'image/jpeg' && field[0].files[0].type != 'application/pdf') ) {
		field[0].value = '';
		field.tooltip('show');
	} else {
		field.tooltip('hide');
	}
}

function submitExemption() {
	var qualifyForNonProfit = false;
	var qualifyForVendor = false;
	var c = false;
	
	$('.fund-class-input').each( function() {
		if($(this).prop('checked')) {
			qualifyForNonProfit = true;
			c = true;
		}
	});
	if(!qualifyForNonProfit) {
		c = confirm('One or more qualifying business activities need to be selected to register as a vendor.  ' +
				'You will be sent to the regular Business Registration.  ' +
				'Click OK to proceed or Cancel to remain on this page.  ');
	}	
	return c;
}

//Registration
function getMinimumDate() {
	var date = new Date();
	var year = date.getFullYear();
	var month = date.getMonth() + 1;
	if(month<10) {
		month = '0'+ month;
	}
	var day = date.getDate();
	if(day<10) {
		day = '0' + day;
	}
	return year + '-' + month + '-' + day;
}
/*
$('#start-date').attr('min', getMinimumDate());
$('#start-date').val(getMinimumDate());*/

$("input[name=vsr]").change(function () {
    if ($('#vsr-yes').is(":checked")) {
		$('#business-description').val('Vessel Speed Reduction');
		$('#business-description').attr('readonly', true);
    } else {
    	$('#business-description').val('');
		$('#business-description').attr('readonly', false);
    }
});

$('#business-description').on('input', function(){
    var maxLength = $(this).attr('maxlength');
    var currentLength = $(this).val().length;    
    $('#characters-remaining').text(maxLength - currentLength)	    
});


function toggleMailing() {
	if ($('#mailing-address-checkbox').is(':checked')) {
		$('#mailing-address-form').hide();
	} else {
		$('#mailing-address-form').show();
	}
}

$('#mailing-address-checkbox').change(function() {
	toggleMailing();
});

$('.phone-input').keyup(function () {
	if ($(this).attr('name') == 'phoneAreaCodeContact') {
		if(this.value.length == this.maxLength) {
			$('#phoneStartContact').focus();    
		}
	}
	if ($(this).attr('name') == 'phoneStartContact') {
		if(this.value.length == this.maxLength) {
			$('#phoneEndContact').focus();    
		}
	}			
});

var phone = $('.phone-input');

function submitForm() {
	var check = ['los angeles', 'losangeles', 'la'];
	
	for(var i = 0; i < check.length; i++) {
		if( $('#city').val().toLowerCase() == check[i])  {
			$('#city').val('');
			break;
		}
	}
	
	var inputs = $('#registration-form').find('input');
	for(var i = 0; i < inputs.length; i++) {
		if(inputs[i].id.indexOf("email") == -1) 
			inputs[i].value = inputs[i].value.toUpperCase();
	}	
	
	if ($('#mailing-address-checkbox').is(':checked')) {
		var businessAddress = $('#business-address').find('input, select');
		var mailingAddress = $('#mailing-address').find('input, select');
		for(var i = 0; i < businessAddress.length; i++) {
			if(mailingAddress[i+2].type!='radio') {
				mailingAddress[i+2].value = businessAddress[i].value;
			} else {
				mailingAddress[i+2].checked = businessAddress[i].checked;
			}		
		}		
	}	
}

//Address validation
function submitAddress() {
	var selected = $('.address-selector');
	var index = -1;
	for (var i = 0; i < selected.length; i++) {
		if (selected[i].checked) {
			index = i;
			break;
		}
	}
	
	if(index > -1) {
		$('#stdAddress').val($('#'+index+'-line1').text());
		$('#city-new').val($('#'+index+'-city').text());
		$('#state-new').val($('#'+index+'-state').text());
		$('#zip-new').val($('#'+index+'-zip').text());
	}
	
	selected = $('.address-selector-mailing');
	index = -1;
	for (var i = 0; i < selected.length; i++) {
		if (selected[i].checked) {
			index = i;
			break;
		}
	}
	
	if(index > -1) {
		$('#stdAddress-mailing').val($('#'+index+'-line1-mailing').text());
		$('#city-mailing-new').val($('#'+index+'-city-mailing').text());
		$('#state-mailing-new').val($('#'+index+'-state-mailing').text());
		$('#zip-mailing-new').val($('#'+index+'-zip-mailing').text());
	}
}