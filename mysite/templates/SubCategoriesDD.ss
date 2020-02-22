<option value="">Select a Sub Category..</option>
<% if $Categories %>
	<% loop $Categories %>
		<option value="$ID">$Name</option>
	<% end_loop %>
<% end_if %>