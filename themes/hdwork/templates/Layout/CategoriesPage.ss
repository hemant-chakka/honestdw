<section>
	<div class="container">
		<h2>$Title</h2>
		<ul>
			<% loop $Categories %>
				<li>
					<a href="/home/doSearch?parentCat={$ID}">$Name</a>
					<% if $SubCategories %>
						<ul>
							<% loop $SubCategories %>
								<li><a href="/home/doSearch?parentCat={$ParentID}&subCat={$ID}">$Name</a></li>
							<% end_loop %>
						</ul> 
					<% end_if %>
				</li>		
			<% end_loop %>
		</ul>
	</div>
</section>
    
<section>
    <div class="container">
   		$CommentsForm
     </div>
</section>