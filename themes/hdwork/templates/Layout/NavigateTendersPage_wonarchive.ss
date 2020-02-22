<section>
   <div id="NavTenders" class="container">
   		<h2>My Tenders - Archive of Won Work</h2>
   		$Message
		<% if $WonTendersArchive %>
			<% loop $WonTendersArchive %>
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
							<div class="col-md-2"><button type="button" class="btn btn-primary btn-sm"  data-toggle="modal" data-target="#questionsForm_{$TenderID}_{$ID}">Comms</button></div>
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
							<div class="col-md-4"><p>Contracted to $Tender.Client.Name</p></div>
							<div class="col-md-4">
								<% loop $Tender.Client %>
									<i class="fa fa-star <% if $Rating >= 1 %>fa-star-gold<% else %>fa-star-gray<% end_if %>" id="star1" data-no=1 aria-hidden="true"></i>
   									<i class="fa fa-star <% if $Rating >= 2 %>fa-star-gold<% else %>fa-star-gray<% end_if %>" id="star2" data-no=2 aria-hidden="true"></i>
									<i class="fa fa-star <% if $Rating >= 3 %>fa-star-gold<% else %>fa-star-gray<% end_if %>" id="star3" data-no=3 aria-hidden="true"></i>
									<i class="fa fa-star <% if $Rating >= 4 %>fa-star-gold<% else %>fa-star-gray<% end_if %>" id="star4" data-no=4 aria-hidden="true"></i>
									<i class="fa fa-star <% if $Rating >= 5 %>fa-star-gold<% else %>fa-star-gray<% end_if %>" id="star5" data-no=5 aria-hidden="true"></i>
    							<% end_loop %>
    							($Tender.Client.RatingCount Rating(s))							
        					</div>
							<div class="col-md-4">
								<% if $ClientRating %>
									&nbsp;
								<% else %>
									<button type="button" class="btn btn-primary btn-sm"  data-toggle="modal" data-target="#rateUserForm_{$TenderID}_{$ID}">Rate</button>
								<% end_if %>
							</div>
						</div>
						
						<div class="row">
							<div class="col-md-4">&nbsp;</div>
							<div class="col-md-2">&nbsp;</div>
							<div class="col-md-2"><button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#allDocuments_{$TenderID}_{$ID}">Documents</button></div>
							<div class="col-md-4">&nbsp;</div>
						</div>
					</div>
				</div>
				
				<% include QuestionsModal %>
				
				<% include AllDocumentsModal %>
				
				<% include RateUserModal2 %>
			<% end_loop %>
		<% else %>
			<p>No records for won tenders archive available</p>
		<% end_if %>
    </div>
</section>
    
<section>
    <div class="container">
   		$CommentsForm
     </div>
</section>