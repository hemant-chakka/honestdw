<!-- Award Tender Modal -->
<div class="modal fade" id="extendTender_{$ID}" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">&nbsp;</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
  			<form method="post" id="CreateTenderForm" action="/get-prices/extendTender">
    			
    			<div class="form-group row">
      				<label class="col-sm-4 col-form-label">Due to close on:</label>
      				<div class="col-sm-8">$EndDate.Format(dS M Y h:i a)</div>
    			</div>
    			
    			<div class="form-group row">
        			<label for="inputEndDate" class="col-md-4 control-label">Extend To</label>
        			<div class='input-group date form_datetime_ed col-sm-8 EndDate'>
             			<input type='text' class="form-control" size="16" name="EndDateDis" value="$FormData.EndDateDis" required />
             			<span class="input-group-addon">
                 			<span class="glyphicon glyphicon-th"><i class="fa fa-calendar" aria-hidden="true"></i></span>
             			</span>
        			</div>
        			<input type="hidden" name="ID" value="$ID">
    			</div>
    			
    			<div class="form-group row">
      				<div class="col-sm-12">
      					<button type="submit" class="btn btn-primary">
      						Confirm
      						&nbsp;&nbsp;&nbsp;&nbsp;<i class="fa fa-question-circle" data-toggle="tooltip" data-html="true" data-animation="false" data-placement="top" title="$HelpTip(NavigateTendersExtendTender)"></i>
      					</button>
      				</div>
    			</div>
    			<div class="form-group row">
      				<div class="col-sm-12"><p>Note: All tenderers will notified of the new tender closure date</p></div>
    			</div>
    			
		    </form>
      </div>  
      <div class="modal-footer">
      </div>
    </div>
  </div>
</div>