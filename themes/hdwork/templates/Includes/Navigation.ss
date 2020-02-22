<nav id="nav-menu-container">
     <ul class="nav-menu">
       	<% loop $Menu(1) %>
            <% if $CustomVisibility %>
	            <li <% if $Children %>class="menu-has-children"<% end_if %>  ><a href="$Link">$MenuTitle</a>
				    <% if $Children %>
       	    	        <ul>
			    	        <% loop $Children %>
           					    <li <% if $Children %>class="menu-has-children"<% end_if %>><a href="$Link">$MenuTitle</a>
   					    			<% if $Children %>
			        	    	        <ul>
  		    						        <% loop $Children %>
           				    					<li><a href="$Link">$MenuTitle</a></li>
	                   						<% end_loop %>
    		        					</ul>
	     	        				<% end_if %>
              				    </li>
	   	                   	<% end_loop %>
    			        </ul>
	   	    	    <% end_if %>
    	    	</li>
    	    <% end_if %>
	    <% end_loop %>
	    <% if $CurrentMember %>
	    	<li><a href="/home/logout">Logout</a></li>
	    	<li><a href="#" data-toggle="modal" data-target="#PayOutAmountModal">Account<% if $CurrentMember.creditAvailed > 0 %> - ${$CurrentMember.creditAvailed}<% end_if %></a></li>
	    <% else %>
	    	<li><a href="/Security/login">Login</a></li>
	    <% end_if %>
    </ul>  
</nav><!-- #nav-menu-container -->