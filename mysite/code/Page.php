<?php

class Page extends SiteTree
{
    private static $db = array(
    );

    private static $has_one = array(
    );

    private static $has_many = array (
        'SimpleContentBlocks' => 'SimpleContentBlock'
    );



    public function getCMSFields() {
        $fields = parent::getCMSFields();
        $fields->addFieldToTab('Root.ContentBlocks', GridField::create(
            'SimpleContentBlocks',
            'Content Blocks on this page',
            $this->SimpleContentBlocks(),
            GridFieldConfig_RecordEditor::create()
        ));

        return $fields;
    }


    
    //Get parent categories
    public function getCategories(){
    	return Category::get()->filter('ParentID', 0);
    }
    //Get regions
    public function getRegions(){
    	return Region::get();
    }
    //Subtract two numbers
    public function Subtract($var1,$var2){
    	
    	return $var1-$var2;
    	
    }
    //Get all questions & answers
    public function getQuestionsAndAnswers($tenderId,$contId=null,$bq=false){
    	$tender = Tender::get()->byID($tenderId);
    	if(!$tender)
    		return false;
    	$clientId = $tender->ClientID;
    	$memberId = Member::currentUserID();
    	if($bq && ($clientId == $memberId)){
    		$filter = array(
    				'TenderID' => $tenderId,
    				'Status' => 0
    		);
    		if($contId)
    			$filter['ContractorID'] = $contId;
    		$blankQuestion = QuestionAndAnswer::get()->filter($filter)->where('Question IS NULL')->first();
    			
    		if(!$blankQuestion){
    			$blankQuestion = new QuestionAndAnswer();
    			$blankQuestion->TenderID = $tenderId;
    			if($contId)
    				$blankQuestion->ContractorID= $contId;
    			$blankQuestion->write();
    		}
    	}
    	
    	if($contId == null){
    		$qas = QuestionAndAnswer::get()
    		->filter(
    				array(
    						'TenderID' => $tenderId
    				));
    		
    		if(!$bq){
    			$qas = $qas->filter(array('Status' => 1));
    		}
    		
    		$qas = $qas->sort('Created', 'DESC');
    		
    		return $qas;
    	}
    	
    	
    	$qas = QuestionAndAnswer::get()
    	->filter(
    			array(
    					'TenderID' => $tenderId
    			))->filterAny(
    					array(
    							'ContractorID' => $contId,
    							'Public' => 1
    					));
    			
    	if(!$bq){
    		$qas = $qas->filter(array('Status' => 1));
    	}
    			
    	$qas = $qas->sort('Created', 'DESC');
    	
    	return $qas;
    }
    //Custom menu visibility 
    public function CustomVisibility(){
    	return true;
    }
    
    //Get help tip
    public function HelpTip($inputName){
    	//die($inputName);
    	$helpTip = HelpTip::get()->filter(array(
    			'InputName' => $inputName
    	))->first();
    	if($helpTip)
    		return $helpTip->Tip;
    	return false;
    }
    
    
    
}
