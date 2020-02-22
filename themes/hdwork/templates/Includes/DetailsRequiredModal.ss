<!-- Details Required Modal -->
<div class="modal fade" id="detailsRequired" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">&nbsp;</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        	<div class="form-group row">
				<div class="col-sm-6">
						<label for="inputClarifications" class="col-form-label">Clarifications and Notes</label>
				</div>
				<div class="col-sm-6">
					<textarea class="form-control" rows="5" class="form-control" name="Clarifications" id="inputClarifications" placeholder="Clarifications and Notes" ></textarea>
				</div>
			</div>
			
			<div class="form-group row">
				<div class="col-sm-6">
					<label for="inputQuote" class="col-form-label">Upload Quote</label>
				</div>
				<div class="col-sm-6">
   					<div id="QuoteUpload">Upload</div>
				</div>
			</div>
			
			<% if $Submission.QuoteV2  %>
      			<% loop $Submission.QuoteV2 %>
			        <div class="form-group row">
            			<div class="col-sm-6">&nbsp;</div>
            			<div class="col-sm-3">$Name</div>
            			<div class="col-sm-3"><a href="/get-prices/deleteTenderSubmitDoc/$ID?submitId=$Top.$Submission.ID&doc=CoverLetterV2"><i class="fa fa-trash-o" aria-hidden="true"></i></a></div>
        			</div>
      			<% end_loop %>
    		<% end_if %>
			
				
			<% if $Tender.CoverLetterRequired %>
				<div class="form-group row">
					<div class="col-sm-6">
						<label for="inputCoverLetter" class="col-form-label">Cover Letter</label>
					</div>
					<div class="col-sm-6">
   						<div id="CoverLetterUpload">Upload</div>
					</div>
				</div>
			<% end_if %>
			
			
			<% if $Submission.CoverLetterV2  %>
      			<% loop $Submission.CoverLetterV2 %>
			        <div class="form-group row">
            			<div class="col-sm-6">&nbsp;</div>
            			<div class="col-sm-3">$Name</div>
            			<div class="col-sm-3"><a href="/get-prices/deleteTenderSubmitDoc/$ID?submitId=$Top.$Submission.ID&doc=CoverLetterV2"><i class="fa fa-trash-o" aria-hidden="true"></i></a></div>
        			</div>
      			<% end_loop %>
    		<% end_if %>
			
			
			
			
			
				
			<% if $Tender.TenderDocRequired %>
				<div class="form-group row">
					<div class="col-sm-6">
						<label for="inputTenderDocument" class="col-form-label">Tender Document</label>
					</div>
					<div class="col-sm-6">
   						<div id="TenderDocumentUpload">Upload</div>
					</div>
				</div>
			<% end_if %>
			
			<% if $Submission.TenderDocumentV2  %>
      			<% loop $Submission.TenderDocumentV2 %>
			        <div class="form-group row">
            			<div class="col-sm-6">&nbsp;</div>
            			<div class="col-sm-3">$Name</div>
            			<div class="col-sm-3"><a href="/get-prices/deleteTenderSubmitDoc/$ID?submitId=$Top.$Submission.ID&doc=CoverLetterV2"><i class="fa fa-trash-o" aria-hidden="true"></i></a></div>
        			</div>
      			<% end_loop %>
    		<% end_if %>
				
			<% if $Tender.HealthSafetyPolicyRequired %>
				<div class="form-group row">
					<div class="col-sm-6">
						<label for="inputHealthSafetyPolicy" class="col-form-label">Health & Safety Policy</label>
					</div>
					<div class="col-sm-6">
   						<div id="HealthSafetyPolicyUpload">Upload</div>
					</div>
				</div>
			<% end_if %>
			
			<% if $Submission.HealthSafetyPolicyV2  %>
      			<% loop $Submission.HealthSafetyPolicyV2 %>
			        <div class="form-group row">
            			<div class="col-sm-6">&nbsp;</div>
            			<div class="col-sm-3">$Name</div>
            			<div class="col-sm-3"><a href="/get-prices/deleteTenderSubmitDoc/$ID?submitId=$Top.$Submission.ID&doc=CoverLetterV2"><i class="fa fa-trash-o" aria-hidden="true"></i></a></div>
        			</div>
      			<% end_loop %>
    		<% end_if %>
				
			<% if $Tender.DrawingsRequired %>
				<div class="form-group row">
					<div class="col-sm-6">
						<label for="inputDrawings" class="col-form-label">Drawings</label>
					</div>
					<div class="col-sm-6">
   						<div id="DrawingsUpload2">Upload</div>
					</div>
				</div>
			<% end_if %>
			
			<% if $Submission.DrawingsV2  %>
      			<% loop $Submission.DrawingsV2 %>
			        <div class="form-group row">
            			<div class="col-sm-6">&nbsp;</div>
            			<div class="col-sm-3">$Name</div>
            			<div class="col-sm-3"><a href="/get-prices/deleteTenderSubmitDoc/$ID?submitId=$Top.$Submission.ID&doc=CoverLetterV2"><i class="fa fa-trash-o" aria-hidden="true"></i></a></div>
        			</div>
      			<% end_loop %>
    		<% end_if %>
				
			<% if $Tender.OthersRequired %>
				<div class="form-group row">
					<div class="col-sm-6">
						<label for="inputOtherDocument" class="col-form-label">$Tender.OthersText</label>
					</div>
					<div class="col-sm-6">
    					<div id="OtherDocumentUpload">Upload</div>
					</div>
				</div>
			<% end_if %>
			
			<% if $Submission.OtherDocumentV2  %>
      			<% loop $Submission.OtherDocumentV2 %>
			        <div class="form-group row">
            			<div class="col-sm-6">&nbsp;</div>
            			<div class="col-sm-3">$Name</div>
            			<div class="col-sm-3"><a href="/get-prices/deleteTenderSubmitDoc/$ID?submitId=$Top.$Submission.ID&doc=CoverLetterV2"><i class="fa fa-trash-o" aria-hidden="true"></i></a></div>
        			</div>
      			<% end_loop %>
    		<% end_if %>

			<% if $Tender.ScheduleOfPricesV2 %>
				<div class="form-group row">
					<div class="col-sm-6">
						<label for="inputScheduleOfPrices" class="col-form-label">Schedule of Prices</label>
					</div>
					<div class="col-sm-4"><div id="ScheduleOfPricesUpload2">Upload</div></div>
					<div class="col-sm-2">
						<i class="fa fa-question-circle pull-right" data-toggle="tooltip" data-html="true" data-animation="false" data-placement="left" title="$HelpTip(SubmitTenderSOP)"></i>
					</div>
				</div>
			<% end_if %>
			
			<% if $Submission.ScheduleOfPricesV2  %>
      			<% loop $Submission.ScheduleOfPricesV2 %>
			        <div class="form-group row">
            			<div class="col-sm-6">&nbsp;</div>
            			<div class="col-sm-3">$Name</div>
            			<div class="col-sm-3"><a href="/get-prices/deleteTenderSubmitDoc/$ID?submitId=$Top.$Submission.ID&doc=CoverLetterV2"><i class="fa fa-trash-o" aria-hidden="true"></i></a></div>
        			</div>
      			<% end_loop %>
    		<% end_if %>
				
			<% if $Tender.SpecificationsV2 %>
				<div class="form-group row">
					<div class="col-sm-6">
						<label for="inputSpecificationsRead" class="col-form-label">Specifications</label>
					</div>
					<div class="col-sm-6">
       					<input type="checkbox" id="inputSpecificationsRead" class="doc-read-cb" name="SpecificationsRead" > Read & understood
					</div>
				</div>
			<% end_if %>
				
			<% if $Tender.DrawingsV2 %>
				<div class="form-group row">
					<div class="col-sm-6">
						<label for="inputDrawingsRead" class="col-form-label">Drawings</label>
					</div>
					<div class="col-sm-6">
   						<input type="checkbox" id="inputDrawingsRead" class="doc-read-cb" name="DrawingsRead" > Read & understood
					</div>
				</div>
			<% end_if %>
				
			<% if $Tender.TermsOfPaymentV2 %>
				<div class="form-group row">
					<div class="col-sm-6">
						<label for="inputTermsOfPaymentRead" class="col-form-label">Terms of Payment</label>
					</div>
					<div class="col-sm-6">
   						<input type="checkbox" id="inputTermsOfPaymentRead" class="doc-read-cb" name="TermsOfPaymentRead" > Read & understood
					</div>
				</div>
			<% end_if %>
				
			<% if $Tender.StandardConditionsV2 %>
				<div class="form-group row">
					<div class="col-sm-6">
						<label for="inputStandardConditionsRead" class="col-form-label">Standard Conditions</label>
					</div>
					<div class="col-sm-6">
   						<input type="checkbox" id="inputStandardConditionsRead" class="doc-read-cb" name="StandardConditionsRead" > Read & understood
					</div>
				</div>
			<% end_if %>
			
			<% if $Tender.SpecialConditionsV2 %>
				<div class="form-group row">
					<div class="col-sm-6">
						<label for="inputSpecialConditionsRead" class="col-form-label">Special Conditions</label>
					</div>
					<div class="col-sm-6">
   						<input type="checkbox" id="inputSpecialConditionsRead" class="doc-read-cb" name="SpecialConditionsRead" > Read & understood
					</div>
				</div>
			<% end_if %>
				
			<% if $Tender.ConditionsOfTenderingV2 %>
				<div class="form-group row">
					<div class="col-sm-6">
						<label for="inputConditionsOfTenderingRead" class="col-form-label">Conditions of Tendering</label>
					</div>
					<div class="col-sm-6">
    					<input type="checkbox" id="inputConditionsOfTenderingRead" class="doc-read-cb" name="ConditionsOfTenderingRead" > Read & understood
					</div>
				</div>
			<% end_if %>
				
			<div class="form-group row">
				<div class="col-sm-6">
					&nbsp;
				</div>
				<div class="col-sm-6">
    				<button type="button" class="btn btn-primary" data-dismiss="modal" data-toggle="modal" data-target="#submitTenderForm">Ok</button>
				</div>
			</div>
      </div>
      <div class="modal-footer">
      </div>
    </div>
  </div>
</div>