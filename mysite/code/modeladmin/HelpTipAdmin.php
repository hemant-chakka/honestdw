<?php

class HelpTipAdmin extends ModelAdmin {
	
	private static $managed_models = array(
			'HelpTip'
	);
	
	private static $url_segment = 'help-tips';
	
	private static $menu_title = 'Help Tip Admin';
}