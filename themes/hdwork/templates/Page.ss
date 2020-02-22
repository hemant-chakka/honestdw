<!DOCTYPE html>
<!--[if !IE]><!-->
<html lang="$ContentLocale">
<!--<![endif]-->
<!--[if IE 6 ]><html lang="$ContentLocale" class="ie ie6"><![endif]-->
<!--[if IE 7 ]><html lang="$ContentLocale" class="ie ie7"><![endif]-->
<!--[if IE 8 ]><html lang="$ContentLocale" class="ie ie8"><![endif]-->
  <head>
  	<% base_tag %>
    <meta charset="utf-8">
    <title><% if $MetaTitle %>$MetaTitle<% else %>$Title<% end_if %> &raquo; $SiteConfig.Title</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">
    
    $MetaTags(false)
	<!--[if lt IE 9]>
	<script src="//html5shiv.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->
    
    <!-- Facebook Opengraph integration: https://developers.facebook.com/docs/sharing/opengraph -->
    <meta property="og:title" content="">
    <meta property="og:image" content="">
    <meta property="og:url" content="">
    <meta property="og:site_name" content="">
    <meta property="og:description" content="">
    
    <!-- Twitter Cards integration: https://dev.twitter.com/cards/  -->
    <meta name="twitter:card" content="summary">
    <meta name="twitter:site" content="">
    <meta name="twitter:title" content="">
    <meta name="twitter:description" content="">
    <meta name="twitter:image" content="">

	<!-- Google Fonts -->
	<% require css("https://fonts.googleapis.com/css?family=Nunito:400,700,900|Roboto:400,900") %>
	
	<!-- Bootstrap CSS File -->
	<% require css("themes/hdwork/lib/bootstrap/css/bootstrap.min.css") %>
	
	
	
	<!-- Libraries CSS Files -->
	<% require css("themes/hdwork/lib/font-awesome/css/font-awesome.min.css") %>
	
	
	<% require css("themes/hdwork/css/bootstrap-datetimepicker.min.css") %>
	
	
	<!-- Main Stylesheet File -->
	<% require themedCSS('main') %>



    <!-- Favicon -->
    <link rel="shortcut icon" href="$ThemeDir/images/favicon.ico" />
    
    
    <!-- =======================================================
      Theme Name: Bell
      Theme URL: https://bootstrapmade.com/bell-free-bootstrap-4-template/
      Author: BootstrapMade.com
      Author URL: https://bootstrapmade.com
    ======================================================= -->
  
  	<% include GoogleAnalyticsTrackingCode %>
  </head>

  <body class="cls-$ClassName">
    <!-- Page Content
    ================================================== -->
	
	<% include Header %>

	$Layout

  <% include SimpleContentBlocks %>


    <% include Footer %>
    
  </body>
</html>