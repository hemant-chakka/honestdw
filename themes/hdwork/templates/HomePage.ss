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
  </head>

  <body class="cls-$ClassName">
    <!-- Page Content
    ================================================== -->
	
	<% include HeaderHp %>
	  
    <!-- About -->

    <section class="about" id="about">
      <div class="container text-center">
        <h2>
          About Bell Theme
        </h2>

        <p>
          Voluptua scripserit per ad, laudem viderer sit ex. Ex alia corrumpit voluptatibus usu, sed unum convenire id. Ut cum nisl moderatius, per nihil dicant commodo an. Eum tacimates erroribus ad. Atqui feugiat euripidis ea pri, sed veniam tacimates ex. Menandri temporibus an duo.
        </p>

        <div class="row stats-row">
          <div class="stats-col text-center col-md-3 col-sm-6">
            <div class="circle">
              <span class="stats-no" data-toggle="counter-up">232</span> Satisfied Customers
            </div>
          </div>

          <div class="stats-col text-center col-md-3 col-sm-6">
            <div class="circle">
              <span class="stats-no" data-toggle="counter-up">79</span> Released Projects
            </div>
          </div>

          <div class="stats-col text-center col-md-3 col-sm-6">
            <div class="circle">
              <span class="stats-no" data-toggle="counter-up">1,463</span> Hours Of Support
            </div>
          </div>

          <div class="stats-col text-center col-md-3 col-sm-6">
            <div class="circle">
              <span class="stats-no" data-toggle="counter-up">15</span> Hard Workers
            </div>
          </div>
        </div>
      </div>
    </section>
    <!-- /About -->
    <!-- Parallax -->

    <div class="block bg-primary block-pd-lg block-bg-overlay text-center" data-bg-img="img/parallax-bg.jpg" data-settings='{"stellar-background-ratio": 0.6}' data-toggle="parallax-bg">
      <h2>
        Welcome to a perfect theme
      </h2>

      <p>
        This is the most powerful theme with thousands of options that you have never seen before.
      </p>
      <img alt="Bell - A perfect theme" class="gadgets-img hidden-md-down" src="themes/hdwork/images/gadgets.png">
    </div>
    <!-- /Parallax -->
    <!-- Features -->

    <section class="features" id="features">
      <div class="container">
        <h2 class="text-center">
          Features
        </h2>

        <div class="row">
          <div class="feature-col col-lg-4 col-xs-12">
            <div class="card card-block text-center">
              <div>
                <div class="feature-icon">
                  <span class="fa fa-rocket"></span>
                </div>
              </div>

              <div>
                <h3>
                  Custom Design
                </h3>

                <p>
                  Eque feugiat contentiones ei has. Id summo mundi explicari his, nec in maiorum scriptorem.
                </p>
              </div>
            </div>
          </div>

          <div class="feature-col col-lg-4 col-xs-12">
            <div class="card card-block text-center">
              <div>
                <div class="feature-icon">
                  <span class="fa fa-envelope"></span>
                </div>
              </div>

              <div>
                <h3>
                  Responsive Layout
                </h3>

                <p>
                  Eque feugiat contentiones ei has. Id summo mundi explicari his, nec in maiorum scriptorem.
                </p>
              </div>
            </div>
          </div>

          <div class="feature-col col-lg-4 col-xs-12">
            <div class="card card-block text-center">
              <div>
                <div class="feature-icon">
                  <span class="fa fa-bell"></span>
                </div>
              </div>

              <div>
                <h3>
                  Innovative Ideas
                </h3>

                <p>
                  Eque feugiat contentiones ei has. Id summo mundi explicari his, nec in maiorum scriptorem.
                </p>
              </div>
            </div>
          </div>
        </div>

        <div class="row">
          <div class="feature-col col-lg-4 col-xs-12">
            <div class="card card-block text-center">
              <div>
                <div class="feature-icon">
                  <span class="fa fa-database"></span>
                </div>
              </div>

              <div>
                <h3>
                  Good Documentation
                </h3>

                <p>
                  Eque feugiat contentiones ei has. Id summo mundi explicari his, nec in maiorum scriptorem.
                </p>
              </div>
            </div>
          </div>

          <div class="feature-col col-lg-4 col-xs-12">
            <div class="card card-block text-center">
              <div>
                <div class="feature-icon">
                  <span class="fa fa-cutlery"></span>
                </div>
              </div>

              <div>
                <h3>
                  Excellent Features
                </h3>

                <p>
                  Eque feugiat contentiones ei has. Id summo mundi explicari his, nec in maiorum scriptorem.
                </p>
              </div>
            </div>
          </div>

          <div class="feature-col col-lg-4 col-xs-12">
            <div class="card card-block text-center">
              <div>
                <div class="feature-icon">
                  <span class="fa fa-dashboard"></span>
                </div>
              </div>

              <div>
                <h3>
                  Retina Ready
                </h3>

                <p>
                  Eque feugiat contentiones ei has. Id summo mundi explicari his, nec in maiorum scriptorem.
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    <!-- /Features -->
    <!-- Call to Action -->

    <section class="cta">
      <div class="container">
        <div class="row">
          <div class="col-lg-9 col-sm-12 text-lg-left text-center">
            <h2>
              Call to Action Section
            </h2>

            <p>
              Lorem ipsum dolor sit amet, nec ad nisl mandamus imperdiet, ut corpora cotidieque cum. Et brute iracundia his, est eu idque dictas gubergren
            </p>
          </div>

          <div class="col-lg-3 col-sm-12 text-lg-right text-center">
            <a class="btn btn-ghost" href="#">Buy This Theme</a>
          </div>
        </div>
      </div>
    </section>
    <!-- /Call to Action -->
    <!-- Portfolio -->

    <section class="portfolio" id="portfolio">
      <div class="container text-center">
        <h2>
          Portfolio
        </h2>

        <p>
          Voluptua scripserit per ad, laudem viderer sit ex. Ex alia corrumpit voluptatibus usu, sed unum convenire id. Ut cum nisl moderatius, Per nihil dicant commodo an.
        </p>
      </div>

      <div class="portfolio-grid">
        <div class="row">
          <div class="col-lg-3 col-sm-6 col-xs-12">
            <div class="card card-block">
              <a href="#"><img alt="" src="themes/hdwork/images/porf-1.jpg">
              <div class="portfolio-over">
                <div>
                  <h3 class="card-title">
                    The Dude Rockin'
                  </h3>

                  <p class="card-text">
                    Lorem ipsum dolor sit amet, eu sed suas eruditi honestatis.
                  </p>
                </div>
              </div></a>
            </div>
          </div>

          <div class="col-lg-3 col-sm-6 col-xs-12">
            <div class="card card-block">
              <a href="#"><img alt="" src="themes/hdwork/images/porf-2.jpg">
              <div class="portfolio-over">
                <div>
                  <h3 class="card-title">
                    The Dude Rockin'
                  </h3>

                  <p class="card-text">
                    Lorem ipsum dolor sit amet, eu sed suas eruditi honestatis.
                  </p>
                </div>
              </div></a>
            </div>
          </div>

          <div class="col-lg-3 col-sm-6 col-xs-12">
            <div class="card card-block">
              <a href="#"><img alt="" src="themes/hdwork/images/porf-3.jpg">
              <div class="portfolio-over">
                <div>
                  <h3 class="card-title">
                    The Dude Rockin'
                  </h3>

                  <p class="card-text">
                    Lorem ipsum dolor sit amet, eu sed suas eruditi honestatis.
                  </p>
                </div>
              </div></a>
            </div>
          </div>

          <div class="col-lg-3 col-sm-6 col-xs-12">
            <div class="card card-block">
              <a href="#"><img alt="" src="themes/hdwork/images/porf-4.jpg">
              <div class="portfolio-over">
                <div>
                  <h3 class="card-title">
                    The Dude Rockin'
                  </h3>

                  <p class="card-text">
                    Lorem ipsum dolor sit amet, eu sed suas eruditi honestatis.
                  </p>
                </div>
              </div></a>
            </div>
          </div>
        </div>

        <div class="row">
          <div class="col-lg-3 col-sm-6 col-xs-12">
            <div class="card card-block">
              <a href="#"><img alt="" src="themes/hdwork/images/porf-5.jpg">
              <div class="portfolio-over">
                <div>
                  <h3 class="card-title">
                    The Dude Rockin'
                  </h3>

                  <p class="card-text">
                    Lorem ipsum dolor sit amet, eu sed suas eruditi honestatis.
                  </p>
                </div>
              </div></a>
            </div>
          </div>

          <div class="col-lg-3 col-sm-6 col-xs-12">
            <div class="card card-block">
              <a href="#"><img alt="" src="themes/hdwork/images/porf-6.jpg">
              <div class="portfolio-over">
                <div>
                  <h3 class="card-title">
                    The Dude Rockin'
                  </h3>

                  <p class="card-text">
                    Lorem ipsum dolor sit amet, eu sed suas eruditi honestatis.
                  </p>
                </div>
              </div></a>
            </div>
          </div>

          <div class="col-lg-3 col-sm-6 col-xs-12">
            <div class="card card-block">
              <a href="#"><img alt="" src="themes/hdwork/images/porf-7.jpg">
              <div class="portfolio-over">
                <div>
                  <h3 class="card-title">
                    The Dude Rockin'
                  </h3>

                  <p class="card-text">
                    Lorem ipsum dolor sit amet, eu sed suas eruditi honestatis.
                  </p>
                </div>
              </div></a>
            </div>
          </div>

          <div class="col-lg-3 col-sm-6 col-xs-12">
            <div class="card card-block">
              <a href="#"><img alt="" src="themes/hdwork/images/porf-8.jpg">
              <div class="portfolio-over">
                <div>
                  <h3 class="card-title">
                    The Dude Rockin'
                  </h3>

                  <p class="card-text">
                    Lorem ipsum dolor sit amet, eu sed suas eruditi honestatis.
                  </p>
                </div>
              </div></a>
            </div>
          </div>
        </div>
      </div>
    </section>
    <!-- /Portfolio -->
    <!-- Team -->

    <section class="team" id="team">
      <div class="container">
        <h2 class="text-center">
          Meet our team
        </h2>

        <div class="row">
          <div class="col-sm-3 col-xs-6">
            <div class="card card-block">
              <a href="#"><img alt="" class="team-img" src="themes/hdwork/images/team-1.jpg">
              <div class="card-title-wrap">
                <span class="card-title">Sergio Fez</span> <span class="card-text">Art Director</span>
              </div>

              <div class="team-over">
                <h4 class="hidden-md-down">
                  Connect with me
                </h4>

                <nav class="social-nav">
                  <a href="#"><i class="fa fa-twitter"></i></a> <a href="#"><i class="fa fa-facebook"></i></a> <a href="#"><i class="fa fa-linkedin"></i></a> <a href="#"><i class="fa fa-envelope"></i></a>
                </nav>

                <p>
                  Lorem ipsum dolor sit amet, eu sed suas eruditi honestatis.
                </p>
              </div></a>
            </div>
          </div>

          <div class="col-sm-3 col-xs-6">
            <div class="card card-block">
              <a href="#"><img alt="" class="team-img" src="themes/hdwork/images/team-2.jpg">
              <div class="card-title-wrap">
                <span class="card-title">Sergio Fez</span> <span class="card-text">Art Director</span>
              </div>

              <div class="team-over">
                <h4 class="hidden-md-down">
                  Connect with me
                </h4>

                <nav class="social-nav">
                  <a href="#"><i class="fa fa-twitter"></i></a> <a href="#"><i class="fa fa-facebook"></i></a> <a href="#"><i class="fa fa-linkedin"></i></a> <a href="#"><i class="fa fa-envelope"></i></a>
                </nav>

                <p>
                  Lorem ipsum dolor sit amet, eu sed suas eruditi honestatis.
                </p>
              </div></a>
            </div>
          </div>

          <div class="col-sm-3 col-xs-6">
            <div class="card card-block">
              <a href="#"><img alt="" class="team-img" src="themes/hdwork/images/team-3.jpg">
              <div class="card-title-wrap">
                <span class="card-title">Sergio Fez</span> <span class="card-text">Art Director</span>
              </div>

              <div class="team-over">
                <h4 class="hidden-md-down">
                  Connect with me
                </h4>

                <nav class="social-nav">
                  <a href="#"><i class="fa fa-twitter"></i></a> <a href="#"><i class="fa fa-facebook"></i></a> <a href="#"><i class="fa fa-linkedin"></i></a> <a href="#"><i class="fa fa-envelope"></i></a>
                </nav>

                <p>
                  Lorem ipsum dolor sit amet, eu sed suas eruditi honestatis.
                </p>
              </div></a>
            </div>
          </div>

          <div class="col-sm-3 col-xs-6">
            <div class="card card-block">
              <a href="#"><img alt="" class="team-img" src="themes/hdwork/images/team-4.jpg">
              <div class="card-title-wrap">
                <span class="card-title">Sergio Fez</span> <span class="card-text">Art Director</span>
              </div>

              <div class="team-over">
                <h4 class="hidden-md-down">
                  Connect with me
                </h4>

                <nav class="social-nav">
                  <a href="#"><i class="fa fa-twitter"></i></a> <a href="#"><i class="fa fa-facebook"></i></a> <a href="#"><i class="fa fa-linkedin"></i></a> <a href="#"><i class="fa fa-envelope"></i></a>
                </nav>

                <p>
                  Lorem ipsum dolor sit amet, eu sed suas eruditi honestatis.
                </p>
              </div></a>
            </div>
          </div>
        </div>
      </div>
    </section>
    <!-- /Team -->
    <!-- @component: footer -->

    <section id="contact">
      <div class="container">
        <div class="row">
          <div class="col-md-12 text-center">
            <h2 class="section-title">Contact Us</h2>
          </div>
        </div>
        
        <div class="row">
          <div class="col-lg-3 offset-lg-2">
            <div class="info">
              <div>
                <i class="fa fa-map-marker"></i>
                <p>A108 Adam Street<br>New York, NY 535022</p>
              </div>
              
              <div>
                <i class="fa fa-envelope"></i>
                <p>info@example.com</p>
              </div>
              
              <div>
                <i class="fa fa-phone"></i>
                <p>+1 5589 55488 55s</p>
              </div>
              
            </div>
          </div>
          
          <div class="col-lg-5">
            <div class="form">
              <div id="sendmessage">Your message has been sent. Thank you!</div>
              <div id="errormessage"></div>
              <form action="" method="post" role="form" class="contactForm">
                  <div class="form-group">
                    <input type="text" name="name" class="form-control" id="name" placeholder="Your Name" data-rule="minlen:4" data-msg="Please enter at least 4 chars" />
                    <div class="validation"></div>
                  </div>
                  <div class="form-group">
                    <input type="email" class="form-control" name="email" id="email" placeholder="Your Email" data-rule="email" data-msg="Please enter a valid email" />
                    <div class="validation"></div>
                  </div>
                  <div class="form-group">
                    <input type="text" class="form-control" name="subject" id="subject" placeholder="Subject" data-rule="minlen:4" data-msg="Please enter at least 8 chars of subject" />
                    <div class="validation"></div>
                  </div>
                  <div class="form-group">
                    <textarea class="form-control" name="message" rows="5" data-rule="required" data-msg="Please write something for us" placeholder="Message"></textarea>
                    <div class="validation"></div>
                  </div>
                  <div class="text-center"><button type="submit">Send Message</button></div>
              </form>
            </div>
          </div>
          
        </div>
      </div>
    </section>
  
    <% include Footer %>
    
  </body>
</html>