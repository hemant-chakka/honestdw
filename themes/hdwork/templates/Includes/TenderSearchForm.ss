<section  class="narrow-section" id="SearchTenders">
	<div class="container">
		<form method="post" id="CreateTenderForm" action="/home/doSearch">
			<div class="row search-row-1">
  				<div class="col-md-4">
	  				<input type="text" class="form-control" id="inputKeyword" name="Keyword" value="$TenderSearchFormData.Keyword" placeholder="Keyword">
  				</div>
	  			<div class="col-md-4">
  					<div class="form-slider-wrap">
  						<label for="amount">Distance in Km</label>
	  					<div id="slider">
	  						<div id="distance" class="ui-slider-handle"></div>  						
						</div>
						<input type="hidden" id="inputDistance" name="Distance">
						<input type="hidden" id="inputLatitude" name="Latitude" value="-38.662334">
						<input type="hidden" id="inputLongitude" name="Longitude" value="178.017654">
					</div>
  				</div>
  				<div class="col-md-4">
  					<div class="select-wrap">
  						<select name="Region" id="inputRegion" class="form-control">
  						<option value="">Select a Region..</option>
	  					<% if $Regions %>
	  						<% loop $Regions %>
	  							<option value="$Name" <% if $Top.TenderSearchFormData.Region == $Name %>selected<% end_if %>>$Name</option>
	  						<% end_loop %>
	  					<% end_if %>
	  				</select>
	  			</div>
  				</div>  				
			</div>
			
			<div class="row search-row-2">  				
	  			<div class="col-md-4">
	  				<div class="select-wrap">
	  				<select name="ParentID" id="inputParentID" class="form-control">
			  			<% if $Categories %>
  							<option value="">Select a Category..</option>
  							<% loop $Categories %>
  								<option value="$ID" <%if $Top.TenderSearchFormData.ParentID == $ID %>selected<% end_if %>>$Name</option>
  							<% end_loop %>
  						<% end_if %>
  					</select>
  				</div>
	  			</div>
  				<div class="col-md-4">
  					<div class="select-wrap">
  					<select name="CategoryID" id="inputCategoryID" class="form-control">
			        	<option value="">Select a Sub Category..</option>
        				<% if $SubCategories %>
							<% loop $SubCategories %>
								<option value="$ID" <%if $Top.TenderSearchFormData.CategoryID == $ID %>selected<% end_if %>>$Name</option>
							<% end_loop %>
						<% end_if %>
        			</select>
        		</div>
  				</div>
  				<div class="col-md-4"><button type="submit" class="btn btn-block btn-primary">Search</button></div>
			</div>
		</form>
	</div>
</section>