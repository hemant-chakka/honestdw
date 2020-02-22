<form method="post" id="CreateTenderForm" action="/get-prices/previewTender">
    <div class="form-group row nolabel">
      <label for="inputTitle" class="col-sm-2 col-form-label">Job Title</label>
      <div class="col-sm-10">
        <input type="text" class="form-control" id="inputTitle" name="Title" placeholder="Job Title" value="$FormData.Title" required>
      </div>
    </div>
    
    <div class="form-group row nolabel">
      <label for="inputCategoryID" class="col-sm-2 col-form-label">Category</label>
      <div  class="col-sm-5">
        <div class="select-wrap">
          <select name="ParentID" id="inputParentID" class="form-control" required>
    			<% if $Categories %>
    				<option value="">Select a Category..</option>
    				<% loop $Categories %>
    					<option value="$ID" <%if $Top.FormData.ParentID == $ID %>selected<% end_if %>>$Name</option>
    				<% end_loop %>
    			<% end_if %>
    		</select>
      </div>
      </div>
      <div  class="col-sm-5">
        <div class="select-wrap">
        <select name="CategoryID" id="inputCategoryID" class="form-control" required>
        	<option value="">Select a Sub Category..</option>
        	<% if $SubCategories %>
				<% loop $SubCategories %>
					<option value="$ID" <%if $Top.FormData.CategoryID == $ID %>selected<% end_if %>>$Name</option>
				<% end_loop %>
			<% end_if %>
        </select>
      </div>
      </div>
    </div>
    
    <div class="form-group row nolabel">
      <label for="inputDescription" class="col-sm-2 col-form-label">Description</label>
      <div class="col-11 col-sm-9">
        <textarea class="form-control" rows="5" class="form-control" name="Description" id="inputDescription" placeholder="Description">$FormData.Description</textarea>
        
      </div>
      <div class="col-1">
          <i class="fa fa-question-circle " data-toggle="tooltip" data-placement="left" title="$HelpTip(CreateTenderDescription)"></i>
      </div>
      
    </div>
    
    <div class="form-group row nolabel">
      <label for="inputPhotos" class="col-sm-2 col-form-label">Upload Photos</label>
      <div class="col-sm-5 col-11">
        <div id="multiplephotoupload">Upload photos</div>        
      </div>
      <div class="col-1">
        <i class="fa fa-question-circle" data-toggle="tooltip" data-html="true" data-placement="left" title="$HelpTip(CreateTenderUploadImages)"></i>
      </div>
      
      	
      
    </div>
    
    <% if $TenderPhotos %>
			<p><h4>Photos</h4></p>
			<% loop $TenderPhotos %> 
				<% if $FirstCol %>
					<div class="row">
  						<div class="col-3">
  							<% if $TenderImage %>
  								<p><a href="/get-prices/deleteTenderImage/$ID"><i class="fa fa-trash-o" aria-hidden="true"></i></a></p>
  							  	<img src="$TenderImage.CroppedImage(150,150).URL" class="img-responsive">
  								<% if $Cover %><p>Cover Photo</p><% else %><p><a href="/get-prices/setCoverPhoto/$ID">Make Cover</a></p><% end_if %>
  							<% else %>
  								&nbsp;
  							<% end_if %>
  						</div>
  				<% else_if $LastCol %>
  						<div class="col-3">
  							<% if $TenderImage %>
  								<p><a href="/get-prices/deleteTenderImage/$ID"><i class="fa fa-trash-o" aria-hidden="true"></i></a></p>
  							  	<img src="$TenderImage.CroppedImage(150,150).URL" class="img-responsive">
  								<% if $Cover %><p>Cover Photo</p><% else %><p><a href="/get-prices/setCoverPhoto/$ID">Make Cover</a></p><% end_if %>
  							<% else %>
  								&nbsp;
  							<% end_if %>
  						</div>
					</div>	
				<% else %>
						<div class="col-3">
							<% if $TenderImage %>
  								<p><a href="/get-prices/deleteTenderImage/$ID"><i class="fa fa-trash-o" aria-hidden="true"></i></a></p>
  							  	<img src="$TenderImage.CroppedImage(150,150).URL" class="img-responsive">
  								<% if $Cover %><p>Cover Photo</p><% else %><p><a href="/get-prices/setCoverPhoto/$ID">Make Cover</a></p><% end_if %>
  							<% else %>
  								&nbsp;
  							<% end_if %>
						</div>
  				<% end_if %>		
			<% end_loop %>
		<% end_if %>
    
    
    
    <div class="form-group row nolabel">
      <label for="inputVideos" class="col-sm-2 col-form-label">Upload Videos</label>
      <div class="col-sm-5 col-11">
        <div id="multiplevideoupload">Upload videos</div>
      </div>
      <div class="col-1">
        <i class="fa fa-question-circle" data-toggle="tooltip" data-html="true" data-placement="left" title="$HelpTip(CreateTenderUploadVideos)"></i>
      </div>
    </div>
    
    <div class="form-group row nolabel">
      <label for="inputVideos" class="col-sm-2 col-form-label">&nbsp;</label>
      <div class="col-sm-10">
        	<% if $TenderVideos %>
        		<ul class="list-group">
        			<% loop $TenderVideos %>
        				<li class="list-group-item">$Video.Name &nbsp;&nbsp;<a href="/get-prices/deleteTenderVideo/$ID"><i class="fa fa-trash-o" aria-hidden="true"></i></a></li>
        			<% end_loop %>
        		</ul>
        	<% else %>
        		&nbsp;
        	<% end_if %>
      </div>
    </div>
    
    <div class="form-group row nolabel">
      <label for="tenderOptions" class="col-sm-2 col-form-label">&nbsp;</label>
      <div class="col-sm-10">
	      <button type="button" id="TenderOptionsBtn" class="btn btn-primary">
    	   	<span id="TenderOptionsShowDetails" >
        		Tender Options
        	</span>
        	<span id="TenderOptionsHideDetails" style="display:none;">Hide Tender Options</span>
          </button>
      </div>
    </div>
    
    <!-- Begin Tender Options -->
    
    <div id="TenderOptions" style="display:none;">
    
    <% if $CurrentMember.AddressString %>
	    <div class="form-group row nolabel">
    	  <label for="inputUseHomeAddress" class="col-sm-2 col-form-label">Use Home Address</label>
      	  <div class="col-sm-1">
        	<input type="checkbox" id="inputUseHomeAddress" name="UseHomeAddress">
      	  </div>
      	  <div class="col-sm-5">
      	  	<h3>Job Site is Same as Home Address</h3>
      	  </div>
      	  <div class="col-sm-4">
      	  	<i class="fa fa-question-circle" data-toggle="tooltip" data-html="true" data-placement="left" title="$HelpTip(CreateTenderAddressVisibility)"></i>	
      	  	<input type="hidden" id="inputProAddressLine1" name="ProAddressLine1" value="$CurrentMember.AddressLine1">
      	  	<input type="hidden" id="inputProAddressLine2" name="ProAddressLine2" value="$CurrentMember.AddressLine2">
      	  	<input type="hidden" id="inputProCity" name="ProCity" value="$CurrentMember.City">
      	  	<input type="hidden" id="inputProState" name="ProState" value="$CurrentMember.State">
      	  	<input type="hidden" id="inputProPostCode" name="ProPostCode" value="$CurrentMember.PostCode">
      	  	<input type="hidden" id="inputProCountry" name="ProCountry" value="$CurrentMember.Country">
      	  </div>
    	</div>
    <% end_if %>
    
    
    <div class="form-group row nolabel">
      <label for="inputautocomplete" class="col-sm-2 col-form-label">Address of Job</label>
      
      <div class="col-12 col-sm-10"  id="locationField">
        <input type="text" class="form-control field" id="autocomplete" name="autocomplete" placeholder="Address of Job" onFocus="geolocate()">
      </div>
    </div>
    
    <div class="form-group row nolabel">
      <label for="inputAddressLine1" class="col-sm-2 col-form-label">Address Line1</label>
      <div class="col-1">
        <input type="checkbox" id="inputAddressLine1Visible" name="AddressLine1Visible" $FormData.AddressLine1Visible >
      </div>
      <div class="col-11 col-sm-9">
        <input type="text" id="street_number" disabled="true" class="form-control field" name="AddressLine1" value="$FormData.AddressLine1" placeholder="Address Line1">
      </div>
    </div>
    
    <div class="form-group row nolabel">
      <label for="inputAddressLine2" class="col-sm-2 col-form-label">Address Line2</label>
      <div class="col-1">
        <input type="checkbox" id="inputAddressLine2Visible" name="AddressLine2Visible" $FormData.AddressLine2Visible >
      </div>
      <div class="col-11 col-sm-9">
        <input type="text" id="route" disabled="true" class="form-control field" name="AddressLine2" value="$FormData.AddressLine2" placeholder="Address Line2">
      </div>
    </div>
    
    <div class="form-group row nolabel">
      <label for="inputCity" class="col-sm-2 col-form-label">City</label>
      <div class="col-1">
        <input type="checkbox" id="inputCityVisible" name="CityVisible" $FormData.CityVisible >
      </div>
      <div class="col-11 col-sm-9">
        <input type="text" id="locality" disabled="true" class="form-control field" name="City" value="$FormData.City" placeholder="City">
      </div>
    </div>
    
    <div class="form-group row nolabel"> 
      <label for="inputState" class="col-sm-2 col-form-label">Region</label>
      <div class="col-1">
        <i class="fa fa-check-square" aria-hidden="true"></i>
      </div>
      <div class="col-11 col-sm-9">
        <input type="text" id="administrative_area_level_1" class="form-control field" name="State" value="<% if $FormData.State %>$FormData.State<% else %>$CurrentUser.DefaultRegion<% end_if %>" placeholder="Region" required>
      </div>
    </div>
    
    <div class="form-group row nolabel">
      <label for="inputPostCode" class="col-sm-2 col-form-label">Post Code</label>
      <div class="col-1">
        <i class="fa fa-check-square" aria-hidden="true"></i>
      </div>
      <div class="col-11 col-sm-9">
        <input type="text" id="postal_code" disabled="true" class="form-control field" name="PostCode" value="$FormData.PostCode" placeholder="Post Code">
      </div>
    </div>
    
    <div class="form-group row nolabel">
      <label for="inputCountry" class="col-sm-2 col-form-label">Country</label>
      <div class="col-1">
        <i class="fa fa-check-square" aria-hidden="true"></i>
      </div>
      <div class="col-11 col-sm-9">
        <input type="text" id="country" disabled="true" class="form-control field" name="Country" value="$FormData.Country" placeholder="Country">
      </div>
    </div>
    
    
    <div class="form-group row ">
      <div class="col-sm-10 radio-group">
        <h5>Contractor's Price to be</h5>
        <div class="col-sm-8 ">

          <div class="form-check">
            <input class="" type="radio" name="PriceType" value="ContractorToPropose" checked <% if $FormData.PriceType == 'ContractorToPropose' %>checked<% end_if %> required>  
            <label class="form-check-label">Contractor to Propose</label>
          </div>
          <div class="form-check">
            <input class="" type="radio" name="PriceType" value="Fixed" <% if $FormData.PriceType == 'Fixed' %>checked<% end_if %> required>  
            <label class="form-check-label">Fixed Price(Quote)</label>
          </div>
          <div class="form-check">
            <input class="" type="radio" name="PriceType" value="Estimate" <% if $FormData.PriceType == 'Estimate' %>checked<% end_if %> required>  
              <label class="form-check-label">Estimate</label>
          </div>     
        </div>
      </div>
    </div>
    
    <div class="form-group row ">
      <div class="col-sm-10 radio-group">
      <h5>Tender Type</h5>
      <div class="col-sm-10">
      	<div class="form-check">          
      		<input type="radio" name="TenderType" value="Open" checked <% if $FormData.TenderType == 'Open' %>checked<% end_if %> required >  
          <label class="">Open(Visible to All)
      		&nbsp;&nbsp;<i class="fa fa-question-circle " data-toggle="tooltip" data-html="true" data-placement="top" title="$HelpTip(CreateTenderVisible)"></i>
      	 </label>
      </div> 
      <div class="form-check">    		
    			<input type="radio" name="TenderType" value="Closed" <% if $FormData.TenderType == 'Closed' %>checked<% end_if %> required>  
          <label class="">Closed(Selected Contractors)
    			&nbsp;&nbsp;<i class="fa fa-question-circle " data-toggle="tooltip" data-html="true" data-placement="left" title="$HelpTip(CreateTenderClosed)"></i>
    		</label>
      </div>
      </div>
    </div>
  </div>
    
    <div class="form-group row ">
      
      <div class="col-sm-9 col-11">
      	<div class="form-check form-control">  			
  				<input type="checkbox" id="inputViewOnSite" name="ViewOnSite" $FormData.ViewOnSite>  				
          <label for="inputViewOnSite" class="">View on Site</label>  			
		    </div>
      </div>
      <div class="col-1">
        <i class="fa fa-question-circle " data-toggle="tooltip" data-html="true" data-placement="left" title="$HelpTip(CreateTenderVOS)"></i>
      </div>
    </div>
    
    
    <div class="form-group row nolabel" data-toggle="tooltip" data-html="true" data-placement="top" title="$HelpTip(CreateTenderVOSPhone)">
      <label for="inputViewOnSitePhone" class="col-sm-2 col-form-label">View on Site Phone Number</label>
      <div class="col-sm-10 col-11">
        <input type="text" class="form-control" id="inputViewOnSitePhone" name="ViewOnSitePhone" value="$FormData.ViewOnSitePhone" <% if $FormData.ViewOnSite != 'checked' %>disabled<% end_if %> placeholder="View on Site Phone Number">
      </div>
    </div>

    <div class="form-group row ">
        <h5>Tender Start Date</h5>
        <div class='input-group date form_datetime_sd col-md-5 col-11' id='StartDate'>
             <input type='text' class="form-control" size="16" id="inputStartDateDis" name="StartDateDis" value="<% if $FormData.StartDateDis %>$FormData.StartDateDis<% else %>$Now.format(d M Y  h:i a)<% end_if %>" required />
             <span class="input-group-addon">
                 <span class="glyphicon glyphicon-th"><i class="fa fa-calendar" aria-hidden="true"></i></span>
             </span>
        </div>
    </div>
    
    <div class="form-group row ">
        <h5>Tender Close Date</h5>
        <div class='input-group date form_datetime_ed col-md-5 col-11' id='EndDate'>
             <input type='text' class="form-control" size="16" id="inputEndDateDis" name="EndDateDis" value="<% if $FormData.EndDateDis %>$FormData.EndDateDis<% else %>$maxCloseDateDis<% end_if %>" required />
             <span class="input-group-addon">
                 <span class="glyphicon glyphicon-th"><i class="fa fa-calendar" aria-hidden="true"></i></span>
             </span>
        </div>
        <div class="col-1">
      		<i class="fa fa-question-circle " data-toggle="tooltip" data-html="true" data-placement="top" title="$HelpTip(CreateTenderCloseDate)"></i>
      	</div><br/>
    </div>

    <div class="form-group row ">
      <div class="col-sm-10 radio-group">
      <h5>Assess Tender</h5>
      <div class="col-sm-10">
        <div class="form-check">
        	<label class="radio-inline">
        		<input type="radio" name="AssessTenderControl" value="PostEndDate" <% if $FormData.AssessTenderControl == 'PostEndDate' %>checked<% end_if %> required >Award after Close Date
        		&nbsp;&nbsp;<i class="fa fa-question-circle " data-toggle="tooltip" data-html="true" data-placement="left" title="$HelpTip(CreateTenderPostEndDate)"></i>
        	</label>
      		<label class="radio-inline">
      			<input type="radio" name="AssessTenderControl" value="FirstInFirst" checked <% if $FormData.AssessTenderControl == 'FirstInFirst' %>checked<% end_if %> required>Award at Anytime
      			&nbsp;&nbsp;<i class="fa fa-question-circle " data-toggle="tooltip" data-html="true" data-placement="left" title="$HelpTip(CreateTenderFirstInFirst)"></i>
      		</label>
        </div>
      </div>
    </div>
    </div>

    </div> <!-- End Tender Options -->
    
    <div class="form-group row ">
      <label id="cost-zero-text" <% if $FormData.ClientAdvertiseCost %>style="display:none;"<% end_if %> class="col-sm-2 col-form-label">Cost $0.00</label>
      <div class="col-sm-10">
        &nbsp;
      </div>
    </div>
    
    <input type="hidden" id="inputTenderID" name="ID" value="{$BlankTenderID}" /><br/>
    
    <div id="AdditionalInfo" class="form-group" <% if not $AdditionalInfoSelect  %>style="display:none;"<% end_if %>>
    	<h2>Additional Info</h2>
    	
    	<div class="form-group row form-group-bg">
        <div class="col-12 col-sm-5"><label for="inputEstimate" class="col-form-label">Estimate Inc GST(Visible to all)</label></div>
        <div class="col-1 col-sm-1"><input type="checkbox" class="AdditionalInfoCb AdditionalInfoCb2" id="inputEstimate" name="Estimate" $FormData.Estimate></div>
        <div class="col-5 col-sm-3"><input type="text" class="form-control" id="inputClientEstimate" name="ClientEstimate" value="$FormData.ClientEstimate" <% if $FormData.Estimate != 'checked' %>disabled<% end_if %> placeholder="$"></div>
        <div class="col-3 col-sm-1">+ $1</div>
        <div class="col-1 col-sm-2"><i class="fa fa-question-circle " data-toggle="tooltip" data-placement="left" title="$HelpTip(CreateTenderEstimate)"></i></div>
    </div>
    
    <div class="form-group row form-group-bg">
        <div class="col-12 col-sm-5"><label for="inputScheduleOfPrices" class="col-form-label">Schedule of Prices</label></div>
        <div class="col-1 col-sm-1">&nbsp;</div>
        <div class="col-5 col-sm-3"><div id="ScheduleOfPricesUpload">Upload</div></div>
        <div class="col-3 col-sm-1">+ $1</div>
        <div class="col-1 col-sm-2"><i class="fa fa-question-circle " data-toggle="tooltip" data-placement="left" title="$HelpTip(CreateTenderSOP)"></i></div>
    </div>
    
    <% if $TenderDoc('ScheduleOfPricesV2')  %>
      <% loop $TenderDoc('ScheduleOfPricesV2') %>
        <div class="form-group row form-group-bg">
            <div class="col-12 col-sm-5">&nbsp;</div>
            <div class="col-1 col-sm-1">&nbsp;</div>
            <div class="col-5 col-sm-3">$Name</div>
            <div class="col-1 col-sm-1"><a href="/get-prices/deleteTenderDoc/$ID?tenderId=$Top.FormData.ID&doc=ScheduleOfPricesV2"><i class="fa fa-trash-o" aria-hidden="true"></i></a></div>
            <div class="col-sm-2">&nbsp;</div>
        </div>
      <% end_loop %>
    <% end_if %>
    
    <div class="form-group row form-group-bg">
        <div class="col-12 col-sm-5"><label for="inputSpecifications" class="col-form-label">Specifications</label></div>
        <div class="col-1 col-sm-1">&nbsp;</div>
        <div class="col-5 col-sm-3"><div id="SpecificationsUpload">Upload</div></div>
        <div class="col-3 col-sm-1">+ $1</div>
        <div class="col-1 col-sm-2"><i class="fa fa-question-circle " data-toggle="tooltip" data-placement="left" title="$HelpTip(CreateTenderSpecs)"></i></div>
    </div>
    
    <% if $TenderDoc('SpecificationsV2')  %>
      <% loop $TenderDoc('SpecificationsV2') %>
        <div class="form-group row form-group-bg">
            <div class="col-12 col-sm-5">&nbsp;</div>
            <div class="col-1 col-sm-1">&nbsp;</div>
            <div class="col-5 col-sm-3">$Name</div>
            <div class="col-1 col-sm-1"><a href="/get-prices/deleteTenderDoc/$ID?tenderId=$Top.FormData.ID&doc=SpecificationsV2"><i class="fa fa-trash-o" aria-hidden="true"></i></a></div>
            <div class="col-sm-2">&nbsp;</div>
        </div>
      <% end_loop %>
    <% end_if %>
    
    <div class="form-group row form-group-bg">
        <div class="col-12 col-sm-5"><label for="inputDrawings" class="col-form-label">Drawings/Sketch</label></div>
        <div class="col-1 col-sm-1">&nbsp;</div>
        <div class="col-5 col-sm-3"><div id="DrawingsUpload">Upload</div></div>
        <div class="col-3 col-sm-1">+ $1</div>
        <div class="col-1 col-sm-2"><i class="fa fa-question-circle " data-toggle="tooltip" data-placement="left" title="$HelpTip(CreateTenderDrawings)"></i></div>
    </div>
    
    <% if $TenderDoc('DrawingsV2')  %>
      <% loop $TenderDoc('DrawingsV2') %>
        <div class="form-group row form-group-bg">
            <div class="col-12 col-sm-5">&nbsp;</div>
            <div class="col-1 col-sm-1">&nbsp;</div>
            <div class="col-5 col-sm-3">$Name</div>
            <div class="col-1 col-sm-1"><a href="/get-prices/deleteTenderDoc/$ID?tenderId=$Top.FormData.ID&doc=DrawingsV2"><i class="fa fa-trash-o" aria-hidden="true"></i></a></div>
            <div class="col-sm-2">&nbsp;</div>
        </div>
      <% end_loop %>
    <% end_if %>
    
    <div class="form-group row form-group-bg">
        <div class="col-12 col-sm-5"><label for="inputTermsOfPayment" class="col-form-label">Terms of Payment</label></div>
        <div class="col-1 col-sm-1">&nbsp;</div>
        <div class="col-5 col-sm-3"><div id="TermsOfPaymentUpload">Upload</div></div>
        <div class="col-3 col-sm-1">+ $1</div>
        <div class="col-1 col-sm-2"><i class="fa fa-question-circle " data-toggle="tooltip" data-placement="left" title="$HelpTip(CreateTenderTOP)"></i></div>
    </div>
    
    <% if $TenderDoc('TermsOfPaymentV2')  %>
      <% loop $TenderDoc('TermsOfPaymentV2') %>
        <div class="form-group row form-group-bg">
            <div class="col-12 col-sm-5">&nbsp;</div>
            <div class="col-1 col-sm-1">&nbsp;</div>
            <div class="col-5 col-sm-3">$Name</div>
            <div class="col-1 col-sm-1"><a href="/get-prices/deleteTenderDoc/$ID?tenderId=$Top.FormData.ID&doc=TermsOfPaymentV2"><i class="fa fa-trash-o" aria-hidden="true"></i></a></div>
            <div class="col-sm-2">&nbsp;</div>
        </div>
      <% end_loop %>
    <% end_if %>
    
    <div class="form-group row form-group-bg">
        <div class="col-12 col-sm-5"><label for="inputStandardConditions" class="col-form-label">Standard Conditions</label></div>
        <div class="col-1 col-sm-1">&nbsp;</div>
        <div class="col-5 col-sm-3"><div id="StandardConditionsUpload">Upload</div></div>
        <div class="col-3 col-sm-1">+ $1</div>
        <div class="col-1 col-sm-2"><i class="fa fa-question-circle " data-toggle="tooltip" data-placement="left" title="$HelpTip(CreateTenderStdConditions)"></i></div>
    </div>
    
    <% if $TenderDoc('StandardConditionsV2')  %>
      <% loop $TenderDoc('StandardConditionsV2') %>
        <div class="form-group row form-group-bg">
            <div class="col-12 col-sm-5">&nbsp;</div>
            <div class="col-1 col-sm-1">&nbsp;</div>
            <div class="col-5 col-sm-3">$Name</div>
            <div class="col-1 col-sm-1"><a href="/get-prices/deleteTenderDoc/$ID?tenderId=$Top.FormData.ID&doc=StandardConditionsV2"><i class="fa fa-trash-o" aria-hidden="true"></i></a></div>
            <div class="col-sm-2">&nbsp;</div>
        </div>
      <% end_loop %>
    <% end_if %>
    
    <div class="form-group row form-group-bg">
        <div class="col-12 col-sm-5"><label for="inputSpecialConditions" class="col-form-label">Special Conditions</label></div>
        <div class="col-1 col-sm-1">&nbsp;</div>
        <div class="col-5 col-sm-3"><div id="SpecialConditionsUpload">Upload</div></div>
        <div class="col-3 col-sm-1">+ $1</div>
        <div class="col-1 col-sm-2"><i class="fa fa-question-circle " data-toggle="tooltip" data-placement="left" title="$HelpTip(CreateTenderSplConditions)"></i></div>
    </div>
    
    <% if $TenderDoc('SpecialConditionsV2')  %>
      <% loop $TenderDoc('SpecialConditionsV2') %>
        <div class="form-group row form-group-bg">
            <div class="col-12 col-sm-5">&nbsp;</div>
            <div class="col-1 col-sm-1">&nbsp;</div>
            <div class="col-5 col-sm-3">$Name</div>
            <div class="col-1 col-sm-1"><a href="/get-prices/deleteTenderDoc/$ID?tenderId=$Top.FormData.ID&doc=SpecialConditionsV2"><i class="fa fa-trash-o" aria-hidden="true"></i></a></div>
            <div class="col-sm-2">&nbsp;</div>
        </div>
      <% end_loop %>
    <% end_if %>
    
    <div class="form-group row form-group-bg">
        <div class="col-12 col-sm-5"><label for="inputConditionsOfTendering" class="col-form-label">Conditions of Tendering</label></div>
        <div class="col-1 col-sm-1">&nbsp;</div>
        <div class="col-5 col-sm-3"><div id="ConditionsOfTenderingUpload">Upload</div></div>
        <div class="col-3 col-sm-1">+ $1</div>
        <div class="col-1 col-sm-2"><i class="fa fa-question-circle " data-toggle="tooltip" data-placement="left" title="$HelpTip(CreateTenderCOT)"></i></div>
    </div>
    
    <% if $TenderDoc('ConditionsOfTenderingV2')  %>
      <% loop $TenderDoc('ConditionsOfTenderingV2') %>
        <div class="form-group row form-group-bg">
            <div class="col-12 col-sm-5">&nbsp;</div>
            <div class="col-1 col-sm-1">&nbsp;</div>
            <div class="col-5 col-sm-3">$Name</div>
            <div class="col-1 col-sm-1"><a href="/get-prices/deleteTenderDoc/$ID?tenderId=$Top.FormData.ID&doc=ConditionsOfTenderingV2"><i class="fa fa-trash-o" aria-hidden="true"></i></a></div>
            <div class="col-sm-2">&nbsp;</div>
        </div>
      <% end_loop %>
    <% end_if %>
    
    <div class="form-group row ">
        <div class="col-sm-5"><h3>Details to be submitted with Price</h3></div>
        
    </div>
      
      <div class="form-group row form-group-bg">
        <div class="col-sm-5"><label for="inputHealthSafetyPolicyRequired" class="col-form-label">Health & Safety Policy</label></div>
        <div class="col-1 col-sm-1"><input type="checkbox" class="AdditionalInfoCb2" name="HealthSafetyPolicyRequired" $FormData.HealthSafetyPolicyRequired></div>
        <div class="col-10 col-sm-6"><i class="fa fa-question-circle " data-toggle="tooltip" data-placement="left" title="$HelpTip(CreateTenderHSP)"></i></div>
    </div>
    
    <div class="form-group row form-group-bg">
        <div class="col-sm-5"><label for="inputTenderDocRequired" class="col-form-label">Tender Documents</label></div>
        <div class="col-1 col-sm-1"><input type="checkbox" class="AdditionalInfoCb2" name="TenderDocRequired" $FormData.TenderDocRequired></div>
        <div class="col-10 col-sm-6"><i class="fa fa-question-circle" data-toggle="tooltip" data-placement="left" title="$HelpTip(CreateTenderTenderDoc)"></i></div>
    </div>
    
    <div class="form-group row form-group-bg">
        <div class="col-sm-5"><label for="inputCoverLetterRequired" class="col-form-label">Cover Letter</label></div>
        <div class="col-1 col-sm-1"><input type="checkbox" class="AdditionalInfoCb2" name="CoverLetterRequired" $FormData.CoverLetterRequired></div>
        <div class="col-10 col-sm-6"><i class="fa fa-question-circle" data-toggle="tooltip" data-placement="left" title="$HelpTip(CreateTenderCoverLetter)"></i></div>
    </div>
    
    <div class="form-group row form-group-bg">
        <div class="col-sm-5"><label for="inputDrawingsRequired" class="col-form-label">Drawings/Sketch</label></div>
        <div class="col-1 col-sm-1"><input type="checkbox" class="AdditionalInfoCb2" name="DrawingsRequired" $FormData.DrawingsRequired></div>
        <div class="col-10 col-sm-6"><i class="fa fa-question-circle" data-toggle="tooltip" data-placement="left" title="$HelpTip(CreateTenderDrawings)"></i></div>
    </div>
		
		<div class="form-group row ">
  			<div class="col-5 col-sm-5"><input type="text" class="form-control" id="inputOthersText" name="OthersText" value="$FormData.OthersText" <% if $FormData.OthersRequired != 'checked' %>disabled<% end_if %> placeholder="Other" ></div>
  			<div class="col-1 col-sm-1"><input type="checkbox" class="AdditionalInfoCb2" id="inputOthersRequired" name="OthersRequired" $FormData.OthersRequired></div>
  			<div class="col-4 col-sm-6"><i class="fa fa-question-circle" data-toggle="tooltip" data-placement="left" title="$HelpTip(CreateTenderOthers)"></i></div>
		</div>
		
		<div class="form-group row ">
  			<div class="col-sm-5"><label class="col-form-label"><h4>Total cost of Tender $<span id="TotalTenderCost">$TenderAdCost</span></h4></label></div>
  			<div class="col-sm-1">
  				<input type="hidden" id="ClientAdvertiseCost" name="ClientAdvertiseCost" value="$TenderAdCost" >
  				<input type="hidden" id="AdditionalInfoSelect" name="AdditionalInfoSelect" value="$TenderAdCost" >
  			</div>
  			<div class="col-sm-6">&nbsp;</div>
		</div>
    </div>
    
     <div class="form-group row ">  
      <div class="col-sm-10">
        <div class="g-recaptcha" data-theme="dark" data-sitekey="$SiteConfig.GoogleRecaptchaSiteKey"></div>
      </div>
    </div> 
    
    
    <div class="form-group row ">
      <div class="col-sm-10">
        <button type="submit" id="ReviewBtn" class="btn btn-primary">Review</button> 
        <button type="button" id="AdditionalInfoBtn" <% if $FormData.AdditionalInfoSelect > 0 %>disabled<% end_if %> class="btn btn-primary">
        	<span id="AddDetails" <% if $AdditionalInfoSelect %>style="display:none;"<% end_if %>>
        		Additional Details
        		&nbsp;&nbsp;&nbsp;&nbsp;<i class="fa fa-question-circle" data-toggle="tooltip" data-placement="left" title="$HelpTip(CreateTenderAdditionalDetails)"></i>
        	</span>
        	<span id="LessDetails" <% if not $AdditionalInfoSelect %>style="display:none;"<% end_if %>>Less Details</span>
        </button>
      </div>
    </div>
</form>