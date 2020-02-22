<?php

class RegionAdmin extends ModelAdmin {
	
	private static $managed_models = array(
			'Region'
	);
	
	private static $url_segment = 'regions';
	
	private static $menu_title = 'Region Admin';
}