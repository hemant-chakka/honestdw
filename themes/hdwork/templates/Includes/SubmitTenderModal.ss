<!-- Submit Tender Modal -->
<div class="modal fade" id="submitTenderForm" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">&nbsp;</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        	
				<div class="form-group row">
					<div class="col-sm-5">
							<input type="text" class="form-control" id="inputPriceSubmitted" name="PriceSubmitted" placeholder="${$ab}Price(inc GST)" required>
							<input type="hidden" id="inputTenderID" name="TenderID" value="{$Tender.ID}" />
    						<input type="hidden" id="inputSubmissionID" name="SubmissionID" value="{$Submission.ID}" />
					</div>
					<div class="col-sm-1">
						<i class="fa fa-question-circle" data-toggle="tooltip" data-html="true" data-animation="false" data-placement="top" title="$HelpTip(SubmitTenderPrice)"></i>
					</div>
					<div class="col-sm-6">
       						<button type="button" id="DetailedRequiredBtn" class="btn <% if $Tender.RequiredInfo %>btn-danger<% else %>btn-success<% end_if %>" data-dismiss="modal" data-toggle="modal" data-target="#detailsRequired">Details Required</button>
					</div>
				</div>
				<div class="form-group row">
					<div class="col-sm-12">
						<p>Confirm that you are submitting a proposal to $Tender.Client.Name for a value of <b>$<span id="TenderPriceHolder">xx</span></b>(inc GST)</p>			
					</div>
				</div>
				<div class="form-group row">
					<div class="col-sm-12">
						<center>
							<% if $Tender.Expired %>
								<button type="button" class="btn btn-primary" data-dismiss="modal" disabled>I Agree</button>
							<% else %>
								<button type="submit" id="IAgreeBtn" class="btn btn-primary" <% if $Tender.RequiredInfo %>disabled<% end_if %>>
									I Agree
									&nbsp;&nbsp;&nbsp;&nbsp;<i class="fa fa-question-circle" data-toggle="tooltip" data-html="true" data-animation="false" data-placement="top" title="$HelpTip(SubmitTenderIAgree)"></i>
								</button>
							<% end_if %>
							<h4>Price to submit is $$Tender.SubmitPrice</h4>
							
						</center>
					</div>
				</div>
		    
      </div>  
      <div class="modal-footer">
      </div>
    </div>
  </div>
</div>