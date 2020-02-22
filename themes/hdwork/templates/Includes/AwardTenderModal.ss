<!-- Award Tender Modal -->
<div class="modal fade" id="awardTender_{$Tender.ID}_{$ID}" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">&nbsp;</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
  			<div class="row">
				<div class="col-sm-12">
    				<p>Please confirm you are awarding this job to <b>$Contractor.Name</b> for a value of <b>${$PriceSubmitted}</b>(inc GST).</p>
   				</div>
    		</div>
      </div>  
      <div class="modal-footer">
      		<div class="row">
    			<div class="col-sm-8">
    				<a href="/get-prices/award/{$ID}" class="btn btn-primary btn-sm" role="button">
    					Confirm and Award Contract
    					&nbsp;&nbsp;&nbsp;&nbsp;<i class="fa fa-question-circle" data-toggle="tooltip" data-html="true" data-animation="false" data-placement="top" title="$HelpTip(NavigateTendersAwardContract)"></i>
    				</a>
    			</div>
   				<div class="col-sm-4"><button type="button" class="btn btn-primary btn-sm" data-dismiss="modal">Cancel</button></div>
    		</div>
      </div>
    </div>
  </div>
</div>