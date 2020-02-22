<?php

class PaymentAdmin extends ModelAdmin {
	
	private static $managed_models = array(
			'Payment'
	);
	
	private static $url_segment = 'payments';
	
	private static $menu_title = 'Payment Admin';
	
}