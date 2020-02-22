<?php

class MemberAdmin extends ModelAdmin {
	
	private static $managed_models = array(
			'Member'
	);
	
	private static $url_segment = 'members';
	
	private static $menu_title = 'Member Admin';
}