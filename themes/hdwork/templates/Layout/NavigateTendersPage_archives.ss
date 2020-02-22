<section>
   <div id="NavTenders" class="container">
   		<h2>My Tenders - Archives</h2>
   		$Message
		<% if $ArchivedTenders %>
			<% loop $ArchivedTenders %>
			  	<% if $SubmissionArchived %>
				  	<% loop $SubmissionArchived %>
						<div class="row">
							<div class="col-md-2">
								<% if $Tender.Images %>
									<% loop $Tender.Images %>
				        				<% if $CoverPhoto %>
				        					<a href="/submission/view/$TenderID?submitId=$Up.Up.ID"><img src="$Image.CroppedImage(150,150).URL" class="img-responsive"></a>
		        						<% end_if %>
		        					<% end_loop %>
								<% end_if %>
							</div>
							<div class="col-md-10">
								<div class="row">
									<div class="col-md-4"><p><a href="/submission/view/$TenderID?submitId=$ID">Ref #$Tender.ID</a></p></div>
									<div class="col-md-2">&nbsp;</div>
									<div class="col-md-2"><button type="button" class="btn btn-primary btn-sm"  data-toggle="modal" data-target="#answersForm_{$Tender.ID}_{$ID}">Comms</button></div>
									<div class="col-md-4">&nbsp;</div>
								</div>
							
								<div class="row">
									<div class="col-md-4"><p><a href="/submission/view/$TenderID?submitId=$ID">$Tender.Title</a></p></div>
									<div class="col-md-8">&nbsp;</div>
								</div>

								<div class="row">
									<div class="col-md-4"><p>Awarded for ${$PriceSubmitted}</p></div>
									<div class="col-md-8">&nbsp;</div>
								</div>
						
								<div class="row">
									<div class="col-md-4">
										<p>Awarded to $Contractor.Name</p>
									</div>
									<div class="col-md-4">
										<% loop $Contractor %>
											<i class="fa fa-star <% if $Rating >= 1 %>fa-star-gold<% else %>fa-star-gray<% end_if %>" id="star1" data-no=1 aria-hidden="true"></i>
    	    								<i class="fa fa-star <% if $Rating >= 2 %>fa-star-gold<% else %>fa-star-gray<% end_if %>" id="star2" data-no=2 aria-hidden="true"></i>
        									<i class="fa fa-star <% if $Rating >= 3 %>fa-star-gold<% else %>fa-star-gray<% end_if %>" id="star3" data-no=3 aria-hidden="true"></i>
        									<i class="fa fa-star <% if $Rating >= 4 %>fa-star-gold<% else %>fa-star-gray<% end_if %>" id="star4" data-no=4 aria-hidden="true"></i>
        									<i class="fa fa-star <% if $Rating >= 5 %>fa-star-gold<% else %>fa-star-gray<% end_if %>" id="star5" data-no=5 aria-hidden="true"></i>
        								<% end_loop %>
        								($Contractor.RatingCount Rating(s))
									</div>
									<div class="col-md-4">
										<% if $ConRating %>
											&nbsp;
										<% else %>
											<button type="button" class="btn btn-primary btn-sm"  data-toggle="modal" data-target="#rateUserForm_{$TenderID}_{$ID}">Rate</button>
										<% end_if %>
									</div>
								</div>
						
								<div class="row">
									<div class="col-md-4">&nbsp;</div>
									<div class="col-md-2">&nbsp;</div>
									<div class="col-md-2">&nbsp;</div>
									<div class="col-md-4">&nbsp;</div>
								</div>
							</div>
						</div>
				
						<% include AnswersModal %>
						
						<% include RateUserModal %>
				
					<% end_loop %>
				<% else %>
				
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
									<div class="col-md-2"><button type="button" class="btn btn-primary btn-sm"  data-toggle="modal" data-target="#answersForm_{$ID}">Comms</button></div>
									<div class="col-md-4">&nbsp;</div>
								</div>
							
								<div class="row">
									<div class="col-md-4"><p><a href="/tender/view/$TenderID">$Tender.Title</a></p></div>
									<div class="col-md-8">&nbsp;</div>
								</div>

								<div class="row">
									<div class="col-md-4">&nbsp;</div>
									<div class="col-md-8">&nbsp;</div>
								</div>
						
								<div class="row">
									<div class="col-md-4">&nbsp;</div>
									<div class="col-md-4">&nbsp;</div>
									<div class="col-md-4">
										&nbsp;
									</div>
								</div>
						
								<div class="row">
									<div class="col-md-4">&nbsp;</div>
									<div class="col-md-2">&nbsp;</div>
									<div class="col-md-2">&nbsp;</div>
									<div class="col-md-4">&nbsp;</div>
								</div>
							</div>
						</div>
				
						<% include AnswersModal3 Top1=$Top %>
						
				<% end_if %>
			<% end_loop %>
		<% else %>
			<p>No records for archived tenders available</p>
		<% end_if %>
    </div>
</section>
    
<section>
    <div class="container">
   		$CommentsForm
     </div>
</section>