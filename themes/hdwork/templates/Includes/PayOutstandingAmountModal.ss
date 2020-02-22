<!-- Pay outstanding amount Modal -->
<div class="modal fade" id="PayOutAmountModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Pay</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      		<form method="post" id="PayOutAmountForm" action="/get-prices/payOutstandingAmount">
				<div class="form-group row">
      				<label for=" " class="col-sm-2 col-form-label">&nbsp;</label>
      				<div class="col-sm-10">
        				<% if $CurrentMember.creditAvailed > 0 %>
        				<div class="form-check">          
				      		<input type="radio" name="SelfPayAmt" value="$CurrentMember.creditAvailed">  
          					<label class="">Outstanding Amount - ${$CurrentMember.creditAvailed}</label>
      					</div>
      					<% end_if %> 
      					<div class="form-check">    		
    						<input type="radio" name="SelfPayAmt" value="10">  
          					<label class="">$10</label>
      					</div>
      					<div class="form-check">    		
    						<input type="radio" name="SelfPayAmt" value="20">  
          					<label class="">$20</label>
      					</div>
      					<div class="form-check">    		
    						<input type="radio" name="SelfPayAmt" value="40">  
          					<label class="">$40</label>
      					</div>
      					<div class="form-check">    		
    						<input type="radio" name="SelfPayAmt" id="inputSelfPayAmt" >
    						<label class="" style="width:90%;"><input type="text" id="inputCustomSelfPayAmt" class="form-control field" name="CustomSelfPay"  placeholder="Enter other amount, max $100"></label>  
      					</div>
      				</div>
    			</div>
    			<div class="form-group row">
	    			<div class="col-sm-2">&nbsp;</div>
    				<div class="col-sm-10">
        				<button type="button" id="PayOutAmountFormSubmit" class="btn btn-primary">Submit</button> 
      				</div>
    			</div>
		    </form>
      </div>  
      <div class="modal-footer">
      </div>
    </div>
  </div>
</div>