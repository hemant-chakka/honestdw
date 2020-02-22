<!-- Images Modal -->
<div class="modal fade imagesModal" id="imagesModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">&nbsp;</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        	<% if $Tender.Images %>
					<div id="carouselExampleIndicators2" class="carousel slide" data-ride="carousel" data-interval="false">
  						<ol class="carousel-indicators">
							<% loop $Tender.Images %>
								<li data-target="#carouselExampleIndicators2" data-slide-to="$Pos(0)" <% if $CoverPhoto %> class="active" <% end_if %>></li>
						    <% end_loop %>
						</ol>
  
			  			<div class="carousel-inner">
							<% loop $Tender.Images %>
								<div class="carousel-item <% if $CoverPhoto %>active<% end_if %>">
								      <img class="d-block img-fluid"  src="$Image.URL">
   								</div>
	    					<% end_loop %>
					   </div>
  
	  					<a class="carousel-control-prev" href="#carouselExampleIndicators2" role="button" data-slide="prev">
    						<span class="carousel-control-prev-icon" aria-hidden="true"></span>
    						<span class="sr-only">Previous</span>
	  					</a>
			  			<a class="carousel-control-next" href="#carouselExampleIndicators2" role="button" data-slide="next">
    						<span class="carousel-control-next-icon" aria-hidden="true"></span>
    						<span class="sr-only">Next</span>
  						</a>
					</div>
			<% end_if %>
      </div>  
      <div class="modal-footer">
      </div>
    </div>
  </div>
</div>