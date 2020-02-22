<?php
class CronJob extends DataObject {
	
	private static $db = array(
			"Cron" => "Varchar(255)",
			"Params" => "Varchar(255)",
			'Status' => "Boolean"
	);
}