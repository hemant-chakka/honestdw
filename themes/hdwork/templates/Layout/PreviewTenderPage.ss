<section>
   <div class="container">
   		<h2>$Title</h2>
   		$Message
        <p>$Content</p>
   		<p><h3>Basic Info</h3></p>
   		<div class="row">
  			<div class="col-4"><strong>Tender Number</strong></div>
  			<div class="col-8"><strong>$FormData.ID</strong></div>
		</div>
   		<div class="row">
  			<div class="col-4">Title</div>
  			<div class="col-8">$FormData.Title</div>
		</div>
		<div class="row">
  			<div class="col-4">Category</div>
  			<div class="col-8">$ParentCategoryName/$CategoryName</div>
		</div>
		<div class="row">
  			<div class="col-4">Description</div>
  			<div class="col-8">$FormData.Description</div>
		</div>
		
		<% if $TenderPhotos %>
			<p><h4>Photos</h4></p>
			<% loop $TenderPhotos %> 
				<% if $FirstCol %>
					<div class="row">
  						<div class="col-3">
  							<% if $TenderImage %>  <img src="$TenderImage.CroppedImage(150,150).URL" class="img-responsive"><% else %>&nbsp;<% end_if %>
  							<% if $TenderImage %>
  								<% if $Cover %><p>Cover Photo</p><% else %><p><a href="/get-prices/setCoverPhoto/$ID">Make Cover</a></p><% end_if %>
  							<% else %>
  								&nbsp;
  							<% end_if %>
  						</div>
  				<% else_if $LastCol %>
  						<div class="col-3">
  							<% if $TenderImage %><img src="$TenderImage.CroppedImage(150,150).URL" class="img-responsive"><% else %>&nbsp;<% end_if %>
  							<% if $TenderImage %>
  								<% if $Cover %><p>Cover Photo</p><% else %><p><a href="/get-prices/setCoverPhoto/$ID">Make Cover</a></p><% end_if %>
  							<% else %>
  								&nbsp;
  							<% end_if %>
  						</div>
					</div>	
				<% else %>
						<div class="col-3">
							<% if $TenderImage %><img src="$TenderImage.CroppedImage(150,150).URL" class="img-responsive"><% else %>&nbsp;<% end_if %>
							<% if $TenderImage %>
  								<% if $Cover %><p>Cover Photo</p><% else %><p><a href="/get-prices/setCoverPhoto/$ID">Make Cover</a></p><% end_if %>
  							<% else %>
  								&nbsp;
  							<% end_if %>
						</div>
  				<% end_if %>		
			<% end_loop %>
		<% end_if %>
		
		<% if $TenderVideos %>
			<p><h4>Videos</h4></p>
			<ul class="list-group">
				<% loop $TenderVideos %> 
					<li class="list-group-item">$Video.Name</li>		
				<% end_loop %>
			</ul>
		<% end_if %>
		
		<div class="row">
  			<div class="col-4">&nbsp;</div>
  			<div class="col-2">Visible to Tederers?</div>
  			<div class="col-6">&nbsp;</div>
		</div>
		<div class="row">
  			<div class="col-4">Address Line1</div>
  			<div class="col-2">
  				<% if $FormData.AddressLine1Visible == 'checked' %>
  					<i class="fa fa-check-square" aria-hidden="true"></i>
  				<% else %>
  					<i class="fa fa-square-o" aria-hidden="true"></i>
  				<% end_if %>
  			</div>
  			<div class="col-6">$FormData.AddressLine1</div>
		</div>
		<div class="row">
  			<div class="col-4">Address Line2</div>
  			<div class="col-2">
  				<% if $FormData.AddressLine2Visible == 'checked' %>
  					<i class="fa fa-check-square" aria-hidden="true"></i>
  				<% else %>
  					<i class="fa fa-square-o" aria-hidden="true"></i>
  				<% end_if %>
  			</div>
  			<div class="col-6">$FormData.AddressLine2</div>
		</div>
		<div class="row">
  			<div class="col-4">City</div>
  			<div class="col-2">
  				<% if $FormData.CityVisible == 'checked' %>
  					<i class="fa fa-check-square" aria-hidden="true"></i>
  				<% else %>
  					<i class="fa fa-square-o" aria-hidden="true"></i>
  				<% end_if %>
  			</div>
  			<div class="col-6">$FormData.City</div>
		</div>
		<div class="row">
  			<div class="col-4">Region</div>
  			<div class="col-2"><i class="fa fa-check-square" aria-hidden="true"></i></div>
  			<div class="col-6">$FormData.State</div>
		</div>
		<div class="row">
  			<div class="col-4">Post Code</div>
  			<div class="col-2"><i class="fa fa-check-square" aria-hidden="true"></i></div>
  			<div class="col-6">$FormData.PostCode</div>
		</div>
		<div class="row">
  			<div class="col-4">Country</div>
  			<div class="col-2"><i class="fa fa-check-square" aria-hidden="true"></i></div>
  			<div class="col-6">$FormData.Country</div>
		</div>
		<div class="row">
  			<div class="col-4">Price Type</div>
  			<div class="col-8">$FormData.PriceType</div>
		</div>
		<div class="row">
  			<div class="col-4">Tender Type</div>
  			<div class="col-8">$FormData.TenderType</div>
		</div>
		<div class="row">
  			<div class="col-4">View on Site</div>
  			<div class="col-8">
  				<% if $FormData.ViewOnSite == 'checked' %>
  					Yes
  				<% else %>
  					No
  				<% end_if %>
  			</div>
		</div>
		<% if $FormData.ViewOnSitePhone %>
			<div class="row">
  				<div class="col-4">View on Site Phone</div>
  				<div class="col-8">$FormData.ViewOnSitePhone</div>
			</div>
		<% end_if %>
		<div class="row">
  			<div class="col-4">Tender Start Date</div>
  			<div class="col-8">$FormData.StartDateDis</div>
		</div>
		<div class="row">
  			<div class="col-4">Tender Close Date</div>
  			<div class="col-8">$FormData.EndDateDis</div>
		</div>
		<div class="row">
  			<div class="col-4">Assess Tender</div>
  			<div class="col-8">$FormData.AssessTenderControl</div>
		</div>
		<% if $AdditionalInfoSelect %><p><h3>Additional Info</h3></p><% end_if %>
		
		<% if $FormData.Estimate == 'checked' %>
			<div class="row">
  				<div class="col-4">Estimate(Visible to all)</div>
  				<div class="col-4">Yes</div>
  				<div class="col-4">$$FormData.ClientEstimate</div>
			</div>
		<% end_if %>
		<% if $TenderDoc('ScheduleOfPricesV2') %>
			<div class="row">
  				<div class="col-4">Schedule of Prices</div>
  				<div class="col-4">Yes</div>
  				<div class="col-4">
  					<ul>
  						<% loop $TenderDoc('ScheduleOfPricesV2') %><li>$Name</li><% end_loop %>
  					</ul>
  				</div>
			</div>
		<% end_if %>
		<% if $TenderDoc('SpecificationsV2') %>
			<div class="row">
  				<div class="col-4">Specifications</div>
  				<div class="col-4">Yes</div>
  				<div class="col-4">
  					<ul>
  						<% loop $TenderDoc('SpecificationsV2') %><li>$Name</li><% end_loop %>
  					</ul>
  				</div>
			</div>
		<% end_if %>
		
		<% if $TenderDoc('DrawingsV2') %>
			<div class="row">
  				<div class="col-4">Drawings/Sketch</div>
  				<div class="col-4">Yes</div>
  				<div class="col-4">
  					<ul>
  						<% loop $TenderDoc('DrawingsV2') %><li>$Name</li><% end_loop %>
  					</ul>
  				</div>
			</div>
		<% end_if %>
		
		<% if $TenderDoc('TermsOfPaymentV2') %>
			<div class="row">
  				<div class="col-4">Terms of Payment</div>
  				<div class="col-4">Yes</div>
  				<div class="col-4">
  					<ul>
  						<% loop $TenderDoc('TermsOfPaymentV2') %><li>$Name</li><% end_loop %>
  					</ul>
  				</div>
			</div>
		<% end_if %>
		
		<% if $TenderDoc('StandardConditionsV2') %>
			<div class="row">
  				<div class="col-4">Standard Conditions</div>
  				<div class="col-4">Yes</div>
  				<div class="col-4">
  					<ul>
  						<% loop $TenderDoc('StandardConditionsV2') %><li>$Name</li><% end_loop %>
  					</ul>
  				</div>
			</div>
		<% end_if %>
		
		<% if $TenderDoc('SpecialConditionsV2') %>
			<div class="row">
  				<div class="col-4">Special Conditions</div>
  				<div class="col-4">Yes</div>
  				<div class="col-4">
  					<ul>
  						<% loop $TenderDoc('SpecialConditionsV2') %><li>$Name</li><% end_loop %>
  					</ul>
  				</div>
			</div>
		<% end_if %>
		
		<% if $TenderDoc('ConditionsOfTenderingV2') %>
			<div class="row">
  				<div class="col-4">Conditions of Tendering</div>
  				<div class="col-4">Yes</div>
  				<div class="col-4">
  					<ul>
  						<% loop $TenderDoc('ConditionsOfTenderingV2') %><li>$Name</li><% end_loop %>
  					</ul>
  				</div>
			</div>
		<% end_if %>
		
		<% if $RequiredInfoSelect %><p><h4>Details to be submitted with Price</h4></p><% end_if %>
		
		<% if $FormData.HealthSafetyPolicyRequired == 'checked' %>
			<div class="row">
  				<div class="col-4">Health & Safety Policy</div>
	  			<div class="col-8">Yes</div>
			</div>
		<% end_if %>
		<% if $FormData.TenderDocRequired == 'checked' %>
			<div class="row">
  				<div class="col-4">Tender Documents</div>
	  			<div class="col-8">Yes</div>
			</div>
		<% end_if %>
		<% if $FormData.CoverLetterRequired == 'checked' %>
			<div class="row">
  				<div class="col-4">Cover Letter</div>
	  			<div class="col-8">Yes</div>
			</div>
		<% end_if %>
		<% if $FormData.DrawingsRequired == 'checked' %>
			<div class="row">
  				<div class="col-4">Drawings/Sketch</div>
	  			<div class="col-8">Yes</div>
			</div>
		<% end_if %>
		<% if $FormData.OthersRequired == 'checked' %>
			<div class="row">
  				<div class="col-4">$FormData.OthersText</div>
	  			<div class="col-8">Yes</div>
			</div>
		<% end_if %>
		<div class="row">
  			<div class="col-12">&nbsp;</div>
		</div>
		
		<div class="row">
  			<div class="col-4"><h3>Price</h3></div>
	  		<div class="col-8"><h3>$<% if $FormData.ClientAdvertiseCost %>$FormData.ClientAdvertiseCost<% else %>0<% end_if %></h3></div>
		</div>
		<div class="row">
  			<div class="col-12">&nbsp;</div>
		</div>
		<div class="row">
  			<div class="col-12">&nbsp;</div>
		</div>
		<div class="row">
  			<div class="col-4"><a href="/get-prices/createTender"><button type="button" class="btn btn-primary">Create Tender</button></a></div>
  			<div class="col-4"><a href="/get-prices"><button type="button" class="btn btn-primary">Change</button></a></div>
  			<div class="col-4">&nbsp;</div>
		</div>
    </div>
</section>
    
<section>
    <div class="container">
   		$CommentsForm
     </div>
</section>