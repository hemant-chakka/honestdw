<section>
   <div class="container">
   		<h2>$Tender.Title</h2>
		$Message
   		<h4>
   			Client: $Tender.Client.FirstName
   			<% loop $Tender.Client %>
				<i class="fa fa-star <% if $Rating >= 1 %>fa-star-gold<% else %>fa-star-gray<% end_if %>" id="star1" data-no=1 aria-hidden="true"></i>
	    		<i class="fa fa-star <% if $Rating >= 2 %>fa-star-gold<% else %>fa-star-gray<% end_if %>" id="star2" data-no=2 aria-hidden="true"></i>
    	    	<i class="fa fa-star <% if $Rating >= 3 %>fa-star-gold<% else %>fa-star-gray<% end_if %>" id="star3" data-no=3 aria-hidden="true"></i>
        		<i class="fa fa-star <% if $Rating >= 4 %>fa-star-gold<% else %>fa-star-gray<% end_if %>" id="star4" data-no=4 aria-hidden="true"></i>
        		<i class="fa fa-star <% if $Rating >= 5 %>fa-star-gold<% else %>fa-star-gray<% end_if %>" id="star5" data-no=5 aria-hidden="true"></i>
        	<% end_loop %>
        	($Tender.Client.RatingCount Rating(s)) 
   		</h4>
   		<h4>$Tender.Category.Parent.Name >> $Tender.Category.Name</h4>
   		<h4>Closes on: $Tender.EndDate.Format(dS M Y h:i a)</h4>
        <div class="row">
			<div class="col-md-9">$Tender.Description</div>
			<div class="col-md-3">
				<% if $CurrentMember && $CurrentMember.ID != $Tender.ClientID  %>
		        	<% if $Tender.WatchingV2 %>
        				<a href="/get-prices/unwatch/$Tender.ID"><button type="button" class="btn btn-primary">UnWatch</button></a>
        			<% else %>
        				<a href="/get-prices/watch/$Tender.ID"><button type="button" class="btn btn-primary">Watch</button></a>
        			<% end_if %>
        		<% end_if %>	
			</div>
        </div>
    </div>
</section>

<section>
   <div class="container">

		<div class="row">
			<div class="col-md-4">Address</div>
			<div class="col-md-4">$Tender.AddressString</div>
			<div class="col-md-4">
				<% if not $Tender.revealAddress %>
					<button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#revealAddress">Reveal Address</button>
				<% end_if %>
			</div>
		</div>
		
		<div class="row">
			<div class="col-md-4">Price Type</div>
			<div class="col-md-4">$Tender.PriceType</div>
			<div class="col-md-4">&nbsp;</div>
		</div>
		
		<div class="row">
			<div class="col-md-4">Tender Type</div>
			<div class="col-md-4">$Tender.TenderType Tender</div>
			<div class="col-md-4">&nbsp;</div>
		</div>
		
		<div class="row">
			<div class="col-md-4">View on Site</div>
			<div class="col-md-4"><% if $Tender.ViewOnSite %>Yes<% else %>No<% end_if %></div>
			<div class="col-md-4">&nbsp;</div>
		</div>
		
		<% if $Tender.ViewOnSite %>
			<div class="row">
				<div class="col-md-4">View on Site Phone Number</div>
				<div class="col-md-4">$Tender.ViewOnSitePhoneV2</div>
				<div class="col-md-4">
					<% if $CurrentMember %>
						<% if $Tender.ClientID != $CurrentMember.ID  %>
							<% if not $Tender.Reveal || $Tender.Reveal.RevealPhone == 0 %>
								
								<button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#revealPhone">Reveal Phone</button>
							<% end_if %>
						<% end_if %>
					<% end_if %>
				</div>
			</div>
		<% end_if %>
		
		<div class="row">
			<div class="col-md-4">Required Documents</div>
			<div class="col-md-4">
				<% if $Tender.RequiredInfo %>
					<ul>
						<% if $Tender.ScheduleOfPricesV2 %>
							<li>Schedule of Prices</li>
						<% end_if %>
						<% if $Tender.CoverLetterRequired %>
							<li>Cover Letter</li>
						<% end_if %>
						<% if $Tender.TenderDocRequired %>
							<li>Tender Document</li>
						<% end_if %>
						<% if $Tender.HealthSafetyPolicyRequired %>
							<li>Health & Safety Policy</li>
						<% end_if %>
						<% if $Tender.DrawingsRequired %>
							<li>Drawings & Sketch</li>
						<% end_if %>
						<% if $Tender.OthersRequired %>
							<li>$Tender.OthersText</li>
						<% end_if %>
					</ul>
				<% else %>
					None
				<% end_if %>
			</div>
			<div class="col-md-4">&nbsp;</div>
		</div>		

	</div>
</section>

<% if $Tender.Images %>
	<section>
	   <div class="container">
			<div class="row">
				<div class="col-md-2"></div>
				<div class="col-md-8">
					<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel" data-interval="false">
  						<ol class="carousel-indicators">
							<% loop $Tender.Images %>
								<li data-target="#carouselExampleIndicators" data-slide-to="$Pos(0)" <% if $CoverPhoto %> class="active" <% end_if %>></li>
						    <% end_loop %>
						</ol>
  
			  			<div class="carousel-inner">
							<% loop $Tender.Images %>
								<div class="carousel-item <% if $CoverPhoto %>active<% end_if %>">
								      <a href="#" data-toggle="modal" class="zoom-carousal" data-serial="$Pos(0)" data-target="#imagesModal"><img class="d-block w-100" src="$Image.CroppedImage(750,250).URL"></a>
   								</div>
	    					<% end_loop %>
					   </div>
  
	  					<a class="carousel-control-prev" href="#" role="button" data-slide="prev">
    						<span class="carousel-control-prev-icon" aria-hidden="true"></span>
    						<span class="sr-only">Previous</span>
	  					</a>
			  			<a class="carousel-control-next" href="#" role="button" data-slide="next">
    						<span class="carousel-control-next-icon" aria-hidden="true"></span>
    						<span class="sr-only">Next</span>
  						</a>
					</div>
				</div>
				<div class="col-md-2"></div>
			</div>
		</div>
	</section>
<% end_if %>


<section>
   <div class="container">

		<div id="tender-map"></div>		

	</div>
</section>

<section>
   <div class="container text-center">

		<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#videosModal">Videos</button>	

	</div>
</section>

<section>
   <div class="container text-center">

		<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#supportingInfo">View Supporting Info</button>	

	</div>
</section>


<section>
	<div class="container text-center">
		<% if $Tender.ClientID != $CurrentMember.ID %>
			<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#questionsForm">Questions</button>	
		<% else %>
			<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#answersForm">Answers</button>
		<% end_if %>
	</div>
</section>

<% if $Tender.PriceType == 'Estimate' && $Tender.Estimate == 1 %>
	<section>
   		<div class="container text-center">
			<h3>Estimate: ${$Tender.ClientEstimate}</h3>
		</div>
	</section>
<% end_if %>


<% if $Tender.ClientID != $CurrentMember.ID %>
	<section>
		<div class="container text-center">

			<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#submitTenderForm">Submit Tender</button>	

		</div>
	</section>
<% else %>
	<% if $Tender.Stage != 'Archive' %>
	<section>
  			<div class="container text-center">

				<button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#withdrawTender">Withdraw Tender</button>	

			</div>
	</section>
	<% end_if %>
<% end_if %>


<% if $Tender.ClientID == $CurrentMember.ID %>
	<section>
  			<div class="container text-center">

				<button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#boostTender">Boost</button>	

			</div>
	</section>
<% end_if %>





<section>
    <div class="container">
   		$CommentsForm
     </div>
</section>


<script type="text/javascript">
  
  	<% if $Tender.IsRegion %>
  		function initMap() {
        // Create the map.
        var map = new google.maps.Map(document.getElementById('tender-map'), {
          zoom: <% if $Tender.CityVisible %>10<% else %>6<% end_if %>,
          center: {lat: $Tender.RegionLatitude, lng: $Tender.RegionLongitude},
          mapTypeId: 'terrain'
        });
        
        var cityCircle = new google.maps.Circle({
            strokeColor: '#99FF99',
            strokeOpacity: 0.8,
            strokeWeight: 2,
            fillColor: '#99FF99',
            fillOpacity: 0.35,
            map: map,
            center: {lat: $Tender.RegionLatitude, lng: $Tender.RegionLongitude},
            radius: <% if $Tender.CityVisible %>13000<% else %>120000<% end_if %>
          });
        }

  	<% else %>
  	
	  	function initMap() {
    	    var map = new google.maps.Map(document.getElementById('tender-map'), {
        	  zoom: 8,
	          center: {lat: -34.397, lng: 150.644}
    	    });
        	var geocoder = new google.maps.Geocoder();
       
          	geocodeAddress(geocoder, map);
       
      	}

	    function geocodeAddress(geocoder, resultsMap) {
	        var address = "$Tender.AddressString";
    	    geocoder.geocode({'address': address}, function(results, status) {
	        	if (status === 'OK') {
		            resultsMap.setCenter(results[0].geometry.location);
    		        var marker = new google.maps.Marker({
        		      map: resultsMap,
            		  position: results[0].geometry.location
		            });
    		    } else {
        	    	alert('Geocode was not successful for the following reason: ' + status);
          		}
        	});
      	}
    <% end_if %>  	
</script>

<script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD8tYjEszCsLplMAvNMjoHLDN8fL1TsDPU&callback=initMap">
</script>

<% include SupportingInfoModal %>

<% include VideosModal %>

<% include WithdrawTenderModal2 Tender=$Tender %>

<% include BoostTenderModal Tender=$Tender %>

<% include RevealAddressModal Tender=$Tender %>

<% include RevealPhoneModal Tender=$Tender %>

<% if $Tender.ClientID == $CurrentMember.ID %>
	<% include AnswersModal2 %>
<% else %>

	<% loop $Submission %>
		<% include QuestionsModal2 QaA=$Top.QaA %>	
	<% end_loop %>

<% end_if %>

<form method="post" id="SubmitTenderForm" action="/tender/submitTender">

	<% include SubmitTenderModal %>

	<% include DetailsRequiredModal %>

</form>

<% include ImagesModal %>	




