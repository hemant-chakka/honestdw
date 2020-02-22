<section>
    <div class="container">
   		<% include PayOutstandingAmountModal %>
     </div>
</section>
<footer class="site-footer">
    <div class="bottom">
        <div class="container">
          <div class="row">
            <div class="col-lg-6 col-xs-12 text-lg-left text-center">
              <p class="copyright-text">
                &nbsp;
              </p> 
            </div>
            
            <div class="col-lg-6 col-xs-12 text-lg-right text-center">
               <ul class="list-inline">
       			<% loop $Menu(1) %>
       				<% if $CustomVisibility %>
			          <li class="list-inline-item"><a href="$Link">$MenuTitle</a></li>
			        <% end_if %>
			    <% end_loop %>
   	          </ul>
            </div>

          </div>
        </div>
      </div>
 </footer>
 
 <a class="scrolltop" href="#"><span class="fa fa-angle-up"></span></a> <!-- JavaScript

    <!-- Required JavaScript Libraries -->
    <% require javascript('themes/hdwork/lib/superfish/hoverIntent.js') %>
    <% require javascript('themes/hdwork/lib/superfish/superfish.min.js') %>
    <% require javascript('themes/hdwork/lib/tether/js/tether.min.js') %>
    
    <% require javascript('themes/hdwork/lib/stellar/stellar.min.js') %>
    <% require javascript('themes/hdwork/lib/bootstrap/js/bootstrap.min.js') %>
    <% require javascript('themes/hdwork/javascript/moment-with-locales.js') %>
    <% require javascript('themes/hdwork/javascript/bootstrap-datetimepicker.min.js') %>
    <% require javascript('themes/hdwork/lib/counterup/counterup.min.js') %>
    <% require javascript('themes/hdwork/lib/waypoints/waypoints.min.js') %>
    <% require javascript('themes/hdwork/lib/easing/easing.js') %>
    <% require javascript('themes/hdwork/lib/stickyjs/sticky.js') %>
    <% require javascript('themes/hdwork/lib/parallax/parallax.js') %>
    <% require javascript('themes/hdwork/lib/lockfixed/lockfixed.min.js') %>
    
    <!-- Template Specisifc Custom Javascript File -->
    <% require javascript('themes/hdwork/javascript/custom.js') %>
