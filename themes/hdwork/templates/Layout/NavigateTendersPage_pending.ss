<section>
   <div id="NavTenders" class="container">
   		<h2>My Tenders - Pending</h2>
   		$Message
		<% if $PendingTenders %>
			<% loop $PendingTenders %>
						<div class="row">
							<div class="col-md-2">
								<% if $Images %>
									<% loop $Images %>
				        				<% if $CoverPhoto %>
				        					<a href="/tender/view/$TenderID"><img src="$Image.CroppedImage(150,150).URL" class="img-responsive"></a>
		        						<% end_if %>
		        					<% end_loop %>
								<% end_if %>
							</div>
							<div class="col-md-10">
								<div class="row">
									<div class="col-md-4"><p><a href="/tender/view/$ID">Ref #$ID</a></p></div>
									<div class="col-md-2">&nbsp;</div>
									<div class="col-md-2"><a class="btn btn-primary btn-sm" href="/get-prices/payPendingTender/$ID" role="button">Pay</a></div>
									<div class="col-md-4">&nbsp;</div>
								</div>
							
								<div class="row">
									<div class="col-md-4"><p><a href="/tender/view/$ID">$Title</a></p></div>
									<div class="col-md-8">&nbsp;</div>
								</div>

								<div class="row">
									<div class="col-md-4">&nbsp;</div>
									<div class="col-md-8">&nbsp;</div>
								</div>
						
								<div class="row">
									<div class="col-md-4">&nbsp;</div>
									<div class="col-md-8">&nbsp;</div>
								</div>
						
								<div class="row">
									<div class="col-md-4">&nbsp;</div>
									<div class="col-md-2">&nbsp;</div>
									<div class="col-md-2">&nbsp;</div>
									<div class="col-md-4">&nbsp;</div>
								</div>
							</div>
						</div>
						<% include PaymentsModal2 %>
			<% end_loop %>
		<% else %>
			<p>No records for pending tenders available</p>
		<% end_if %>
    </div>
</section>


    
<section>
    <div class="container">
   		$CommentsForm
     </div>
</section>