<?php
class TenderVideo extends DataObject {
	
	private static $db = array(

	);
	
	private static $has_one = array(

			'Tender' => 'Tender',
			'Video' => 'File'
			
	);
	
}