<?php
class Watching extends DataObject {
	
	private static $db = array(

	);
	
	private static $has_one = array(
			'Contractor' => 'Member',
			'Tender' => 'Tender',
			'Submission' => 'Submission'
	);
	//Generate a Question and Answer ID if tender not submitted yet 
	public function QandAID(){
		$key = $this->TenderID.'-'.'0';
		$qandaIds = Session::get('QandAIDArr');
		$qandaIds = unserialize($qandaIds);
		if($qandaIds){
			if (array_key_exists($key,$qandaIds)){
				return $qandaIds[$key];
			}else{
				$qanda = new QuestionAndAnswer();
				$qanda->Status = 0;
				$qanda->write();
				$qandaIds[$key] = $qanda->ID;
				Session::clear('QandAIDArr');
				$qandaIds = serialize($qandaIds);
				Session::set('QandAIDArr', $qandaIds);
				return $qanda->ID;
			}
		}else{
			$qandaIds = array();
			$qanda = new QuestionAndAnswer();
			$qanda->Status = 0;
			$qanda->write();
			$qandaIds[$key] = $qanda->ID;
			$qandaIds = serialize($qandaIds);
			Session::set('QandAIDArr', $qandaIds);
			return $qanda->ID;
		}
	}
	
}