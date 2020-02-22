<?php

class TenderAdmin extends ModelAdmin {
	
	private static $managed_models = array(
			'Tender'
	);
	
	private static $url_segment = 'tenders';
	
	private static $menu_title = 'Tender Admin';
}