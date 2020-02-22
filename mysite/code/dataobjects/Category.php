<?php
class Category extends DataObject {
	
	private static $db = array(
			'Name' => 'Varchar(100)',
			'Description' => 'Text'
	);
	
	private static $has_one = array(
			"Parent" => "Category"
	);
	
	private static $has_many = array(
			
			'SubCategories' => 'Category'
			
	);
}