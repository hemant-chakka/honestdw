<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Tender Closing in 3 hours</title>
<style>
body{
	font-size: 11.0pt;
    font-family: "Calibri","sans-serif";
}

#getting-work-priced{
	margin:auto;
	width:507px;
	text-align:center;
	border: solid windowtext 1.0pt;
	padding: 10px 10px 0px 10px;
}

ul {
    list-style-type: none;
    margin: 0;
    padding: 0;
}

.user-buttons li {
    display: inline;
    padding:0px 30px;
}

.small-text{
	font-size: 9.0pt;
}

.tender-details{
	background-color: #d3d3d3;
    border: 2px solid;
}
</style>
</head>
<body>
	<div id="getting-work-priced">
		<a href="{$AbsoluteBaseURL}"><img border="0" src="{$AbsoluteBaseURL}themes/hdwork/images/image001.png"></a>
		<p><b>A Tender is Closing in 3 Hours</b></p>
		<p>The following tender on your Watchlist will close in 3 hours.</p>
		<p>Don't forget to clarify any questions now and prepare your price and support documents.</p>
		<div class="tender-details">
			<table>
				<tr>
					<td>
						<% loop $Tender.Images %>
							<% if $CoverPhoto %>
								<a href="{$AbsoluteBaseURL}tender/view/{$Top.Tender.ID}"><img src="$Image.CroppedImage(150,150).URL" class="img-responsive"></a>	
							<% end_if %>
						<% end_loop %>
					</td>
					<td>
						<ul>
  							<li><a href="{$AbsoluteBaseURL}tender/view/{$Tender.ID}">#$Tender.ID</a></li>
  							<li>$Tender.Title</li>
  							<li>$Tender.AddressString</li>
  							<li>$Tender.Description.LimitWordCount(15)</li>
  							<li>$Tender.EndDate.Format(dS M Y h:i a)</li>
						</ul>
					</td>
				</tr>
			</table>
		</div>
		<ul class="user-buttons">
  			<li><a href="{$AbsoluteBaseURL}Security/login"><img border="0" src="{$AbsoluteBaseURL}themes/hdwork/images/image003.jpg"></a></li>
  			<li><a href="{$AbsoluteBaseURL}register"><img border="0" src="{$AbsoluteBaseURL}themes/hdwork/images/image005.jpg"></a></li>
		</ul>
		<a href="{$AbsoluteBaseURL}"><img border="0" src="{$AbsoluteBaseURL}themes/hdwork/images/image007.png"></a>
		<p class="small-text">If you do not wish to receive these emails please reply to this address with the word <a href="mailto:admin@honestdayswork?bcc=lawtonandy@yahoo.co.nz&amp;subject=Please%20Unsubscribe%20Me%20&amp;body=Hi%20Honest%20Day's%20Work.%20I%20do%20not%20wish%20to%20receive%20further%20invitations%20to%20tender%20work%20opportunities.">"UNSUBSCIRBE"</a> in the subject line.</p>
	</div>
</body>
</html>