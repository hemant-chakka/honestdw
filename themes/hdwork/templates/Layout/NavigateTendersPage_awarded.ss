<section>
   <div id="NavTenders" class="container">
   		<h2>My Tenders - Awarded</h2>
   		$Message
		<% if $AwardedTenders %>
			<% loop $AwardedTenders %>
			  	<% if $SubmissionAwarded %>
				  	<% loop $SubmissionAwarded %>
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
									<div class="col-md-4"><p><a href="/submission/view/$TenderID?submitId=$ID">Ref #$TenderID</a></p></div>
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
									<div class="col-md-4"><p>Awarded to $Contractor.Name</p></div>
									<div class="col-md-8">
										<% loop $Contractor %>
											<i class="fa fa-star <% if $Rating >= 1 %>fa-star-gold<% else %>fa-star-gray<% end_if %>" id="star1" data-no=1 aria-hidden="true"></i>
    	    								<i class="fa fa-star <% if $Rating >= 2 %>fa-star-gold<% else %>fa-star-gray<% end_if %>" id="star2" data-no=2 aria-hidden="true"></i>
        									<i class="fa fa-star <% if $Rating >= 3 %>fa-star-gold<% else %>fa-star-gray<% end_if %>" id="star3" data-no=3 aria-hidden="true"></i>
        									<i class="fa fa-star <% if $Rating >= 4 %>fa-star-gold<% else %>fa-star-gray<% end_if %>" id="star4" data-no=4 aria-hidden="true"></i>
        									<i class="fa fa-star <% if $Rating >= 5 %>fa-star-gold<% else %>fa-star-gray<% end_if %>" id="star5" data-no=5 aria-hidden="true"></i>
        								<% end_loop %>
        								($Contractor.RatingCount Rating(s))
									</div>
								</div>
						
								<div class="row">
									<div class="col-md-4"><button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#allDocuments_{$Tender.ID}_{$ID}">Documents</button></div>
									<div class="col-md-2">&nbsp;</div>
									<div class="col-md-2"><a href="/get-prices/archive/{$ID}" class="btn btn-primary btn-sm" role="button">Archive</a></div>
									<div class="col-md-4">&nbsp;</div>
								</div>
							</div>
						</div>
				
						<% include AnswersModal %>
				
						<% include AllDocumentsModal %>
					<% end_loop %>
				<% end_if %>
			<% end_loop %>
		<% else %>
			<p>No records for awarded tenders available</p>
		<% end_if %>
    </div>
</section>


    
<section>
    <div class="container">
   		$CommentsForm
     </div>
</section>