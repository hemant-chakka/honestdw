<!-- Submit Tender Modal -->
<div class="modal fade" id="verifyAddressModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Address Verification - Send verification letter to</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        	<form method="post" id="SubmitVerifyForm" action="/edit-profile/submitVerification">
				<div class="form-group row">
      				<label for="inputFirstName" class="col-sm-2 col-form-label">First Name</label>
      				<div class="col-sm-10">
        				<input type="text" class="form-control" id="inputFirstName" name="FirstName" placeholder="First Name" value="$CurrentMember.FirstName" required>
      				</div>
    			</div>
    			<div class="form-group row">
      				<label for="inputSurname" class="col-sm-2 col-form-label">Last Name</label>
      				<div class="col-sm-10">
        				<input type="text" class="form-control" id="inputSurname" name="Surname" placeholder="Last Name" value="$CurrentMember.Surname" required>
      				</div>
    			</div>
    			
    			<div class="form-group row">
				     <label for="inputautocomplete" class="col-sm-2 col-form-label">Locate Address</label>
      				<div class="col-sm-10"  id="locationField">
        				<input type="text" class="form-control" id="autocomplete" name="autocomplete" placeholder="Enter your address" onFocus="geolocate()">
      				</div>
    			</div>
    
    			<div class="form-group row">
				      <label for="inputAddressLine1" class="col-sm-2 col-form-label">Address Line1</label>
				      <div class="col-sm-10">
        					<input type="text" id="street_number" disabled="true" class="form-control field" name="AddressLine1" value="$CurrentMember.AddressLine1" placeholder="Address Line1">
      				  </div>
    			</div>
    
			    <div class="form-group row">
      				<label for="inputAddressLine2" class="col-sm-2 col-form-label">Address Line2</label>
      				<div class="col-sm-10">
        				<input type="text" id="route" disabled="true" class="form-control field" name="AddressLine2" value="$CurrentMember.AddressLine2" placeholder="Address Line2">
      				</div>
    			</div>
    
			    <div class="form-group row">
      				<label for="inputCity" class="col-sm-2 col-form-label">City</label>
      				<div class="col-sm-10">
        				<input type="text" id="locality" disabled="true" class="form-control field" name="City" value="$CurrentMember.City" placeholder="City">
      				</div>
    			</div>
    
			    <div class="form-group row"> 
      				<label for="inputState" class="col-sm-2 col-form-label">Region</label>
      				<div class="col-sm-10">
        				<input type="text" id="administrative_area_level_1" class="form-control field" name="State" value="$CurrentMember.State" placeholder="Region" required>
      				</div>
    			</div>
    
    			<div class="form-group row">
      				<label for="inputPostCode" class="col-sm-2 col-form-label">Post Code</label>
      				<div class="col-sm-10">
        				<input type="text" id="postal_code" disabled="true" class="form-control field" name="PostCode" value="$CurrentMember.PostCode" placeholder="Post Code">
      				</div>
    			</div>
    
    			<div class="form-group row">
      				<label for="inputCountry" class="col-sm-2 col-form-label">Country</label>
      				<div class="col-sm-10">
        				<input type="text" id="country" disabled="true" class="form-control field" name="Country" value="$CurrentMember.Country" placeholder="Country">
      				</div>
    			</div>
    			
    			<div class="form-group row">
      				<label for="inputPhoneNumber" class="col-sm-2 col-form-label">Phone Number</label>
      				<div class="col-sm-10">
        				<input type="text" class="form-control" id="inputPhoneNumber" name="PhoneNumber" placeholder="Phone Number" value="$CurrentMember.PhoneNumber" required>
      				</div>
    			</div>
    			<div class="form-group row">
	    			<div class="col-sm-2">&nbsp;</div>
    				<div class="col-sm-10">
        				<button type="submit" class="btn btn-primary">
        					Submit
        					&nbsp;&nbsp;&nbsp;&nbsp;<i class="fa fa-question-circle" data-toggle="tooltip" data-html="true" data-animation="false" data-placement="top" title="$HelpTip(AVSubmit)"></i>
        				</button> 
      				</div>
    			</div>
		    </form>
		    
		    <form method="post" id="VerifyAddressForm" action="/edit-profile/verifyAddress">
				<div class="form-group row">
      				<label for="inputAVCode" class="col-sm-2 col-form-label">Enter Code</label>
      				<div class="col-sm-9">
        				<input type="text" class="form-control" id="inputAVCode" name="AVCode" placeholder="Enter Code" required>
      				</div>
      				<div class="col-sm-1">
      					<i class="fa fa-question-circle pull-right" data-toggle="tooltip" data-html="true" data-animation="false" data-placement="left" title="$HelpTip(AVCode)"></i>
      				</div>
    			</div>
    			<div class="form-group row">
	    			<div class="col-sm-2">&nbsp;</div>
    				<div class="col-sm-10">
        				<button type="submit" class="btn btn-primary">Submit</button> 
      				</div>
    			</div>
		    </form>
		    
      </div>  
      <div class="modal-footer">
      </div>
    </div>
  </div>
</div>