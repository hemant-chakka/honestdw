<!-- Modal -->
<div class="modal fade" id="paymentModal_$ID" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Payment Options</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        
        <div class="row">
        	<div class="col-md-12">
        		<h6>How would you like to pay?</h6>
        	</div>
        </div>
        <div class="row">
        	<div class="col-md-12">
        		<img src="themes/hdwork/images/visa-master.png" width=200px >
        	</div>
        </div>
        
  		
  		<div class="row">
  		<div class="col-md-12">
  		<% if $SiteConfig.PaypalSandboxMode %>
  			<form action="https://www.sandbox.paypal.com/cgi-bin/webscr" method="post">
  		<% else %>
  			<form action="https://www.paypal.com/cgi-bin/webscr" method="post">
  		<% end_if %>
			<input type="hidden" name="cmd" value="_cart">
			<input type="hidden" name="upload" value="1">
			<input type="hidden" name="business" value="$SiteConfig.PaypalEmail">
			<input type="hidden" name="item_name_1" value="$Tender.Title">
			<input type="hidden" name="amount_1" value="$ContractorTenderCost">
			<input type="hidden" name="currency_code" value="NZD">
			<input type="hidden" name="no_shipping" value="1">
			<input type="hidden" name="rm" value="2">
			<input type="hidden" name="cancel_return" value="{$absoluteBaseURL}paypal/cancelled?submitId={$ID}">
			<input type="hidden" name="return" value="{$absoluteBaseURL}paypal/success?submitId={$ID}">
			<input type="hidden" name="notify_url" value="{$absoluteBaseURL}paypal/notify?submitId={$ID}">
			<button type="submit" class="btn btn-success btn-lg btn-block">Credit or debit card</button>
		</form>
		</div>
		</div></br></br>  
		
		<div class="row">
        	<div class="col-md-12">
        		<img src="themes/hdwork/images/poli.png" width=200px >
        	</div>
        </div>
		
		<div class="row"><div class="col-md-12"><a href="/poli-pay/pay/$ID?payer=contractor"><button type="button" class="btn btn-success btn-lg btn-block">Internet banking(POLi)</button></a></div></div>
		
      </div>  
      <div class="modal-footer">
      </div>
    </div>
  </div>
</div>