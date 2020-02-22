<section id="contact">
   <div class="container">
   		$Message
   		<p>$Content</p>
   		<h2>Log in</h2>
   		<p>If you already have an account, you can <a href='/Security/login'>log in here</a></p>
   		<h2>Register</h2>
		
		<form id="Form_RegistrationForm" action="/register/doRegister" method="post" enctype="application/x-www-form-urlencoded">
		    
		    <p>Fields marked * are required.</p>
		    
		    <div class="form-group row">
      			<label for="Form_RegistrationForm_FirstName" class="col-sm-2 col-form-label">First Name *</label>
      			<div class="col-sm-10">
        			<input type="text" class="form-control" id="Form_RegistrationForm_FirstName" name="FirstName" required="required" placeholder="First Name">
      			</div>
    		</div>


			<div class="form-group row">
      			<label for="Form_RegistrationForm_Surname" class="col-sm-2 col-form-label">Last Name *</label>
      			<div class="col-sm-10">
        			<input type="text" class="form-control" id="Form_RegistrationForm_Surname" required="required" name="Surname" placeholder="Last Name">
      			</div>
    		</div>
    		
    		<div class="form-group row">
      			<label for="Form_RegistrationForm_TradeUserName" class="col-sm-2 col-form-label">Trade Name/User Name *</label>
      			<div class="col-sm-10">
        			<input type="text" class="form-control" id="Form_RegistrationForm_TradeUserName" required="required" name="TradeUserName" placeholder="Trade Name/User Name">
      			</div>
    		</div>

			<div class="form-group row">
      			<label for="Form_RegistrationForm_Email" class="col-sm-2 col-form-label">Email *</label>
      			<div class="col-sm-10">
        			<input type="email" class="form-control" id="Form_RegistrationForm_Email" required="required" aria-required="true" name="Email" placeholder="Email">
      			</div>
    		</div>


			<div class="form-group row">
      			<label for="Password_Password" class="col-sm-2 col-form-label">Password *</label>
      			<div class="col-sm-10">
        			<input type="password" class="form-control" id="Password_Password" name="Password[_Password]" placeholder="Password" required="required" autocomplete="off">
      			</div>
    		</div>


			<div class="form-group row">
      			<label for="Password_ConfirmPassword" class="col-sm-2 col-form-label">Confirm Password *</label>
      			<div class="col-sm-10">
        			<input type="password" class="form-control" id="Password_ConfirmPassword" name="Password[_ConfirmPassword]" placeholder="Confirm Password" required="required" autocomplete="off">
      			</div>
    		</div>
    		
    		<div class="form-group row">
      			<label for="Form_RegistrationForm_PhoneNumber" class="col-sm-2 col-form-label">Phone Number</label>
      			<div class="col-sm-10">
        			<input type="text" class="form-control" id="Form_RegistrationForm_PhoneNumber" aria-required="true" name="PhoneNumber" placeholder="Phone Number">
        			<p>(This won't be displayed)</p>
        			<input type="hidden" name="PreSubmitTender" value="<% if $PreSubmitTender %>1<% else %>0<% end_if %>">
      			</div>
    		</div>
    		
    		<div class="form-group row">
      			<label for="Form_RegistrationForm_Iagree" class="col-sm-2 col-form-label">&nbsp;</label>
      			<div class="col-sm-10">
        			<input type="checkbox" id="inputIagree" name="Iagree" required > I agree to <a href="/about/terms-and-conditions/" target="_blank">Terms and Conditions</a>
      			</div>
    		</div>
    		
    		<div class="form-group row">
      			<label class="col-sm-2 col-form-label">&nbsp;</label>
      			<div class="col-sm-10">
        			<div class="g-recaptcha" data-sitekey="$SiteConfig.GoogleRecaptchaSiteKey"></div>
      			</div>
    		</div>
	
			<div class="form-group row">
    			<div class="col-sm-10">
        			<button type="submit" name="action_doRegister" id="Form_RegistrationForm_action_doRegister" class="btn btn-primary">Submit</button> 
      			</div>
    		</div>
		</form>
		
    </div>
</section>
