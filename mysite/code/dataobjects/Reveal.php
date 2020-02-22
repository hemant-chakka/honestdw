<?php
class Reveal extends DataObject {
	
	private static $db = array(
			'RevealAddress' => "Boolean",
			'RevealPhone' => "Boolean"
	);
	
	private static $has_one = array(
			'Contractor' => 'Member',
			'Tender' => 'Tender'
	);
	
}