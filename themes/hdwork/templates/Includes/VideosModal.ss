<!-- Videos Modal -->
<div class="modal fade" id="videosModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Videos</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        	<% if $Tender.Videos %>
        		<% loop $Tender.Videos %>
   	    			<div class="row">
 						<div class="col-md-6">$Video.Name</div>
 						<div class="col-md-6"><a href="$Video.URL" target="_blank" class="btn btn-primary btn-sm" role="button">Download</a></div>
  					</div>
  				<% end_loop %>
			<% else %>
				<p>No video uploaded!</p>
			<% end_if %>
      </div>  
      <div class="modal-footer">
      </div>
    </div>
  </div>
</div>