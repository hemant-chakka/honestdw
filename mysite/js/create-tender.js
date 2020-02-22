(function($) {
	$("document").ready(function(){

		var mutiplePhotoUpload = $("#multiplephotoupload").uploadFile({
			url:"/get-prices/uploadImages",
			multiple:true,
			dragDrop:true,
			fileName:"myphoto",
			uploadStr:"Upload photos",
			statusBarWidth: 320,
			maxFileCount:imageCount,
			allowedTypes: "jpg,jpeg,png,gif",
			maxFileSize: 20971520,
			formData: {"TenderID":$("#inputTenderID").val()},
			afterUploadAll:function(obj)
			{
				//location.reload();
			}
			/*
			extraHTML:function()
			{
			    	var html = "<div><b>Cover photo:</b>  <input type='radio' name='cover_photo' onclick='setValue(this)'  /> <br/>";
					html += "</div>";
					return html;    		
			},
			autoSubmit:false */
		});
		
		$("#startmultiplephotoupload").click(function(){

			mutiplePhotoUpload.startUpload();
		
		});
		
		
		$("#multiplevideoupload").uploadFile({
			url:"/get-prices/uploadVideos",
			multiple:true,
			dragDrop:true,
			fileName:"myvideo",
			uploadStr:"Upload videos",
			statusBarWidth: 320,
			maxFileCount:videoCount,
			allowedTypes: "mp4,m4v,mov,wmv,avi,mpg,ogv,avi",
			maxFileSize: 104857600,
			formData: {"TenderID":$("#inputTenderID").val()}
		});
		
		
		$("#ScheduleOfPricesUpload").uploadFile({
			url:"/get-prices/uploadAdditionalDoc",
			multiple:true,
			dragDrop:false,
			maxFileCount:sopCount,
			fileName:"myfile",
			formData: {"TenderID":$("#inputTenderID").val(),"DocType":"ScheduleOfPricesV2"},
			showDelete: true,
			deleteCallback: function (data, pd) {
				for (var i = 0; i < data.length; i++) {
			        $.post("/get-prices/deleteAdditionalDoc", {op: "delete",fileId: data,tenderId :$("#inputTenderID").val(),doc:"ScheduleOfPricesV2"},
			            function (resp,textStatus, jqXHR) {
			                //Show Message	
			                //alert(resp);
			            });
			    }
			    pd.statusbar.hide(); 

			},
			afterUploadAll:function(obj)
			{
				//$('#ScheduleOfPricesUpload .ajax-file-upload').css("background-color", "green");
				//updateCost();
				//updateCount();
				
			},
			onSuccess:function(files,data,xhr,pd)
			{
				updateCost();
				updateCount();
			}
		});
		
		$("#SpecificationsUpload").uploadFile({
			url:"/get-prices/uploadAdditionalDoc",
			multiple:true,
			dragDrop:false,
			maxFileCount:specsCount,
			fileName:"myfile",
			formData: {"TenderID":$("#inputTenderID").val(),"DocType":"SpecificationsV2"},
			showDelete: true,
			deleteCallback: function (data, pd) {
				for (var i = 0; i < data.length; i++) {
			        $.post("/get-prices/deleteAdditionalDoc", {op: "delete",fileId: data,tenderId :$("#inputTenderID").val(),doc:"SpecificationsV2"},
			            function (resp,textStatus, jqXHR) {
			                //Show Message	
			                //alert(resp);
			            });
			    }
			    pd.statusbar.hide(); 

			},

			afterUploadAll:function(obj)
			{
				//$('#SpecificationsUpload .ajax-file-upload').css("background-color", "green");
				//updateCost();
				//updateCount();
			},
			onSuccess:function(files,data,xhr,pd)
			{
				updateCost();
				updateCount();
			}
		});
		
		$("#DrawingsUpload").uploadFile({
			url:"/get-prices/uploadAdditionalDoc",
			multiple:true,
			dragDrop:false,
			maxFileCount:drawingsCount,
			fileName:"myfile",
			formData: {"TenderID":$("#inputTenderID").val(),"DocType":"DrawingsV2"},
			showDelete: true,
			deleteCallback: function (data, pd) {
				for (var i = 0; i < data.length; i++) {
			        $.post("/get-prices/deleteAdditionalDoc", {op: "delete",fileId: data,tenderId :$("#inputTenderID").val(),doc:"DrawingsV2"},
			            function (resp,textStatus, jqXHR) {
			                //Show Message	
			                //alert(resp);
			            });
			    }
			    pd.statusbar.hide(); 

			},
			afterUploadAll:function(obj)
			{
				//$('#DrawingsUpload .ajax-file-upload').css("background-color", "green");
				//updateCost();
				//updateCount();
			},
			onSuccess:function(files,data,xhr,pd)
			{
				updateCost();
				updateCount();
			}
		});
		
		$("#TermsOfPaymentUpload").uploadFile({
			url:"/get-prices/uploadAdditionalDoc",
			multiple:true,
			dragDrop:false,
			maxFileCount:topCount,
			fileName:"myfile",
			formData: {"TenderID":$("#inputTenderID").val(),"DocType":"TermsOfPaymentV2"},
			showDelete: true,
			deleteCallback: function (data, pd) {
				for (var i = 0; i < data.length; i++) {
			        $.post("/get-prices/deleteAdditionalDoc", {op: "delete",fileId: data,tenderId :$("#inputTenderID").val(),doc:"TermsOfPaymentV2"},
			            function (resp,textStatus, jqXHR) {
			                //Show Message	
			                //alert(resp);
			            });
			    }
			    pd.statusbar.hide(); 

			},
			afterUploadAll:function(obj)
			{
				//$('#TermsOfPaymentUpload .ajax-file-upload').css("background-color", "green");
				//updateCost();
				//updateCount();
			},
			onSuccess:function(files,data,xhr,pd)
			{
				updateCost();
				updateCount();
			}
		});
		
		$("#StandardConditionsUpload").uploadFile({
			url:"/get-prices/uploadAdditionalDoc",
			multiple:true,
			dragDrop:false,
			maxFileCount:stdcondCount,
			fileName:"myfile",
			formData: {"TenderID":$("#inputTenderID").val(),"DocType":"StandardConditionsV2"},
			showDelete: true,
			deleteCallback: function (data, pd) {
				for (var i = 0; i < data.length; i++) {
			        $.post("/get-prices/deleteAdditionalDoc", {op: "delete",fileId: data,tenderId :$("#inputTenderID").val(),doc:"StandardConditionsV2"},
			            function (resp,textStatus, jqXHR) {
			                //Show Message	
			                //alert(resp);
			            });
			    }
			    pd.statusbar.hide(); 

			},
			afterUploadAll:function(obj)
			{
				//$('#StandardConditionsUpload .ajax-file-upload').css("background-color", "green");
				//updateCost();
				//updateCount();
			},
			onSuccess:function(files,data,xhr,pd)
			{
				updateCost();
				updateCount();
			}
		});
		
		$("#SpecialConditionsUpload").uploadFile({
			url:"/get-prices/uploadAdditionalDoc",
			multiple:true,
			dragDrop:false,
			maxFileCount:spcondCount,
			fileName:"myfile",
			formData: {"TenderID":$("#inputTenderID").val(),"DocType":"SpecialConditionsV2"},
			showDelete: true,
			deleteCallback: function (data, pd) {
				for (var i = 0; i < data.length; i++) {
			        $.post("/get-prices/deleteAdditionalDoc", {op: "delete",fileId: data,tenderId :$("#inputTenderID").val(),doc:"SpecialConditionsV2"},
			            function (resp,textStatus, jqXHR) {
			                //Show Message	
			                //alert(resp);
			            });
			    }
			    pd.statusbar.hide(); 

			},
			afterUploadAll:function(obj)
			{
				//$('#SpecialConditionsUpload .ajax-file-upload').css("background-color", "green");
				//updateCost();
				//updateCount();
			},
			onSuccess:function(files,data,xhr,pd)
			{
				updateCost();
				updateCount();
			}
		});
		
		$("#ConditionsOfTenderingUpload").uploadFile({
			url:"/get-prices/uploadAdditionalDoc",
			multiple:true,
			dragDrop:false,
			maxFileCount:cotCount,
			fileName:"myfile",
			formData: {"TenderID":$("#inputTenderID").val(),"DocType":"ConditionsOfTenderingV2"},
			showDelete: true,
			deleteCallback: function (data, pd) {
				for (var i = 0; i < data.length; i++) {
			        $.post("/get-prices/deleteAdditionalDoc", {op: "delete",fileId: data,tenderId :$("#inputTenderID").val(),doc:"ConditionsOfTenderingV2"},
			            function (resp,textStatus, jqXHR) {
			                //Show Message	
			                //alert(resp);
			            });
			    }
			    pd.statusbar.hide(); 

			},
			afterUploadAll:function(obj)
			{
				//$('#ConditionsOfTenderingUpload .ajax-file-upload').css("background-color", "green");
				//updateCost();
				//updateCount();
			},
			onSuccess:function(files,data,xhr,pd)
			{
				updateCost();
				updateCount();
			}
		});
		
		
		$.extend(true, $.fn.datetimepicker.defaults, {
			icons: {
				time: 'fa fa-clock-o',
				date: 'fa fa-calendar',
				up: 'fa fa-arrow-up',
				down: 'fa fa-arrow-down',
				previous: 'fa fa-chevron-left',
				next: 'fa fa-chevron-right',
				today: 'fa fa-calendar-check',
				clear: 'fa fa-trash-alt',
				close: 'fa fa-times-circle'
			}
		});
	
		$('#StartDate').datetimepicker({
			format: 'DD MMM YYYY hh:mm a',
			minDate: moment()
		});
	
		$('#EndDate').datetimepicker({
			format: 'DD MMM YYYY hh:mm a', 
			minDate: moment(),
			maxDate: moment().add(6,'months')
		});
		
		$( "#TenderOptionsBtn" ).click( function(){
			$( "#TenderOptions" ).toggle();
			$( "#TenderOptionsShowDetails" ).toggle();
			$( "#TenderOptionsHideDetails" ).toggle();
		});
		
		
		$( "#AdditionalInfoBtn" ).click( function(){
			$( "#AdditionalInfo" ).toggle();
			$( "#AddDetails" ).toggle();
			$( "#LessDetails" ).toggle();
		});
		
		
		$( ".AdditionalInfoCb" ).click( function(){
			
			if($(this).is(":checked"))
				cost++;
			else
				cost--;
			
			$( "#TotalTenderCost" ).html(cost);
			
			$( "#ClientAdvertiseCost" ).val(cost);
			
			if(cost > 0)
				$('#cost-zero-text').hide();
			else
				$('#cost-zero-text').show();
		});
		
		function updateCost(){
			cost++;
			$( "#TotalTenderCost" ).html(cost);
			$( "#ClientAdvertiseCost" ).val(cost);
			if(cost > 0)
				$('#cost-zero-text').hide();
			else
				$('#cost-zero-text').show();
		}
		
		$( ".AdditionalInfoCb2" ).click( function(){
			
			if($(this).is(":checked"))
				count++;
			else
				count--;
			
			if(count > 0)
				$('#AdditionalInfoBtn').attr('disabled','disabled');
			else
				$('#AdditionalInfoBtn').removeAttr('disabled');
			
			$( "#AdditionalInfoSelect" ).val(count);
				
			
		});
		
		function updateCount(){
			count++;
			if(count > 0)
				$('#AdditionalInfoBtn').attr('disabled','disabled');
			else
				$('#AdditionalInfoBtn').removeAttr('disabled');
			
			$( "#AdditionalInfoSelect" ).val(count);
		}
		
		
		$( ".AdditionalInfoCb3" ).click( function(){
			
				var btn = $(this).attr('data-doc');
				
				if($(this).is(":checked")){
					$('#'+btn+' .ajax-file-upload').css("background-color", "red");
				
				}else{
					$('#'+btn+' .ajax-file-upload').css("background-color", "#fff");
				}
			
		});
		
		$( ".AdditionalInfoCb3" ).each(function () {
			/*
			var btn = $(this).attr('data-doc');
			if($(this).is(":checked")){
				$('#'+btn+' .ajax-file-upload').css("background-color", "red");
			
			}else{
				$('#'+btn+' .ajax-file-upload').css("background-color", "#fff");
			} */
	    });
		
		$( "#inputParentID" ).change(function() {
			$.get( "get-prices/getSubCategoriesDD?parentID="+$(this).val(), function( data ) {
				  $("#inputCategoryID").html( data );
				  $("#inputCategoryID").removeClass('ng-valid');
				});
		});
		
		$( "#inputCategoryID" ).change(function() {
			if($(this).val() != '')
				$(this).addClass('ng-valid');
			else
				$(this).removeClass('ng-valid');
		});
		
		$( "#inputViewOnSite" ).click( function(){
			
			if($(this).is(":checked")){
				$('#inputViewOnSitePhone').removeAttr('disabled');
			}else{
				$('#inputViewOnSitePhone').attr('disabled','disabled');
			}
			
		});
		
		$( "#inputEstimate" ).click( function(){
			
			if($(this).is(":checked")){
				$('#inputClientEstimate').removeAttr('disabled');
				$('#inputClientEstimate').attr('required','required');
			}else{
				$('#inputClientEstimate').attr('disabled','disabled');
				$('#inputClientEstimate').removeAttr('required');
			}
			
		});
		
		$( "#inputOthersRequired" ).click( function(){
			
			if($(this).is(":checked")){
				$('#inputOthersText').removeAttr('disabled');
				$('#inputOthersText').attr('required','required');
			}else{
				$('#inputOthersText').attr('disabled','disabled');
				$('#inputOthersText').removeAttr('required');
			}
			
		});
		
		$( "#inputUseHomeAddress" ).click( function(){
			if($(this).is(":checked")){
				$('#street_number').removeAttr('disabled');
				$('#street_number').val($('#inputProAddressLine1').val());
				
				$('#route').removeAttr('disabled');
				$('#route').val($('#inputProAddressLine2').val());
				
				$('#locality').removeAttr('disabled');
				$('#locality').val($('#inputProCity').val());
				
				$('#administrative_area_level_1').val($('#inputProState').val());
				
				$('#postal_code').removeAttr('disabled');
				$('#postal_code').val($('#inputProPostCode').val());
				
				$('#country').removeAttr('disabled');
				$('#country').val($('#inputProCountry').val());
				
				
			}
		});
		
		
		$( "#ReviewBtn" ).click( function(){
			if($('#administrative_area_level_1').val()=="") {
				$( "#TenderOptions" ).show();
				$( "#TenderOptionsShowDetails" ).hide();
				$( "#TenderOptionsHideDetails" ).show();
		    }
		});
		
	});
})(jQuery)



function setValue(obj){
	
	var group = jQuery('input[name="cover_photo"]');
	
	group.each(function () {
		jQuery(this).val('');
    });
	
	jQuery(obj).val('cover');
	
}


// This example displays an address form, using the autocomplete feature
// of the Google Places API to help users fill in the information.

// This example requires the Places library. Include the libraries=places
// parameter when you first load the API. For example:
// <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&libraries=places">

var placeSearch, autocomplete;
var componentForm = {
		street_number: 'short_name',
        route: 'long_name',
        locality: 'long_name',
        administrative_area_level_1: 'short_name',
        country: 'long_name',
        postal_code: 'short_name'
      };

function initAutocomplete() {
        // Create the autocomplete object, restricting the search to geographical
        // location types.
        autocomplete = new google.maps.places.Autocomplete(
            /** @type {!HTMLInputElement} */(document.getElementById('autocomplete')),
            {
            	types: ['geocode'],
            	componentRestrictions: {country: 'nz'}
            
            });

        // When the user selects an address from the dropdown, populate the address
        // fields in the form.
        autocomplete.addListener('place_changed', fillInAddress);
}

function fillInAddress() {
        // Get the place details from the autocomplete object.
        var place = autocomplete.getPlace();

        for (var component in componentForm) {
          document.getElementById(component).value = '';
          document.getElementById(component).disabled = false;
        }

        // Get each component of the address from the place details
        // and fill the corresponding field on the form.
        for (var i = 0; i < place.address_components.length; i++) {
          var addressType = place.address_components[i].types[0];
          if (componentForm[addressType]) {
            var val = place.address_components[i][componentForm[addressType]];
            document.getElementById(addressType).value = val;
          }
        }
}

// Bias the autocomplete object to the user's geographical location,
// as supplied by the browser's 'navigator.geolocation' object.
function geolocate() {
        if (navigator.geolocation) {
          navigator.geolocation.getCurrentPosition(function(position) {
            var geolocation = {
              lat: position.coords.latitude,
              lng: position.coords.longitude
            };
            var circle = new google.maps.Circle({
              center: geolocation,
              radius: position.coords.accuracy
            });
            autocomplete.setBounds(circle.getBounds());
          });
        }
}
