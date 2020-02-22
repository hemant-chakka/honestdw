<% if $SimpleContentBlocks %>
	<div class="home-content-blocks" >
	<% loop $SimpleContentBlocks %>  
	<section class="home-content-block" <% if $BackgroundImage %>style="background-image:url($BackgroundImage.URL)"<% end_if %>>
	   <div class="container">
		   <% if $ShowTitle %><h2>$Title</h2><% end_if %>
		   <div class="block-content">
		   		$Content
			</div>
		</div>
	</section>
	<% end_loop %>
	</div>
<% end_if %>