<div class="row">
	<div class="col-12">
		<div class="media tender-card">
		  <% loop $Images %>
				  <% if $CoverPhoto %>
				  	<a href="/tender/view/$Up.ID"><img class="d-block d-sm-none align-self-start mr-3 img-fluid" src="$Image.CroppedImage(80,80).URL" alt="$Title image"><img class="d-none d-sm-block align-self-start mr-3 img-fluid" src="$Image.CroppedImage(400,200).URL" alt="$Title image"></a>
				  <% end_if %>
			  <% end_loop %>	  
		  <div class="media-body">
		    <h3 class="mt-0"><a href="/tender/view/$ID">$Title</a></h3>
		    <div class="summary"><a href="/tender/view/$ID">$Description.LimitWordCount(15)</a></div>
		    <a href="/tender/view/$ID" class="btn btn-primary">View tender</a>
		  </div>
		</div>
	</div>
</div>

