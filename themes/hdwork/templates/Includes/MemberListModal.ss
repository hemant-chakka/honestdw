<!-- Member List Modal -->
<div class="modal fade" id="memberList" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Member List</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
			<% if $MemberList %>
				<table class="table table-striped">
				  <thead>
				    <tr>
      					<th scope="col" class="w-35">Name</th>
					    <th scope="col" class="w-50">Email</th>
					    <th scope="col" class="w-10"></th>
    				</tr>
  				  </thead>
  					<tbody>
						<% loop MemberList %>
						    <tr>
						    	<td>$TradeUserName</td>
      							<td>$Email</td>
      							<td><a class="NotifyUserCTLink" href="/navigate-tenders/notifyUserClosedTender?email={$Email}&tenderId={$Top.TenderID}">Notify</a></td>
    						</tr>
						<% end_loop %>
  					</tbody>
				</table>
			<% else %>
				<p>No contractors found</p>
			<% end_if %>
      </div>  
      <div class="modal-footer">
      </div>
    </div>
  </div>
</div>