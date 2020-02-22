(function($) {
	$("document").ready(function(){
		
		$('.EndDate').datetimepicker({
			format: 'DD MMM YYYY hh:mm a', 
			minDate: moment(),
			maxDate: moment().add(6,'months')
		});
		
		$('.NotifyUserCTLink').click(function(event){
			event.preventDefault();
			var url = $(this).attr('href');
			$.get(url, function( data ) {
				  alert(data);
				});
			
		});
		
		var star_class = [];
		
		$( ".rate-star" ).mouseover(function() {
			var id = "#rateUserForm"+$(this).attr('data-id');
			for(var i = 1; i <= 5; i++) {
			    if($(id+" .star"+i).hasClass( "fa-star-gray" ))
			    	star_class[i] = 'fa-star-gray';
			    else
			    	star_class[i] = 'fa-star-gold';
			}
			
			var no = $(this).attr('data-no');
			for(var i = 1; i <= no; i++) {
				$(id+" .star"+i).removeClass("fa-star-gray").addClass("fa-star-gold");
			}
		});
		
		$( ".rate-star" ).mouseout(function() {
			var id = "#rateUserForm"+$(this).attr('data-id');
			for(var i = 1; i <= 5; i++) {
				$(id+" .star"+i).removeClass("fa-star-gray fa-star-gold").addClass(star_class[i]);
			}
		});
		
		$( ".rate-star" ).click(function() {
			var no = $(this).attr('data-no');
			var id = "#rateUserForm"+$(this).attr('data-id');
			for(var i = 1; i <= no; i++) {
			  $(id+" .star"+i).removeClass("fa-star-gray").addClass("fa-star-gold");
		    }
			  
			for(var i = 1; i <= 5; i++) {
			   if(i <= no)
			    	star_class[i] = 'fa-star-gold';
			   else
				    star_class[i] = 'fa-star-gray';
			}
			  
			$(id+" [name='Rating']").val(no);
		});
		
	});
})(jQuery)
