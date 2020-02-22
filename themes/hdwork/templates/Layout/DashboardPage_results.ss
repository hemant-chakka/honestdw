$SetSliderValue

<% include TenderSearchForm %>


<section id="SearchTenders" class="bg-color">
	<div class="container">
		<% if $PaginatedPages %>
		<%-- <div class="row"> --%>
			<% loop $PaginatedPages %>
				<% include TenderCard %>				
			<% end_loop %>
		<%-- </div> --%>

		<% else %>
			<p>Sorry no results found</p>
		<% end_if %>
		<% if $PaginatedPages.MoreThanOnePage %>
		    <% if $PaginatedPages.NotFirstPage %>
        		<a class="prev" href="$PaginatedPages.PrevLink">Prev</a>
    		<% end_if %>
 		    <% loop $PaginatedPages.Pages %>
        		<% if $CurrentBool %>
		            $PageNum
        		<% else %>
	            	<% if $Link %>
	    	            <a href="$Link">$PageNum</a>
    	    	    <% else %>
        	    	    ...
            		<% end_if %>
        		<% end_if %>
        	<% end_loop %>
    		<% if $PaginatedPages.NotLastPage %>
        		<a class="next" href="$PaginatedPages.NextLink">Next</a>
    		<% end_if %>
		<% end_if %>
	</div>
</section>

    
<section class="bg-color">
    <div class="container">
   		$CommentsForm
     </div>
</section>