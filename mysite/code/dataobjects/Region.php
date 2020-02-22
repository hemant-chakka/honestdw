<?php
class Region extends DataObject {
	
	private static $db = array(

			'Name' => 'Varchar(150)',
			'IsLand' => 'Enum(array("North","South","All"))'
	);
	
}