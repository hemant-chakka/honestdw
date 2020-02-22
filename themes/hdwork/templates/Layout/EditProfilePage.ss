<% loop $CurrentMember %>
<section id="contact">
   <div class="container">
   		$Top.Message
   		<p>$Content</p>
   		<h2>Edit Profile</h2>
		
		<form id="Form_EditProfileForm" action="/edit-profile/saveProfile" method="post" enctype="application/x-www-form-urlencoded">
		    
		    <p>Fields marked * are required.</p>
		    
		    <div class="form-group row">
      			<label for="Form_EditProfileForm_FirstName" class="col-sm-2 col-form-label">First Name *</label>
      			<div class="col-sm-10">
        			<input type="text" class="form-control" id="Form_EditProfileForm_FirstName" name="FirstName" value="$FirstName" required="required" placeholder="First Name">
      			</div>
    		</div>


			<div class="form-group row">
      			<label for="Form_EditProfileForm_Surname" class="col-sm-2 col-form-label">Last Name *</label>
      			<div class="col-sm-10">
        			<input type="text" class="form-control" id="Form_EditProfileForm_Surname" required="required" name="Surname" value="$Surname" placeholder="Last Name">
      			</div>
    		</div>
    		
    		<div class="form-group row">
      			<label for="Form_EditProfileForm_TradeUserName" class="col-sm-2 col-form-label">Trade Name/User Name *</label>
      			<div class="col-sm-10">
        			<input type="text" class="form-control" id="Form_EditProfileForm_TradeUserName" required="required" name="TradeUserName" value="$TradeUserName" placeholder="Trade Name/User Name">
      			</div>
    		</div>

			<div class="form-group row">
      			<label for="Form_EditProfileForm_Email" class="col-sm-2 col-form-label">Email *</label>
      			<div class="col-sm-10">
        			<input type="email" class="form-control" id="Form_EditProfileForm_Email" required="required" aria-required="true" name="Email" value="$Email" placeholder="Email">
      			</div>
    		</div>


			<div class="form-group row">
      			<label for="Password_Password" class="col-sm-2 col-form-label">Password</label>
      			<div class="col-sm-10">
        			<input type="password" class="form-control" id="Password_Password" name="Password[_Password]" placeholder="Password" autocomplete="off">
      			</div>
    		</div>


			<div class="form-group row">
      			<label for="Password_ConfirmPassword" class="col-sm-2 col-form-label">Confirm Password</label>
      			<div class="col-sm-10">
        			<input type="password" class="form-control" id="Password_ConfirmPassword" name="Password[_ConfirmPassword]" placeholder="Confirm Password" autocomplete="off">
      			</div>
    		</div>
    		
    		<div class="form-group row">
      			<label for="Form_EditProfileForm_PhoneNumber" class="col-sm-2 col-form-label">Phone Number</label>
      			<div class="col-sm-10">
        			<input type="text" class="form-control" id="Form_EditProfileForm_PhoneNumber" aria-required="true" name="PhoneNumber" value="$PhoneNumber" placeholder="Phone Number">
        			<p>(This won't be displayed)</p>
      			</div>
    		</div>
    		
    		<div id="profile-details-outer" style="display:none;">
    		<div class="form-group row">
      			<label for="Form_EditProfileForm_CategoriesInterested" class="col-sm-2 col-form-label">Categories I'm interested in</label>
      			<div class="col-sm-10">
      				<select name="CategoriesInterested[]" id="inputCategoriesInterested" class="form-control" multiple>
  						<% if $Top.Categories %>
				  			<% loop $Top.Categories %>
  								<option value="$ID" $Top.CurrentMember.SelectedCat($ID)>$Name</option>
  							<% end_loop %>
  						<% end_if %>
  					</select>
      			</div>
    		</div>
    		
    		<div class="form-group row">
      			<label for="Form_EditProfileForm_BusinessProfile" class="col-sm-2 col-form-label">Business Profile</label>
      			<div class="col-sm-10">
        			<textarea class="form-control" rows="5" class="form-control" name="BusinessProfile" id="inputBusinessProfile" placeholder="Business Profile">$BusinessProfile</textarea>
      			</div>
    		</div>
    		
    		<div class="form-group row">
      			<label for="Form_EditProfileForm_Logo" class="col-sm-2 col-form-label">Logo</label>
      			<div class="col-sm-10">
        			<div id="memberlogoupload">Upload</div>
      			</div>
    		</div>
    		
    		<% if $LogoID %>
    			<div class="form-group row">
      				<div class="col-sm-2"></div>
      				<div class="col-sm-10">
        				<img src="$Logo.CroppedImage(150,150).URL" class="img-responsive">
      				</div>
    			</div>
    		<% end_if %>
    		
    		<div class="form-group row">
      			<label for="Form_EditProfileForm_RegionsWork" class="col-sm-2 col-form-label">Regions I'll work in</label>
      			<div class="col-sm-10">
      				<select name="RegionsWork[]" id="inputRegionsWork" class="form-control" multiple>
  						<% if $Top.Regions %>
				  			<% loop $Top.Regions %>
  								<option value="$ID" $Top.CurrentMember.SelectedRegion($ID)>$Name</option>
  							<% end_loop %>
  						<% end_if %>
  					</select>
      			</div>
    		</div>
    		
    		<div class="form-group row">
      			<label for="Form_EditProfileForm_Portfolios" class="col-sm-2 col-form-label">Portfolio of work (photos)</label>
      			<div class="col-sm-10">
        			<div id="memberportfolioupload">Upload</div>
      			</div>
    		</div>
    		
    		<% if $Portfolios %>
    			<% loop $Portfolios %>
					<% if $Top.StartOfRow($Pos,4) %>
						<div class="row">
							<div class="col-sm-6 col-md-3">
								<img src="$CroppedImage(150,150).URL" class="img-responsive">
							</div>
					<% else_if $Top.EndOfRow($Pos,4) %>
							<div class="col-sm-6 col-md-3">
								<img src="$CroppedImage(150,150).URL" class="img-responsive">
							</div>
						</div>
					<% else %>
						<div class="col-sm-6 col-md-3">
							<img src="$CroppedImage(150,150).URL" class="img-responsive">
						</div>				
					<% end_if %>
					<% if $Last %>
						<% if $Top.BlankCols($TotalItems,4) %>
							<% loop $Top.BlankCols($TotalItems,4) %>
								<div class="col-sm-6 col-md-3">&nbsp;</div>			
							<% end_loop %>
							</div>
						<% end_if %>
					<% end_if %>
				<% end_loop %>
    		<% end_if %>
    		
    		<div class="form-group row">
      			<label for="Form_EditProfileForm_Certifications" class="col-sm-2 col-form-label">Qualifications / Certifications</label>
      			<div class="col-sm-10">
        			<textarea class="form-control" rows="5" class="form-control" name="Certifications" id="inputCertifications" placeholder="Qualifications/Certifications">$Certifications</textarea>
      			</div>
    		</div>
    		
    		<div class="form-group row">
      			<label for="Form_EditProfileForm_HourlyRates" class="col-sm-2 col-form-label">Hourly Rates</label>
      			<div class="col-sm-10">
        			<textarea class="form-control" rows="5" class="form-control" name="HourlyRates" id="inputHourlyRates" placeholder="Hourly Rates">$HourlyRates</textarea>
      			</div>
    		</div>
    		
    		</div>
			
			<div class="form-group row">
    			<div class="col-sm-4">
        			<button type="submit" name="action_SaveProfile" id="Form_EditProfileForm_action_SaveProfile" class="btn btn-primary">Submit</button> 
      			</div>
      			<div class="col-sm-4">
    	   			<% if $Verified %>
        			 	Address Verified <i class="fa fa-check" aria-hidden="true"></i> 
           		 	<% else %>
        			 	<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#verifyAddressModal">Verify Address</button>
	       			<% end_if %>
      			</div>
      			<div class="col-sm-4">
        			<button type="button" id="Form_EditProfileForm_Profile_Details" class="btn btn-primary">
        				<span id="show-text">Show Profile Details</span>
        				<span id="hide-text" style="display:none;">Hide Profile Details</span>
        			</button>
      			</div>
    		</div>
		</form>
		
    </div>
</section>
<% end_loop %>

<% include VerifyAddressModal %>