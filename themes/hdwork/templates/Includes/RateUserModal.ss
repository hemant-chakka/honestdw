<!-- Rate User Modal -->
<div class="modal fade" id="rateUserForm_{$TenderID}_{$ID}" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Rate User</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        	<form method="post" id="RateUserForm" action="/navigate-tenders/rateContractor">
				<div class="form-group row">
      				<div class="col-sm-12">
        				<i class="fa fa-star rate-star fa-star-gray star1" data-no=1 data-id="_{$TenderID}_{$ID}" aria-hidden="true"></i>
        				<i class="fa fa-star rate-star fa-star-gray star2" data-no=2 data-id="_{$TenderID}_{$ID}" aria-hidden="true"></i>
        				<i class="fa fa-star rate-star fa-star-gray star3" data-no=3 data-id="_{$TenderID}_{$ID}" aria-hidden="true"></i>
        				<i class="fa fa-star rate-star fa-star-gray star4" data-no=4 data-id="_{$TenderID}_{$ID}" aria-hidden="true"></i>
        				<i class="fa fa-star rate-star fa-star-gray star5" data-no=5 data-id="_{$TenderID}_{$ID}" aria-hidden="true"></i>
      				</div>
    			</div>
    			<div class="form-group row">
      				<label for="inputComment" class="col-sm-5 col-form-label">Comment</label>
      				<div class="col-sm-7">
        				<textarea class="form-control" rows="5" class="form-control" name="Comment" id="inputComment" placeholder="Comment"></textarea>
        				<input type="hidden" name="Rating">
        				<input type="hidden" name="TenderID" value="$TenderID">
        				<input type="hidden" name="SubmissionID" value="$ID">
        				<input type="hidden" name="ContractorID" value="$ContractorID">
      				</div>
    			</div>
    			<div class="form-group row">
	    			<div class="col-sm-5">&nbsp;</div>
    				<div class="col-sm-7">
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