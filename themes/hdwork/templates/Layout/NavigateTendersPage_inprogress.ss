<section>
   <div id="NavTenders" class="container">
   		<h2>My Tenders - In Progress</h2>
   		$Message
		<% if $InProgressTenders %>
			<% loop $InProgressTenders %>
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
							<div class="col-md-2">Due to close on:</div>
							<div class="col-md-3">$EndDate.Format(dS M Y h:i a)</div>
							<div class="col-md-3">&nbsp;</div>
						</div>
						
						<div class="row">
							<div class="col-md-4"><p><a href="/tender/view/$ID">$Title</a></p></div>
							<div class="col-md-2">&nbsp;</div>
							<div class="col-md-2"><button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#extendTender_{$ID}">Extend Tender</button></div>
							<div class="col-md-4">&nbsp;</div>
						</div>
						
						<div class="row">
							<div class="col-md-4">&nbsp;</div>
							<div class="col-md-2">&nbsp;</div>
							<div class="col-md-2"><button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#withdrawTender_{$ID}">Withdraw Tender</button></div>
							<div class="col-md-4">&nbsp;</div>
						</div>
						
						<div class="row">
							<div class="col-md-4">&nbsp;</div>
							<div class="col-md-2">&nbsp;</div>
							<div class="col-md-2">
								<% if TenderType == 'Closed' %>
									<button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#searchContractors_{$ID}">Add User</button>
								<% else %>
									&nbsp;
								<% end_if %>
							</div>
							<div class="col-md-4">&nbsp;</div>
						</div>
					</div>
				</div>
				
				<% if $SubmissionsAssess %>
					<div class="row">
						<div class="col-md-12">
							<h3>Submissions</h3>
							<table class="table table-striped">
							  <tbody>
    							<% loop $SubmissionsAssess %>
								    <tr>
      									<td>
      										<a href="/submission/view/$TenderID?submitId=$ID">
      											$Contractor.Name
      											<% loop $Contractor %>
													<i class="fa fa-star <% if $Rating >= 1 %>fa-star-gold<% else %>fa-star-gray<% end_if %>" id="star1" data-no=1 aria-hidden="true"></i>
		    	    								<i class="fa fa-star <% if $Rating >= 2 %>fa-star-gold<% else %>fa-star-gray<% end_if %>" id="star2" data-no=2 aria-hidden="true"></i>
    		    									<i class="fa fa-star <% if $Rating >= 3 %>fa-star-gold<% else %>fa-star-gray<% end_if %>" id="star3" data-no=3 aria-hidden="true"></i>
        											<i class="fa fa-star <% if $Rating >= 4 %>fa-star-gold<% else %>fa-star-gray<% end_if %>" id="star4" data-no=4 aria-hidden="true"></i>
        											<i class="fa fa-star <% if $Rating >= 5 %>fa-star-gold<% else %>fa-star-gray<% end_if %>" id="star5" data-no=5 aria-hidden="true"></i>
        										<% end_loop %>
        										($Contractor.RatingCount Rating(s))
        									</a>
      									</td>
									    <td>AV</td>
      									<td><button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#allDocuments_{$TenderID}_{$ID}">Documents</button></td>
      									<td>${$PriceSubmitted}</td>
      									<td><button type="button" class="btn btn-primary btn-sm"  data-toggle="modal" data-target="#answersForm_{$TenderID}_{$ID}">Comms</button></td>
      									<td>
      										<% if $Tender.AssessTenderControl == 'FirstInFirst' %>
      											<button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#awardTender_{$TenderID}_{$ID}">Award</button>
      										<% else %>
      											&nbsp;
      										<% end_if %>
      									</td>
    								</tr>
    								<% if $Clarifications %>
    									<tr>
    										<td colspan=6><b>Notes:</b><p><a href="#" data-toggle="modal" data-target="#Notes_{$TenderID}_{$ID}">$Clarifications.LimitWordCount(15)</a><p></td>
    									</tr>
    								<% end_if %>
    							<% end_loop %>
   							  </tbody>
							</table>
						</div>
					</div>
				<% end_if %>
			<% end_loop %>
		<% else %>
			<p>No records of tenders available in progress.</p>
		<% end_if %>
    </div>
</section>

<% if $InProgressTenders %>
	<section>
		<div class="container">
			<% loop $InProgressTenders %>
				<% include ExtendTenderModal %>
				<% include WithdrawTenderModal %>
				<% if $TenderType == 'Closed' %>
					<% include SearchContractorsModal %>
				<% end_if %>
				<% if $SubmissionsAssess %>
					<% loop $SubmissionsAssess %>
						<% include AnswersModal %>
						<% include AllDocumentsModal %>
						<% include NotesModal %>
						<% if $Tender.AssessTenderControl == 'FirstInFirst' %>
   							<% include AwardTenderModal %>
						<% end_if %>
					<% end_loop %>
				<% end_if %>
			<% end_loop %>
		</div>
	</section>
<% end_if %>

    
<section>
    <div class="container">
   		$CommentsForm
     </div>
</section>

<% include MemberListModal %>