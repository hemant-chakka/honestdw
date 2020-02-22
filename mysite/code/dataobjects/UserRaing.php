<?php
class UserRating extends DataObject {
	
	private static $db = array(
		'Rating' => 'Int',
		'Comment' => 'Text'
	);
	
	private static $has_one = array(
			'RatedBy' => 'Member',
			'RatedFor' => 'Member',
			'Tender' => 'Tender',
			'Submission' => 'Submission'
	);
	
}