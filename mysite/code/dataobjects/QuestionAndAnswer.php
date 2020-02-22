<?php
class QuestionAndAnswer extends DataObject {
	
	private static $db = array(
			'Question' => 'Text',
			'Answer' => 'Text',
			'Public' => "Boolean",
			'Status' => "Boolean"
	);
	
	private static $has_one = array(
			'Tender' => 'Tender',
			'Submission' => 'Submission',
			'Contractor' => 'Member',
			'QuestionDocument' => 'File',
			'AnswerDocument' => 'File'
			
	);
	
	private static $summary_fields = [
			'Question',
			'Status'
	];
	
	private static $searchable_fields = [
			'Question',
			'Answer',
			'Public',
			'Status',
			'TenderID',
			'ContractorID'
	];
	
	private static $field_labels = [
			'TenderID' => 'Tender',
			'ContractorID' => 'Contractor'
	];
	
}