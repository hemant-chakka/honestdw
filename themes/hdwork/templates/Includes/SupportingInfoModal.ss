<!-- Supporting Info Modal -->
<div class="modal fade" id="supportingInfo" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Supporting Info</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        	<% if $Tender.AdditionalInfo %>
        		<% if $Tender.ScheduleOfPricesV2 %>
 					<div class="row">
 						<div class="col-md-6">Schedule of Prices</div>
 						<div class="col-md-6">&nbsp;</div>
  					</div>
  					<% loop $Tender.ScheduleOfPricesV2 %>
						<div class="row">
	 						<div class="col-md-6">&nbsp;</div>
 							<div class="col-md-6"><a href="$URL" target="_blank" class="btn btn-primary btn-sm" role="button">Download</a></div>
  						</div>
					<% end_loop %>
        		<% end_if %>
        		
        		<% if $Tender.SpecificationsV2 %>
 					<div class="row">
 						<div class="col-md-6">Specifications</div>
 						<div class="col-md-6">&nbsp;</div>
  					</div>
  					<% loop $Tender.SpecificationsV2 %>
						<div class="row">
	 						<div class="col-md-6">&nbsp;</div>
 							<div class="col-md-6"><a href="$URL" target="_blank" class="btn btn-primary btn-sm" role="button">Download</a></div>
  						</div>
					<% end_loop %>
        		<% end_if %>


        		<% if $Tender.DrawingsV2 %>
 					<div class="row">
 						<div class="col-md-6">Drawings</div>
 						<div class="col-md-6">&nbsp;</div>
  					</div>
  					<% loop $Tender.DrawingsV2 %>
						<div class="row">
	 						<div class="col-md-6">&nbsp;</div>
 							<div class="col-md-6"><a href="$URL" target="_blank" class="btn btn-primary btn-sm" role="button">Download</a></div>
  						</div>
					<% end_loop %>
        		<% end_if %>


        		<% if $Tender.TermsOfPaymentV2 %>
 					<div class="row">
 						<div class="col-md-6">Terms of Payment</div>
 						<div class="col-md-6">&nbsp;</div>
  					</div>
  					<% loop $Tender.TermsOfPaymentV2 %>
						<div class="row">
	 						<div class="col-md-6">&nbsp;</div>
 							<div class="col-md-6"><a href="$URL" target="_blank" class="btn btn-primary btn-sm" role="button">Download</a></div>
  						</div>
					<% end_loop %>
        		<% end_if %>


        		<% if $Tender.StandardConditionsV2 %>
 					<div class="row">
 						<div class="col-md-6">Standard Conditions</div>
 						<div class="col-md-6">&nbsp;</div>
  					</div>
  					<% loop $Tender.StandardConditionsV2 %>
						<div class="row">
	 						<div class="col-md-6">&nbsp;</div>
 							<div class="col-md-6"><a href="$URL" target="_blank" class="btn btn-primary btn-sm" role="button">Download</a></div>
  						</div>
					<% end_loop %>
        		<% end_if %>


        		<% if $Tender.SpecialConditionsV2 %>
 					<div class="row">
 						<div class="col-md-6">Special Conditions</div>
 						<div class="col-md-6">&nbsp;</div>
  					</div>
  					<% loop $Tender.SpecialConditionsV2 %>
						<div class="row">
	 						<div class="col-md-6">&nbsp;</div>
 							<div class="col-md-6"><a href="$URL" target="_blank" class="btn btn-primary btn-sm" role="button">Download</a></div>
  						</div>
					<% end_loop %>
        		<% end_if %>

        		<% if $Tender.ConditionsOfTenderingV2 %>
 					<div class="row">
 						<div class="col-md-6">Conditions of Tendering</div>
 						<div class="col-md-6">&nbsp;</div>
  					</div>
  					<% loop $Tender.ConditionsOfTenderingV2 %>
						<div class="row">
	 						<div class="col-md-6">&nbsp;</div>
 							<div class="col-md-6"><a href="$URL" target="_blank" class="btn btn-primary btn-sm" role="button">Download</a></div>
  						</div>
					<% end_loop %>
        		<% end_if %>

			<% else %>
				<p>No supporting info!</p>
			<% end_if %>
      </div>  
      <div class="modal-footer">
      </div>
    </div>
  </div>
</div>