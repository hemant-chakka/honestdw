<?php
class CategoriesInterested extends DataObject {
	
	
	private static $has_one = array(
			"Member" => "Member",
			"Category" => "Category"
	);
	
}