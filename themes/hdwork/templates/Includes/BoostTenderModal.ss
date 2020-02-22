<!-- Award Tender Modal -->
<div class="modal fade" id="boostTender" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">BOOST</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
  			<form method="post" id="CreateTenderForm" action="/get-prices/boostTender">
    			
    			<div class="form-group row">
				    <div class="col-sm-12">
            			<p><strong>Boost your tenders exposure</strong></p>
            			<p>We will contact up to 10 relevant Contractors to advise them of your tender to ensure that  you receive the best proposals for your tender.</p>
        			</div>
					<input type="hidden" name="ID" value="$Tender.ID">
    			</div>
    			
    			<div class="form-group row">
      				<div class="col-sm-12"><button type="submit" class="btn btn-primary">Confirm</button></div>
    			</div>
    			<div class="form-group row">
      				<div class="col-sm-12"><p>(your account will be debited ${$SiteConfig.BoostTenderCost})</p></div>
    			</div>
    			
		    </form>
      </div>  
      <div class="modal-footer">
      </div>
    </div>
  </div>
</div>