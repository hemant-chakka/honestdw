<?php

class CategoryAdmin extends ModelAdmin {
	
	private static $managed_models = array(
			'Category'
	);
	
	private static $url_segment = 'category';
	
	private static $menu_title = 'Category Admin';
}