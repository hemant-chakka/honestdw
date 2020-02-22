<section>
   <div id="NavTenders" class="container">
   		<h2>My Tenders - Work I'm Pricing</h2>
   		$Message
		<% if $Watching %>
			<% loop $Watching %>
				<div class="row">
					<div class="col-md-2">
						<% if $Tender.Images %>
							<% loop $Tender.Images %>
		        				<% if $CoverPhoto %>
		        					<% if $Up.Up.Submission %>
		        						<a href="/submission/view/$TenderID?submitId=$Up.Up.SubmissionID"><img src="$Image.CroppedImage(150,150).URL" class="img-responsive"></a>
		        					<% else %>
		        						<a href="/tender/view/$TenderID"><img src="$Image.CroppedImage(150,150).URL" class="img-responsive"></a>
		        					<% end_if %>
        						<% end_if %>
        					<% end_loop %>
						<% end_if %>
					</div>
					<div class="col-md-10">
						<div class="row">
							<div class="col-md-4">
								<% if $Submission %>
	        						<p><a href="/submission/view/$TenderID?submitId=$SubmissionID">Ref #$TenderID</a></p>
	        					<% else %>
	        						<p><a href="/tender/view/$TenderID">Ref #$TenderID</a></p>
	        					<% end_if %>
							</div>
							<div class="col-md-2">Due to close on:</div>
							<div class="col-md-3">$Tender.EndDate.Format(dS M Y h:i a)</div>
							<div class="col-md-3">&nbsp;</div>
						</div>
							
						<div class="row">
							<div class="col-md-4">
								<% if $Submission %>
	        						<p><a href="/submission/view/$TenderID?submitId=$SubmissionID">$Tender.Title</a></p>
	        					<% else %>
	        						<p><a href="/tender/view/$TenderID">$Tender.Title</a></p>
	        					<% end_if %>
							</div>
							<div class="col-md-2">&nbsp;</div>
							<div class="col-md-2">
								<button type="button" class="btn btn-primary btn-sm"  data-toggle="modal" data-target="#questionsForm_{$TenderID}_{$Submission.ID}">Comms</button>
							</div>
							<div class="col-md-4">&nbsp;</div>
						</div>

						<div class="row">
							<div class="col-md-4">
								<% if $Submission.Status = 'Paid' %>
									<p><span>Your Price</span>: ${$Submission.PriceSubmitted}</p>
								<% else %>
									<a class="btn btn-primary btn-sm" href="/tender/view/$TenderID" role="button">Submit Tender</a>
								<% end_if %>
							</div>
							<div class="col-md-8">&nbsp;</div>
						</div>
						
						<div class="row">
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

				<% if $Submission %>
					<% loop $Submission %>
						<% include QuestionsModal %>
					<% end_loop %>
				<% end_if %>
			<% end_loop %>
		<% else %>
			<p>No tenders available that are watched by you.</p>
		<% end_if %>
    </div>
</section>


    
<section>
    <div class="container">
   		$CommentsForm
     </div>
</section>