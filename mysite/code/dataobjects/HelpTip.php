<?php
class HelpTip extends DataObject {
	
	private static $db = array(
		'InputName' => 'Varchar(100)',
		'Description' => 'Text',
		'Tip' => 'Text'
	);
	
	private static $summary_fields = [
			'InputName',
			'Tip'
	];
	
	
	
}