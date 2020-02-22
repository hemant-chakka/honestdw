<?php

class CommsAdmin extends ModelAdmin {
	
	private static $managed_models = array(
			'QuestionAndAnswer'
	);
	
	private static $url_segment = 'communications';
	
	private static $menu_title = 'Communications Admin';
}