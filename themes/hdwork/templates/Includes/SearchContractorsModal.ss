<!-- Search Contractors Modal -->
<div class="modal fade" id="searchContractors_$ID" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">&nbsp;</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        	<form method="post" id="SearchUsersForm" action="/navigate-tenders/searchUsers">
				<div class="form-group row">
      				<label for="inputKeyword" class="col-sm-5 col-form-label">Search by keyword</label>
      				<div class="col-sm-7">
        				<input type="text" class="form-control" id="inputKeyword" name="Keyword" placeholder="Keyword">
      				</div>
    			</div>
    			<div class="form-group row">
      				<label for="inputRegion" class="col-sm-5 col-form-label">Filter by Region</label>
      				<div class="col-sm-7">
        				<input type="text" class="form-control" id="inputRegion" name="Region" placeholder="Region">
        				<input type="hidden" name="TenderID" value="$ID">
      				</div>
    			</div>
    			<div class="form-group row">
	    			<div class="col-sm-5">&nbsp;</div>
    				<div class="col-sm-7">
        				<button type="submit" class="btn btn-primary">Search</button> 
      				</div>
    			</div>
    			
    		</form>
    		<form method="post" id="NotifyUserClosedTenderForm" action="/navigate-tenders/notifyGuestClosedTender">
    			<div class="form-group row">
      				<label for="inputEmail" class="col-sm-5 col-form-label">Enter User Email</label>
      				<div class="col-sm-7">
      					<input type="email" class="form-control" id="inputEmail" name="Email" placeholder="Email">
      				</div>
    			</div>
    			<div class="form-group row">
      				<label for="inputNamePhone" class="col-sm-5 col-form-label">Enter Name & Phone Number</label>
      				<div class="col-sm-7">
        				<input type="text" class="form-control" id="inputNamePhone" name="NamePhone" placeholder="Name & Phone Number">
        				<input type="hidden" name="TenderID" value="$ID">
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