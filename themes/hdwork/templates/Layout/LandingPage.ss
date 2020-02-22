<section>
   <div class="container content">
   		<h2>$Title</h2>
		$Message
        <p>$Content</p>
   		$Form
    </div>
</section>
    
<section class="links-list">
    <div class="container">
   		<% loop Children %>
   			<div class="links-list--item $FirstLast">
   				<a href="$Link">$MenuTitle</a>
   			</div> 
   		<% end_loop %>
     </div>
</section>