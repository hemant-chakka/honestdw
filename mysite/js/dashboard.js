(function($) {
	$("document").ready(function(){
		
		
		$( function() {
		    var handle = $( "#distance" );
		    $( "#slider" ).slider({
		    	min: 0,
		    	max:1000,
		    	create: function() {
		    		if(distance > 0){
		    			$(this).slider( "value", distance );
		    			handle.text(distance);
		    		}else{
		    			handle.text( $( this ).slider( "value" ) );
		    		}
		    	},
		    	slide: function( event, ui ) {
		    		handle.text( ui.value );
		    	},
		    	change: function( event, ui ) {
		    		$("#inputDistance").val(ui.value);
		    	}
		    });
		 } );
		

		/*
		if (navigator.geolocation) {
		       navigator.geolocation.getCurrentPosition(showPosition);
		}else{ 
		       alert("Geolocation is not supported by this browser.");
	    }  */

		function showPosition(position) {
			$("#inputLatitude").val(position.coords.latitude);
			
			$("#inputLongitude").val(position.coords.longitude);
		}
		
		$( "#inputParentID" ).change(function() {
			$.get( "get-prices/getSubCategoriesDD?parentID="+$(this).val(), function( data ) {
				  $("#inputCategoryID").html( data );
			});
		});
		
	});
})(jQuery)
