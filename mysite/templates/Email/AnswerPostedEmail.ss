<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Answer Posted</title>
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

li {
    display: inline;
    padding:0px 30px;
}

.small-text{
	font-size: 9.0pt;
}
</style>
</head>
<body>
	<div id="getting-work-priced">
		<a href="{$AbsoluteBaseURL}"><img border="0" src="{$AbsoluteBaseURL}themes/hdwork/images/image001.png"></a>
		<p><b>$Member.Name has answered your question about tender '{$Tender.Title}':</b></p>
		<p><b>Question:</b></p>
		<p>$Question</p>
		<p><b>Answer:</b></p>
		<p>$Answer</p>
		<p>To reply please click <a href="{$AbsoluteBaseURL}get-prices/view/{$Tender.ID}">here</a>.</p>
		<br>
		<a href="{$AbsoluteBaseURL}"><img border="0" src="{$AbsoluteBaseURL}themes/hdwork/images/image007.png"></a>
		<p class="small-text">If you do not wish to receive these emails please reply to this address with the word <a href="mailto:admin@honestdayswork?bcc=lawtonandy@yahoo.co.nz&amp;subject=Please%20Unsubscribe%20Me%20&amp;body=Hi%20Honest%20Day's%20Work.%20I%20do%20not%20wish%20to%20receive%20further%20invitations%20to%20tender%20work%20opportunities.">"UNSUBSCIRBE"</a> in the subject line.</p>
	</div>
</body>
</html>