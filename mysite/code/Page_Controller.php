<?php

//use PHPMailer\PHPMailer\PHPMailer;
//use PHPMailer\PHPMailer\Exception;



class Page_Controller extends ContentController
{
    /**
     * An array of actions that can be accessed via a request. Each array element should be an action name, and the
     * permissions or conditions required to allow the user to access it.
     *
     * <code>
     * array (
     *     'action', // anyone can access this action
     *     'action' => true, // same as above
     *     'action' => 'ADMIN', // you must have ADMIN permissions to access this action
     *     'action' => '->checkAction' // you can only access this action if $this->checkAction() returns true
     * );
     * </code>
     *
     * @var array
     */
    private static $allowed_actions = array(
    		'logout',
    		'download',
    		'getAnswersModel',
    		'tenderClosing3Days',
    		'tenderClosing3Hours',
    		'view',
    		'uploadRequiredDoc',
    		'deleteRequiredDoc',
    		'uploadRequiredDoc2',
    		'uploadQandADoc',
    		'addQuestion',
    		'postAnswer',
    		'submitTender',
    		'submitTenderV2',
    		'deleteBlankRecords',
    		'migrateCatInt',
    		'notifyContOTCron',
    		'CopyOldFiles'
    );

    public function init()
    {
        parent::init();
        Requirements::javascript('themes/hdwork/lib/jquery/jquery.min.js');
        //$tender = Tender::get()->byID(268);
        //var_dump($tender->TermsOfPaymentV2()->count());
        //die();
    }
    //Get email object
    public function Email(){
    	//Include php mailer autoload 
    	require Director::baseFolder().DIRECTORY_SEPARATOR.'vendor'.DIRECTORY_SEPARATOR.'phpmailer'.DIRECTORY_SEPARATOR.'phpmailer'.DIRECTORY_SEPARATOR.'PHPMailerAutoload.php';
    	// Create PHPMailer object
    	$mail = new PHPMailer(true);                              // Passing `true` enables exceptions
  		$mail->isSMTP();                                      // Set mailer to use SMTP
   		$mail->Host = 'email-smtp.us-east-1.amazonaws.com';  // Specify main and backup SMTP servers
   		$mail->SMTPAuth = true;                               // Enable SMTP authentication
   		$mail->Username = 'AKIAIZ7TQ4CBCYQDQBZA';                 // SMTP username
   		$mail->Password = 'Ai5w+TzFm20CwzUZOniMWm9YVyJHBpqUgBMBdeqt4pLs';                           // SMTP password
   		$mail->SMTPSecure = 'tls';                            // Enable TLS encryption, `ssl` also accepted
   		$mail->Port = 587;                                    // TCP port to connect to
   		$mail->setFrom('admin@honestdayswork.nz', 'Honest Days Work');
   		$mail->isHTML(true);                                  // Set email format to HTML
		return $mail;
    }
    // Set a custom error message
    //Use these message types: success,info,warning,danger
    public function setMessage($type, $message){
    	Session::set('Message', array(
    			'MessageType' => $type,
    			'Message' => $message
    	));
    }
    // Get a custom error message
    public function getMessage(){
    	if($message = Session::get('Message')){
    		Session::clear('Message');
    		$array = new ArrayData($message);
    		return $array->renderWith('Message');
    	}
    }
    //logout
    public function logout() {
    	Security::logout(false);
    	$this->redirect("home/");
    }
    
    public function minCloseDate() {
    	$now = new DateTime(); 
    	$now->add(new DateInterval("PT48H"));
    	return $now->format('Y-m-d H:i');
    }
    
    public function maxCloseDate() {
    	$now = new DateTime();
    	$now->add(new DateInterval("P6M"));
    	return $now->format('Y-m-d H:i');
    }
    
    public function maxCloseDateDis() {
    	$now = new DateTime();
    	$now->modify('+8 week');
    	return $now->format('d F Y - h:i a');
    }
    
    public function today() {
    	$now = new DateTime();
    	return $now->format('Y-m-d H:i');
    }
    
    //Get tender form data from session
    public function getFormData(){
    	$list = new ArrayList();
    	$data = array();
    	$data = Session::get('CreateTenderForm');
    	if(isset($data))
    		$item = new ArrayData($data);
    	else
    		$item = new ArrayData(array());
    	$list->push($item);
    	return $list->first();
    			
    }
    //Get tender search form data from session
    public function getTenderSearchFormData(){
    	$list = new ArrayList();
    	$data = array();
    	$data = Session::get('TenderSearchForm');
    	if(isset($data))
    		$item = new ArrayData($data);
    	else
    		$item = new ArrayData(array());
    	$list->push($item);
    	return $list->first();
    			
    }
    //Get submit tender form data from session
    public function getSTFormData(){
    	$list = new ArrayList();
    	$data = array();
    	$data = Session::get('SubmitTenderForm');
    	if(isset($data))
    		$item = new ArrayData($data);
    	else
    		$item = new ArrayData(array());
    	$list->push($item);
    	return $list->first();
    }
    //Get Parent Category name
    public function getParentCategoryName(){
    	$data = Session::get('CreateTenderForm');
    	if(isset($data))
    		return Category::get()->byID($data['ParentID'])->Name;
    	return false;
    }
    //Get Sub Category name
    public function getCategoryName(){
    	$data = Session::get('CreateTenderForm');
    	if(isset($data))
    		return Category::get()->byID($data['CategoryID'])->Name;
    	return false;
    }
    //Get if one of the the additional info selected
    public function getAdditionalInfoSelect(){
    	$data = Session::get('CreateTenderForm');
    	if(isset($data['AdditionalInfoSelect'])){
    		 if($data['AdditionalInfoSelect'] > 0)
    		 	return true;
    	}
    	return false;
    }
    //Get if one of the the required info selected
    public function getRequiredInfoSelect(){
    	$data = Session::get('CreateTenderForm');
    	$count = 0;
    	if($data['HealthSafetyPolicyRequired'] == 'checked')
    		$count++;
    	
   		if($data['TenderDocRequired'] == 'checked')
   			$count++;
    		
		if($data['CoverLetterRequired'] == 'checked')
			$count++;
    			
		if($data['DrawingsRequired'] == 'checked')
			$count++;
  				
		if($data['OthersRequired'] == 'checked')
			$count++;
    	
		if($count > 0)
			return true;
		
		return false;
    }
    
    public function PaypalApprovalLink($tenderId){
    	$tender = Tender::get()->byID($tenderId);
    	
    	$apiContext = new \PayPal\Rest\ApiContext(
    			new \PayPal\Auth\OAuthTokenCredential(
    					'Aa3YyjwQrTyM9d9sw-XkLriJrUylb1cMJ85Bg73snnnw8WnYcBqPLbXvAPWWiToGceeOphH9zSd4mWGD',     // ClientID
    					'EO4Mo8N-d3fppmRgfSY_u8-ky3Yu1ePTiEtcbMJTyhzDbKE5fpbbqUx2j9-3ymGWrsuD3Ib6_3sYaLU5'      // ClientSecret
    					)
    	);
    	
    	$baseUrl = Director::absoluteBaseURL();
    	$payer = new Payer();
    	$payer->setPaymentMethod("paypal");
    	
    	$item1 = new Item();
    	$item1->setName($tender->Title)
    	->setCurrency('NZD')
    	->setQuantity(1)
    	->setPrice($tender->ClientAdvertiseCost);
    	
    	$itemList = new ItemList();
    	$itemList->setItems(array($item1));
    	
    	$details = new Details();
    	$details->setShipping(0)
    	->setTax(0)
    	->setSubtotal($tender->ClientAdvertiseCost);
    	
    	$amount = new Amount();
    	$amount->setCurrency("NZD")
    	->setTotal($tender->ClientAdvertiseCost)
    	->setDetails($details);
    	

    	$transaction = new Transaction();
    	$transaction->setAmount($amount)
    	->setItemList($itemList)
    	->setDescription($tender->Title)
    	->setInvoiceNumber(uniqid())
    	->setNotifyUrl("https://requestb.in/1nwcws91");
    	//->setNotifyUrl("{$baseUrl}paypal/notify?tenderId=$tenderId");
    	
    	
    	$redirectUrls = new RedirectUrls();
    	$redirectUrls->setReturnUrl("{$baseUrl}paypal/success?tenderId=$tenderId")
    	->setCancelUrl("{$baseUrl}paypal/cancelled?tenderId=$tenderId");

    	$payment = new Payment();
    	$payment->setIntent("sale")
    	->setPayer($payer)
    	->setRedirectUrls($redirectUrls)
    	->setTransactions(array($transaction));

    	$request = clone $payment;

    	try {
    		$payment->create($apiContext);
    	} catch (Exception $ex) {
    		echo $ex->getCode();echo "<br/><br/>";
    		echo $ex->getData();
    		exit(1);
    	}

    	$approvalUrl = $payment->getApprovalLink();
    	//ResultPrinter::printResult("Created Payment Using PayPal. Please visit the URL to Approve.", "Payment", "<a href='$approvalUrl' >$approvalUrl</a>", $request, $payment);
    	
    	return $approvalUrl;
    	
    }
    //Get tender photos
    public function getTenderPhotos(){
    	$data = Session::get('CreateTenderForm');
    	if(isset($data)){
    		$cols = 4;
    		$imageData = new ArrayList();
    		$tender = Tender::get()->byID($data['ID']);
    		if($tenderImages = $tender->Images()){
    			$imageCount = $tenderImages->count();
    			$rows = ceil($imageCount/$cols);
    			$totalCells = $cols * $rows;
    			$blankCells = $totalCells - $imageCount;
    			$i = 1;
    			foreach ($tenderImages as $tenderImage){
    				$first = false;
    				$last = false;
    				if($i == 1)
    					$first = true;
    					if($i == $cols)
    						$last = true;
    						if($i == $cols)
    							$i = 0;
    							$i++;
    							$item = new ArrayData(
    									array(
    											'ID' => $tenderImage->ID,
    											'TenderImage' => $tenderImage->Image(),
    											'FirstCol' => $first,
    											'LastCol' => $last,
    											'Cover' => $tenderImage->CoverPhoto
    									)
    									);
    							$imageData->push($item);
    			}
    			for($i=1;$i<=$blankCells;$i++){
    				$last = false;
    				if($i = $blankCells)
    					$last = true;
    					$item = new ArrayData(
    							array(
    									'ID' => false,
    									'TenderImage' => false,
    									'FirstCol' => false,
    									'LastCol' => $last,
    									'Cover' => false
    							)
    							);
    					
    					$imageData->push($item);
    					
    			}
    			return $imageData;
    		}
    	}
    	return false;
    }
    //Get tender videos
    public function getTenderVideos(){
    	$data = Session::get('CreateTenderForm');
    	if(isset($data)){
    		$tender = Tender::get()->byID($data['ID']);
			return $tender->Videos();
    	}
		return false;    
    }
    //Get tender doc
    public function TenderDoc($doc){
    	$data = Session::get('CreateTenderForm');
    	if(isset($data)){
    		$tender = Tender::get()->byID($data['ID']);
			if($tender->$doc()->count() > 0)
				return $tender->$doc();
    	}
    	return false;
    }
    //Get total photos uploaded count
    public function getPhotosUploadedCount(){
    	$data = Session::get('CreateTenderForm');
    	if(isset($data)){
    		$tender = Tender::get()->byID($data['ID']);
			return $tender->Images()->count();
    	}
    	return 0;
    }
    //Get total videos uploaded count
    public function getVideosUploadedCount(){
    	$data = Session::get('CreateTenderForm');
    	if(isset($data)){
    		$tender = Tender::get()->byID($data['ID']);
    		return $tender->Videos()->count();
    	}
    	return 0;
    }
    //Get total documents uploaded count
    public function getDocsUploadedCount(){
    	$data = Session::get('CreateTenderForm');
    	if(isset($data)){
    		$tender = Tender::get()->byID($data['ID']);
    		return $tender->DocsUploadedCount();
    	}
    	return 0;
    }
    
    //Get total documents uploaded count
    public function getTenderAdCost(){
    	$data = Session::get('CreateTenderForm');
    	if(isset($data)){
    		$tender = Tender::get()->byID($data['ID']);
    		$cost = $tender->DocsUploadedCount();
    		if(isset($data['Estimate']) && $data['Estimate'] == 'checked')
    			$cost++;
    		return $cost;
    	}
    	return 0;
    }
    
    //Download a file
    public function download(){
    	$fileId = $this->getRequest()->param('ID');
    	
    	$file = File::get()->byID($fileId);
    	
    	$fileData = file_get_contents(Director::absoluteBaseURL() . $file->Filename);
    	
    	return SS_HTTPRequest::send_file($fileData, $file->Name);
    }
    //Get Latitude,Longitude from address string
    public function getLocation($addressStr){
    	$ch = curl_init();
    	
    	$url = "https://maps.googleapis.com/maps/api/geocode/json?address=$addressStr&region=nz&key=AIzaSyCQ1bXR6v9EXn9TT1FASVpt17YrT4wa-GY";
    	
    	curl_setopt($ch, CURLOPT_URL, $url);
    	
    	curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
    	
    	//return the transfer as a string
    	curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    	
    	// $output contains the output string
    	$output = curl_exec($ch);
    	
    	//echo curl_error($ch);
    	
    	// close curl resource to free up system resources
    	curl_close($ch);
    	
    	
    	$output = json_decode($output,true);
    	
    	if($output['status'] == 'OK')
    		return $output['results'][0]['geometry']['location'];
    		
    	return false;
    }
    //Find if start of row
    public function StartOfRow($pos,$cols){
    	$rem = $pos % $cols;
    	if($rem == 1)
    		return true;
    	return false;
    }
    //Find if end of row
    public function EndOfRow($pos,$cols){
    	$rem = $pos % $cols;
    	if($rem == 0)
    		return true;
    	return false;
    }
    
    public function BlankCols($totalItems,$cols){
    	$rem = $totalItems % $cols;
    	if($rem > 0){
    		$list = new ArrayList();
    		for($i=0;$i<($cols-$rem);$i++){
    			$item = new ArrayData(array('Data' =>'&nbsp;'));
    			$list->push($item);
    		}
    		return $list;
    	}
    	return false;
    }
    //Notify all contractors when an open tender is submitted
    public function notifyContOT($tenderId){
    	$tender = Tender::get()->byID($tenderId);
    	$tenderTitle = $tender->Title;
    	$category = $tender->Category();

    	if($category->ParentID == 0)
    		$catId = $category->ID;
    	else
    		$catId = $category->ParentID;
    	
    	$members = Member::get()->where('CategoriesInterested IS NOT NULL');
    	$catInts = CategoriesInterested::get()->filter(array('CategoryID' => $catId));
    	
    	foreach ($catInts as $catInt){
    		$member = $catInt->Member();
    		//notify contractor
    		$email = new Email();
    		$email
    		->setTo($member->Email)
    		->setSubject(" Job for Pricing, Open Tender: $tenderTitle, $tenderId")
    		->setTemplate('JobForPricingOTEmail')
    		->populateTemplate(new ArrayData(array(
    				'Tender' => $tender
    		)));
    		$email->send();
    	}
    	/*
    	foreach ($members as $member){
    		$catInt = unserialize($member->CategoriesInterested);
    		if(in_array($catId, $catInt)){
    			//notify contractor
    			$email = new Email();
    			$email
    			->setTo($member->Email)
    			->setSubject(" Job for Pricing, Open Tender: $tenderTitle, $tenderId")
    			->setTemplate('JobForPricingOTEmail')
    			->populateTemplate(new ArrayData(array(
    					'Tender' => $tender
    			)));
    			$email->send();
    		}
    	} */
    }
    //Notify all contractors cron when an open tender is submitted
    public function notifyContOTCron(){
    	$crons = CronJob::get()->filter(array(
    			'Cron' => 'NotifyContCron',
    			'Status' => 1
    	));
    	
    	foreach ($crons as $cron){
	    	$tenderId = (int)$cron->Params;
    		$tender = Tender::get()->byID($tenderId);
    		$tenderTitle = $tender->Title;
    		$category = $tender->Category();
    	
	    	if($category->ParentID == 0)
    			$catId = $category->ID;
    		else
    			$catId = $category->ParentID;
    			
	    	$catInts = CategoriesInterested::get()->filter(array('CategoryID' => $catId));
    			
    		foreach ($catInts as $catInt){
    			$member = $catInt->Member();
    			if($member->Email){
	    			//notify contractor
    				$email = new Email();
    				$email
    				->setTo($member->Email)
    				->setSubject(" Job for Pricing, Open Tender: $tenderTitle, $tenderId")
    				->setTemplate('JobForPricingOTEmail')
    				->populateTemplate(new ArrayData(array(
    					'Tender' => $tender
    				)));
    				$email->send();
    			}
    		}
    		$cron->Status = 0;
    		$cron->write();
    	}
    }
    //Tender closing in 3 days - notify all tenderers
    public function tenderClosing3Days(){
    	$tenders = Tender::get()->where("EndDate BETWEEN NOW() AND DATE_ADD(NOW(), INTERVAL 4 DAY)")->filter(array(
    			'Status' => array('Paid','Free'),
    			'Stage' => 'Assess',
    			'EndDateNotify1' => 0 
    	));
    	foreach ($tenders as $tender){
    		$tenderTitle = $tender->Title;
    		$tenderId = $tender->ID;
    		$watchers = Watching::get()->filter(array(
    				'TenderID' => $tender->ID
    		));
    		foreach ($watchers as $watcher){
    			$email = new Email();
    			$email
    			->setTo($watcher->Contractor()->Email)
    			->setSubject("Tender Closing in 3 Days: $tenderTitle, $tenderId")
    			->setTemplate('TenderClosing3DaysEmail')
    			->populateTemplate(new ArrayData(array(
    					'Tender' => $tender
    			)));
    			$email->send();
    		}
    		$tender->EndDateNotify1 = 1;
    		$tender->write();
    	}
    	die();
    }
    //Tender closing in 3 hours - notify all tenderers
    public function tenderClosing3Hours(){
    	$tenders = Tender::get()->where("EndDate BETWEEN NOW() AND DATE_ADD(NOW(), INTERVAL 4 HOUR)")->filter(array(
    			'Status' => array('Paid','Free'),
    			'Stage' => 'Assess',
    			'EndDateNotify2' => 0
    	));
    	foreach ($tenders as $tender){
    		$tenderTitle = $tender->Title;
    		$tenderId = $tender->ID;
    		$watchers = Watching::get()->filter(array(
    				'TenderID' => $tender->ID
    		));
    		foreach ($watchers as $watcher){
    			$email = new Email();
    			$email
    			->setTo($watcher->Contractor()->Email)
    			->setSubject("Tender Closing in 3 Hours: $tenderTitle, $tenderId")
    			->setTemplate('TenderClosing3HoursEmail')
    			->populateTemplate(new ArrayData(array(
    					'Tender' => $tender
    			)));
    			$email->send();
    		}
    		$tender->EndDateNotify2 = 1;
    		$tender->write();
    	}
    	die();
    }
    //View a tender for submission
    public function view(){
    	Requirements::css('themes/hdwork/css/uploadfile.css');
    	Requirements::javascript('themes/hdwork/javascript/jquery.uploadfile.min.js');
    	Requirements::javascript('mysite/js/submit-tender.js');
    	$member = Member::currentUser();
    	$tenderId = $this->getRequest()->param('ID');
    	$tender = Tender::get()->byID($tenderId);
    	$latitude = $tender->Latitude;
    	$longitude = $tender->Longitude;
    	
    	$sopUp = 1;
    	$clUp = 1;
    	$tdUp = 1;
    	$hspUp = 1;
    	$dwUp = 1;
    	$odUp = 1;
    	
    	if($tender->ScheduleOfPricesV2()->count() > 0)
    		$sopUp = 0;
   		if($tender->CoverLetterRequired)
   			$clUp = 0;
		if($tender->TenderDocRequired)
			$tdUp = 0;
		if($tender->HealthSafetyPolicyRequired)
			$hspUp = 0;
		if($tender->DrawingsRequired)
			$dwUp = 0;
		if($tender->OthersRequired)
			$odUp = 0;
		
		if($member){
			if($tender->ClientID != $member->ID){
				$submissionID = Session::get('SubmissionID');
				if($submissionID){
					$submission = Submission::get()->byID($submissionID);
				}else{
					$submission = new Submission();
					$submission->Status = 'Blank';
					$submission->ContractorID = $member->ID;
					$submission->TenderID = $tenderId;
					$submission->ClientID = $tender->ClientID;
					$submission->write();
   					Session::set('SubmissionID', $submission->ID);
    			}
			}else{
				$submission = null;
			}
    	}else{
    		$submissionID = Session::get('SubmissionID');
    		if($submissionID){
    			$submission = Submission::get()->byID($submissionID);
    		}else{
    			$submission = new Submission();
    			$submission->Status = 'Blank';
    			$submission->TenderID = $tenderId;
    			$submission->ClientID = $tender->ClientID;
    			$submission->write();
    			Session::set('SubmissionID', $submission->ID);
    		}
    	}
    									
    	$qandaId = Session::get('QaAID');
    	if($qandaId){
    		$qanda = QuestionAndAnswer::get()->byID($qandaId);
    	}else{
    		$qanda = new QuestionAndAnswer();
    		$qanda->Status = 0;
    		$qanda->write();
    		Session::set('QaAID', $qanda->ID);
    	}
    	
    	if($submission){
	    	$sopCount = 25 - $submission->ScheduleOfPricesV2()->count();
    		$clCount = 25 - $submission->CoverLetterV2()->count();
    		$tdCount = 25 - $submission->TenderDocumentV2()->count();
	    	$hspCount = 25 - $submission->HealthSafetyPolicyV2()->count();
    		$dwCount = 25 - $submission->DrawingsV2()->count();
    		$odCount = 25 - $submission->OtherDocumentV2()->count();
    		$qtCount = 25 - $submission->QuoteV2()->count();
    		
    		if($submission->ScheduleOfPricesV2()->count() > 0)
    			$sopUp = 1;
    		
    		if($submission->CoverLetterV2()->count() > 0)
    			$clUp = 1;
    			
    		if($submission->TenderDocumentV2()->count() > 0)
    			$tdUp = 1;
    				
    		if($submission->HealthSafetyPolicyV2()->count() > 0)
    			$hspUp = 1;
    					
    		if($submission->DrawingsV2()->count() > 0)
    			$dwUp = 1;
    						
    		if($submission->OtherDocumentV2()->count() > 0)
    			$odUp = 1;
    							
    	}
    	
    	Requirements::customScript(<<<JS
    			
			var clUploaded = $clUp;
    			
			var tdUploaded = $tdUp;
    			
			var hspUploaded = $hspUp;
    			
			var dwUploaded = $dwUp;
    			
			var odUploaded = $odUp;
    			
			var sopUploaded = $sopUp;
    			
			var sopCount = $sopCount;

			var clCount = $clCount;

			var tdCount = $tdCount;

			var hspCount = $hspCount;

			var dwCount = $dwCount;

			var odCount = $odCount;

			var qtCount = $qtCount;
    			
JS
    	);
    	
    	$data = array(
    		'Tender' => $tender,
    		'Submission' => $submission,
    		'QaA' => $qanda
    	);
    	return $this->customise($data)->renderWith(array('TenderPage_view','Page'));
    }
    // Upload required documents submitting a tender
    public function uploadRequiredDoc(){
    	if(isset($_FILES["myfile"]))
    	{
    		$ret = array();
    		$submissionId = $_POST['SubmissionID'];
    		$fileId = $_POST['DocType'];
    		$memberId = Member::currentUserID();
    		$subFolder = Folder::find_or_make("/Uploads/submissions/$submissionId/");
    		$subFolderPath = $subFolder->Filename;
    		$absolutePath = Director::baseFolder()."/{$subFolderPath}";
    		
    		//	This is for custom errors;
    		/*	$custom_error= array();
    		 $custom_error['jquery-upload-file-error']="File already exists";
    		 echo json_encode($custom_error);
    		 die();
    		 */
    		$error =$_FILES["myfile"]["error"];
    		//You need to handle  both cases
    		//If Any browser does not support serializing of multiple files using FormData()
    		if(!is_array($_FILES["myfile"]["name"])) //single file
    		{
    			$fileName = $_FILES["myfile"]["name"];
    			$fileName = str_replace(' ', '-', $fileName);
    			move_uploaded_file($_FILES["myfile"]["tmp_name"],$absolutePath.$fileName);
    			// Create a file object for the original image
    			
    			Config::inst()->update('DataObject', 'validation_enabled',false);
    			
    			$file = new File();
    			$file->ClassName = 'File';
    			$file->Name = $fileName;
    			$file->Title = $fileName;
    			$file->ParentID = $subFolder->ID;
   				$file->OwnerID = $memberId;
   				$file->write();
    				
   				//Update Submission record
   				$submission = Submission::get()->byID($submissionId);
   				$submission->$fileId()->add($file);
   				Config::inst()->update('DataObject', 'validation_enabled',true);
   				$ret[]= $fileName;
    		}
    		else  //Multiple files, file[]
    		{
    			$fileCount = count($_FILES["myfile"]["name"]);
    			for($i=0; $i < $fileCount; $i++)
    			{
    				$fileName = $_FILES["myfile"]["name"][$i];
    				//move_uploaded_file($_FILES["myfile"]["tmp_name"][$i],$output_dir.$fileName);
    				$ret[]= $fileName;
    			}
    			
    		}
    		//echo json_encode($ret);
    		echo $file->ID;
    	}
    }
    // Delete required documents submitting a tender
    public function deleteRequiredDoc(){
    	if(isset($_POST["op"]) && $_POST["op"] == "delete" && isset($_POST['fileId']))
    	{
    		
    		$docId = $_POST['fileId'];
    		
    		$submitId = $_POST['submitId'];
    		
    		$doc = $_POST['doc'];
    		
    		$submission = Submission::get()->byID($submitId);
    		
    		
    		$tenderDoc = File::get()->byID($docId);
    		
    		if($tenderDoc){
    			
    			$submission->$doc()->remove($tenderDoc);
    			
    			unlink($tenderDoc->getFullPath());
    			
    			$tenderDoc->delete();
    			
    			//echo "Deleted File".$docId;
    		}
    	}
    }
    
    // Upload question & answers documents
    public function uploadQandADoc(){
    	if(isset($_FILES["myfile"]))
    	{
    		$ret = array();
    		$tenderId = $_POST['TenderID'];
    		$submissionId = $_POST['SubmissionID'];
    		$qandaId = $_POST['QaAID'];
    		$fileId = $_POST['DocType'];
    		$memberId = Member::currentUserID();
    		$tenderFolder = Folder::find_or_make("/Uploads/qanda/$submissionId/");
    		$tenderFolderPath = $tenderFolder->Filename;
    		$absolutePath = Director::baseFolder()."/{$tenderFolderPath}";
    		
    		//	This is for custom errors;
    		/*	$custom_error= array();
    		 $custom_error['jquery-upload-file-error']="File already exists";
    		 echo json_encode($custom_error);
    		 die();
    		 */
    		$error =$_FILES["myfile"]["error"];
    		//You need to handle  both cases
    		//If Any browser does not support serializing of multiple files using FormData()
    		if(!is_array($_FILES["myfile"]["name"])) //single file
    		{
    			$fileName = $_FILES["myfile"]["name"];
    			$fileName = str_replace(' ', '-', $fileName);
    			move_uploaded_file($_FILES["myfile"]["tmp_name"],$absolutePath.$fileName);
    			// Create a file object for the original image
    			
    			Config::inst()->update('DataObject', 'validation_enabled',false);
    			
    			$file = new File();
    			$file->ClassName = 'File';
    			$file->Name = $fileName;
    			$file->Title = $fileName;
    			$file->ParentID = $tenderFolder->ID;
    			$file->OwnerID = $memberId;
    			$file->write();
    			
    			//Update Tender record
    			$qanda = QuestionAndAnswer::get()->byID($qandaId);
    			$qanda->$fileId = $file->ID;
    			$qanda->write();
    			Config::inst()->update('DataObject', 'validation_enabled',true);
    			$ret[]= $fileName;
    		}
    		else  //Multiple files, file[]
    		{
    			$fileCount = count($_FILES["myfile"]["name"]);
    			for($i=0; $i < $fileCount; $i++)
    			{
    				$fileName = $_FILES["myfile"]["name"][$i];
    				//move_uploaded_file($_FILES["myfile"]["tmp_name"][$i],$output_dir.$fileName);
    				$ret[]= $fileName;
    			}
    			
    		}
    		echo json_encode($ret);
    	}
    }
    //Add/submit a question
    public function addQuestion(){
    	$data = $_POST;
    	$member = Member::currentUser();
    	$qanda = QuestionAndAnswer::get()->byID($data['QaAID']);
    	$qanda->Question = $data['Question'];
    	$qanda->TenderID = $data['TenderID'];
    	$qanda->SubmissionID = $data['SubmissionID'];
    	$qanda->ContractorID = $member->ID;
    	$qanda->Status = 1;
    	$qanda->write();
    	Session::clear('QaAID');
    	$qandaIds = Session::get('QandAIDArr');
    	if($qandaIds){
    		$qandaIds = unserialize($qandaIds);
    		$key = $data['TenderID'].'-'.$data['SubmissionID'];
    		unset($qandaIds["$key"]);
    		$qandaIds = serialize($qandaIds);
    		Session::set('QandAIDArr', $qandaIds);
    	}
    	$tender = Tender::get()->byID($data['TenderID']);
    	
    	//Send an email to the client
    	$email = new Email();
    	$email
    	->setTo($tender->Client()->Email)
    	->setSubject("A Question About Your Job")
    	->setTemplate('QuestionPostedEmail')
    	->populateTemplate(new ArrayData(array(
    			'Member' => $member,
    			'Tender' => $tender,
    			'Question' => $data['Question']
    	)));
    	$email->send();
    	return $this->redirectBack();
    }
    //Post an answer
    public function postAnswer(){
    	$data = $_POST;
    	$member = Member::currentUser();
    	$qanda = QuestionAndAnswer::get()->byID($data['ID']);
    	$qanda->Answer = $data['Answer'];
    	if($data['action'] == 'public')
    		$qanda->Public = 1;
   		$qanda->Status = 1;
   		$qanda->write();
   		if($qanda->ContractorID){
   			//Send an email to the contractor
   			$email = new Email();
   			$email
   			->setTo($qanda->Contractor()->Email)
   			->setSubject("The Answer to your Question")
   			->setTemplate('AnswerPostedEmail')
   			->populateTemplate(new ArrayData(array(
  					'Member' => $member,
   					'Tender' => $qanda->Tender(),
   					'Question' => $qanda->Question,
   					'Answer' => $data['Answer']
   			)));
   			$email->send();
   		}
   		return $this->redirectBack();
    }
    //Submit tender - write to database
    public function submitTender() {
    	$data = $_POST;
    	$data['SpecificationsRead'] = isset($data['SpecificationsRead'])?'checked':'';
    	$data['DrawingsRead'] = isset($data['DrawingsRead'])?'checked':'';
    	$data['TermsOfPaymentRead'] = isset($data['TermsOfPaymentRead'])?'checked':'';
    	$data['StandardConditionsRead'] = isset($data['StandardConditionsRead'])?'checked':'';
    	$data['SpecialConditionsRead'] = isset($data['SpecialConditionsRead'])?'checked':'';
    	$data['ConditionsOfTenderingRead'] = isset($data['ConditionsOfTenderingRead'])?'checked':'';
    	
    	Session::set('SubmitTenderForm', $data);
    	$member = Member::currentUser();
    	if(!$member){
    		$this->setMessage('warning', 'Please sign up to submit a tender.');
    		return $this->redirect('/register?submitTender=1');
    	}
    	$tender = Tender::get()->byID($data['TenderID']);
    	$submission= Submission::get()->byID($data['SubmissionID']);
    	$errorMsg = '';
    	if(!$data['PriceSubmitted'])
    		$errorMsg .= ($errorMsg =='')?'Price': ",Price";
    		
    	if($submission->QuoteV2()->count() == 0)
    		$errorMsg .= ($errorMsg =='')?'Quote upload': ",Quote upload";
   		
   		if($tender->ScheduleOfPricesV2()->count() > 0 && $submission->ScheduleOfPricesV2()->count() == 0)
   			$errorMsg .= ($errorMsg =='')?'Schedule of prices upload': ",Schedule of prices upload";
    			
   		if($tender->CoverLetterRequired && $submission->CoverLetterV2()->count() == 0)
			$errorMsg .= ($errorMsg =='')?'Cover Letter upload': ",Cover Letter upload";
    				
		if($tender->TenderDocRequired && $submission->TenderDocumentV2()->count() == 0)
			$errorMsg .= ($errorMsg =='')?'Tender Document upload': ",Tender Document upload";
    					
		if($tender->HealthSafetyPolicyRequired && $submission->HealthSafetyPolicyV2()->count() == 0)
    		$errorMsg .= ($errorMsg =='')?'Health Safety Policy upload': ",Health Safety Policy upload";
    						
    	if($tender->DrawingsRequired && $submission->DrawingsV2()->count() == 0)
			$errorMsg .= ($errorMsg =='')?'Drawings upload': ",Drawings upload";
    							
		if($tender->OthersRequired && $submission->OtherDocumentV2()->count() == 0){
			$otherDoc = $tender->OthersText;
			$errorMsg .= ($errorMsg =='')?"$otherDoc upload": ",$otherDoc upload";
		}
    							
		if($errorMsg != ''){
			$this->setMessage('danger', "$errorMsg field(s) is/are required");
			return $this->redirectBack();
		}
    							
		$submission->PriceSubmitted = $data['PriceSubmitted'];
		$submission->Clarifications = $data['Clarifications'];
    							
		if($data['SpecificationsRead'] == 'checked')
			$submission->SpecificationsRead= 1;
    								
    	if($data['DrawingsRead'] == 'checked')
    		$submission->DrawingsRead= 1;
    									
    	if($data['TermsOfPaymentRead'] == 'checked')
    		$submission->TermsOfPaymentRead= 1;
    										
    	if($data['StandardConditionsRead'] == 'checked')
    		$submission->StandardConditionsRead = 1;
    											
    	if($data['SpecialConditionsRead'] == 'checked')
    		$submission->SpecialConditionsRead = 1;
    												
		if($data['ConditionsOfTenderingRead'] == 'checked')
			$submission->ConditionsOfTenderingRead= 1;
    													
		$submission->ContractorTenderCost = $tender->SubmitPrice();
		$submission->Status= 'Pending';
		$submission->Stage= 'Pending';
		$submission->ContractorID = $member->ID;
		$submission->ClientID = $tender->ClientID;
		$submission->TenderID = $tender->ID;
		$submission->write();
		//Add the tender to watchlist if not added yet
		$watching = $tender->Watching();
		if(!$watching){
			$watching = new Watching();
			$watching->ContractorID = $member->ID;
			$watching->TenderID= $tender->ID;
			$watching->SubmissionID = $submission->ID;
			$watching->write();
		}else{
			$watching->SubmissionID = $submission->ID;
			$watching->write();
		}
		Session::clear('SubmitTenderForm');
		Session::clear('SubmissionID');
		//Get the effective submission cost		
		$submitCost = $submission->getSubmissionCost();
		//Pay by credit if the current balance is less than 20
		$oldCredit = $this->creditAvailed() ? $this->creditAvailed(): 0;
		$credit = $oldCredit + $submitCost;
		if($credit < 20){
			//Update/create database
			$submission->Status = 'Paid';
			$submission->Stage = 'Assess';
			$submission->write();
			// Create a payment record
			$payment = new Payment();
			$payment->TransactionRef= 'Credit';
			$payment->Method = 'Credit';
			$payment->Credit = $submitCost;
			$payment->MemberID = $member->ID;
			$payment->TenderID = $tender->ID;
			$payment->SubmissionID = $submission->ID;
			$payment->write();
			//notify contractor
			$email = new Email();
			$email
 			->setTo($submission->Contractor()->Email)
			->setSubject('Getting Work Priced')
			->setTemplate('TenderSubmittedEmail')
			->populateTemplate(new ArrayData(array(
				'Name' => $submission->Contractor()->Name
	 		 )));
			$email->send();
			//notify client
			$email = new Email();
			$email
			->setTo($submission->Client()->Email)
			->setSubject('Getting Work Priced')
			->setTemplate('TenderSubmittedClientEmail')
			->populateTemplate(new ArrayData(array(
					'Name' => $submission->Contractor()->Name
    		 )));
			$email->send();
			$this->setMessage('success', "The tender is submitted successfully.Current account balance is $$credit. Payment options are: Paypal, POLI. Payment not required until balance equals or exceeds $20.");
			return $this->redirectBack();
		}
		return $this->redirect('/get-prices/showPayments/'.$submission->ID.'?payer=contractor');
    }
    //Submit tender V2 - write to database
    public function submitTenderV2() {
    	$member = Member::currentUser();
		$data =   Session::get('SubmitTenderForm'); 	
    	$tender = Tender::get()->byID($data['TenderID']);
    	$submission= Submission::get()->byID($data['SubmissionID']);
    	
    	if($submission->ScheduleOfPricesV2()->count() > 0){
    		foreach ($submission->ScheduleOfPricesV2() as $sop){
    			$sop->OwnerID = $member->ID;
    			$sop->write();
    		}
    	}
    	
    	if($submission->CoverLetterV2()->count() > 0){
    		foreach ($submission->CoverLetterV2() as $cl){
    			$cl->OwnerID = $member->ID;
    			$cl->write();
    		}
    		
    	}
    	
    	if($submission->TenderDocumentV2()->count() > 0){
    		foreach ($submission->TenderDocumentV2() as $td){
    			$td->OwnerID = $member->ID;
    			$td->write();
    		}
    	}
    	
    	if($submission->HealthSafetyPolicyV2()->count() > 0){
    		foreach ($submission->HealthSafetyPolicyV2() as $hsp){
    			$hsp->OwnerID = $member->ID;
    			$hsp->write();
    		}
    	}
    	
    	if($submission->DrawingsV2()->count() > 0){
    		foreach ($submission->DrawingsV2() as $dw){
    			$dw->OwnerID = $member->ID;
    			$dw->write();
    		}
    	}
    	
    	if($submission->OtherDocumentV2()->count() > 0){
    		foreach ($submission->OtherDocumentV2() as $od){
    			$od->OwnerID = $member->ID;
    			$od->write();
    		}
    	}
    	
    	if($submission->QuoteV2()->count() > 0){
    		foreach ($submission->QuoteV2() as $quote){
    			$quote->OwnerID = $member->ID;
    			$quote->write();
    		}
    	}
    	
    	$errorMsg = '';
    	if(!$data['PriceSubmitted'])
    		$errorMsg .= ($errorMsg =='')?'Price': ",Price";
    		
    	if($submission->QuoteV2()->count() == 0)
    		$errorMsg .= ($errorMsg =='')?'Quote upload': ",Quote upload";
   		
   		if($tender->ScheduleOfPricesV2()->count() > 0 && $submission->ScheduleOfPricesV2()->count() == 0)
			$errorMsg .= ($errorMsg =='')?'Schedule of prices upload': ",Schedule of prices upload";
    			
		if($tender->CoverLetterRequired && $submission->CoverLetterV2()->count() == 0)
    		$errorMsg .= ($errorMsg =='')?'Cover Letter upload': ",Cover Letter upload";
    				
    	if($tender->TenderDocRequired && $submission->TenderDocumentV2()->count() == 0)
			$errorMsg .= ($errorMsg =='')?'Tender Document upload': ",Tender Document upload";
    					
		if($tender->HealthSafetyPolicyRequired && $submission->HealthSafetyPolicyV2()->count() == 0)
			$errorMsg .= ($errorMsg =='')?'Health Safety Policy upload': ",Health Safety Policy upload";
    						
		if($tender->DrawingsRequired && $submission->DrawingsV2()->count() == 0)
			$errorMsg .= ($errorMsg =='')?'Drawings upload': ",Drawings upload";
    							
		if($tender->OthersRequired && $submission->OtherDocumentV2()->count() == 0){
			$otherDoc = $tender->OthersText;
			$errorMsg .= ($errorMsg =='')?"$otherDoc upload": ",$otherDoc upload";
		}
    							
		if($errorMsg != ''){
			$this->setMessage('danger', "$errorMsg field(s) is/are required");
			return $this->redirect('/tender/view/'.$data['TenderID']);
		}
    							
		$submission->PriceSubmitted = $data['PriceSubmitted'];
		$submission->Clarifications = $data['Clarifications'];
    							
		if($data['SpecificationsRead'] == 'checked')
			$submission->SpecificationsRead= 1;
    								
		if($data['DrawingsRead'] == 'checked')
			$submission->DrawingsRead= 1;
    									
		if($data['TermsOfPaymentRead'] == 'checked')
			$submission->TermsOfPaymentRead= 1;
    										
		if($data['StandardConditionsRead'] == 'checked')
			$submission->StandardConditionsRead = 1;
    											
		if($data['SpecialConditionsRead'] == 'checked')
			$submission->SpecialConditionsRead = 1;
    												
		if($data['ConditionsOfTenderingRead'] == 'checked')
			$submission->ConditionsOfTenderingRead= 1;
    													
		$submission->ContractorTenderCost= $tender->SubmitPrice();
		$submission->Status= 'Pending';
		$submission->Stage= 'Pending';
		$submission->ContractorID = $member->ID;
		$submission->ClientID = $tender->ClientID;
		$submission->TenderID = $tender->ID;
		$submission->write();
		//Add the tender to watchlist if not added yet
		$watching = $tender->Watching();
		if(!$watching){
			$watching = new Watching();
			$watching->ContractorID = $member->ID;
			$watching->TenderID= $tender->ID;
			$watching->SubmissionID = $submission->ID;
			$watching->write();
		}else{
			$watching->SubmissionID = $submission->ID;
			$watching->write();
		}
		Session::clear('SubmitTenderForm');
		Session::clear('SubmissionID');
		//Get the effective submission cost
		$config = SiteConfig::current_site_config();
		$maxTenderCost = $config->MaxTenderCost;
		$submitCost = ($tender->SubmitPrice() > $maxTenderCost)? $maxTenderCost:$tender->SubmitPrice();
		//Get the effective submission cost
		$submitCost = $submission->getSubmissionCost();
		//Pay by credit if the current balance is less than 20
		$oldCredit = $this->creditAvailed() ? $this->creditAvailed(): 0;
		$credit = $oldCredit + $submitCost;
		if($credit < 20){
			//Update/create database
			$submission->Status = 'Paid';
			$submission->Stage = 'Assess';
			$submission->write();
			// Create a payment record
			$payment = new Payment();
			$payment->TransactionRef= 'Credit';
			$payment->Method = 'Credit';
			$payment->Credit = $submitCost;
			$payment->MemberID = $member->ID;
			$payment->TenderID = $tender->ID;
			$payment->SubmissionID = $submission->ID;
			$payment->write();
			//notify contractor
			$email = new Email();
			$email
			->setTo($submission->Contractor()->Email)
			->setSubject('Getting Work Priced')
			->setTemplate('TenderSubmittedEmail')
			->populateTemplate(new ArrayData(array(
					'Name' => $submission->Contractor()->Name
			)));
			$email->send();
			//notify client
			$email = new Email();
			$email
			->setTo($submission->Client()->Email)
			->setSubject('Getting Work Priced')
			->setTemplate('TenderSubmittedClientEmail')
			->populateTemplate(new ArrayData(array(
					'Name' => $submission->Contractor()->Name
			)));
			$email->send();
			$this->setMessage('success', "The tender is submitted successfully.Current account balance is $$credit. Payment options are: Paypal, POLI. Payment not required until balance equals or exceeds $20.");
			return $this->redirectBack();
		}
		return $this->redirect('/get-prices/showPayments/'.$submission->ID.'?payer=contractor');
    }
    //Delete all blank Tenders and Submissions
    public function deleteBlankRecords(){
    	DB::query("DELETE FROM Tender where Status='Blank'");
    	DB::query("DELETE FROM Submission where Status='Blank'");
    	die();
    }
    //Get the credit availed
    public function creditAvailed(){
		$memberId = Member::currentUserID();
		return  DB::query("SELECT SUM(Credit) FROM Payment where MemberID = $memberId")->value();
    }
    //Get the current user region
    public function getCurrentUserLocation(){
	    $PubIP = $this->get_client_ip();
    	$json  = file_get_contents("https://freegeoip.net/json/$PubIP");
    	$json  =  json_decode($json ,true);
    	//$country =  $json['country_name'];
    	//$region= $json['region_name'];
    	//$city = $json['city'];
    	return  $json;
    }
    //Get the current user ip
    public function get_client_ip(){
    	$ipaddress = '';
    	if (isset($_SERVER['HTTP_CLIENT_IP']))
    		$ipaddress = $_SERVER['HTTP_CLIENT_IP'];
   		else if(isset($_SERVER['HTTP_X_FORWARDED_FOR']))
  			$ipaddress = $_SERVER['HTTP_X_FORWARDED_FOR'];
		else if(isset($_SERVER['HTTP_X_FORWARDED']))
			$ipaddress = $_SERVER['HTTP_X_FORWARDED'];
		else if(isset($_SERVER['HTTP_FORWARDED_FOR']))
			$ipaddress = $_SERVER['HTTP_FORWARDED_FOR'];
		else if(isset($_SERVER['HTTP_FORWARDED']))
    		$ipaddress = $_SERVER['HTTP_FORWARDED'];
    	else if(isset($_SERVER['REMOTE_ADDR']))
    		$ipaddress = $_SERVER['REMOTE_ADDR'];
    	else
    		$ipaddress = 'UNKNOWN';
    	return $ipaddress;
    }
    
    public function migrateCatInt(){
    	$members = Member::get()->where('CategoriesInterested IS NOT NULL');
    	foreach($members as $member){
    		$categories = unserialize($member->CategoriesInterested);
    		if(!empty($categories)){
	    		foreach ($categories as $categoryId){
    				$catInt = new CategoriesInterested();
    				$catInt->MemberID = $member->ID;
    				$catInt->CategoryID = $categoryId;
    				$catInt->write();
    			}
    		}
    	}
    }
    
    public function CopyOldFiles(){
    	
    	// Move all tender documents
    	
    	die("already moved");
    	
    	$tenders = Tender::get()->exclude(array(
    			'ScheduleOfPricesID' => 0
    	));
    	
		$tenSopCount = 0;
    	foreach ($tenders as $tender){
    		$tender->ScheduleOfPricesV2()->add($tender->ScheduleOfPrices());
    		$tenSopCount++;
    	}
    	
    	$tenders = Tender::get()->exclude(array(
    			'SpecificationsID' => 0
    	));
    	
    	$tenSpecCount = 0;
    	
    	foreach ($tenders as $tender){
    		$tender->SpecificationsV2()->add($tender->Specifications());
    		$tenSpecCount++;
    	}
    	
    	$tenders = Tender::get()->exclude(array(
    			'DrawingsID' => 0
    	));
    	
    	$tenDrawCount = 0;
    	
    	foreach ($tenders as $tender){
    		$tender->DrawingsV2()->add($tender->Drawings());
    		$tenDrawCount++;
    	}
    	
    	$tenders = Tender::get()->exclude(array(
    			'TermsOfPaymentID' => 0
    	));
    	
    	$tenTopCount = 0;
    	
    	foreach ($tenders as $tender){
    		$tender->TermsOfPaymentV2()->add($tender->TermsOfPayment());
    		$tenTopCount++;
    	}
    	
    	$tenders = Tender::get()->exclude(array(
    			'StandardConditionsID' => 0
    	));
    	
    	$tenStdconCount = 0;
    	
    	foreach ($tenders as $tender){
    		$tender->StandardConditionsV2()->add($tender->StandardConditions());
    		$tenStdconCount++;
    	}
    	
    	$tenders = Tender::get()->exclude(array(
    			'SpecialConditionsID' => 0
    	));
    	
    	$tenSpecialCount = 0;
    	
    	foreach ($tenders as $tender){
    		$tender->SpecialConditionsV2()->add($tender->SpecialConditions());
    		$tenSpecialCount++;
    	}
    	
    	$tenders = Tender::get()->exclude(array(
    			'ConditionsOfTenderingID' => 0
    	));
    	
    	$tenCotCount = 0;
    	
    	foreach ($tenders as $tender){
    		$tender->ConditionsOfTenderingV2()->add($tender->ConditionsOfTendering());
    		$tenCotCount++;
    	}
    	
		// Move all submissions documents
    	
    	$submissions = Submission::get()->exclude(array(
    			'ScheduleOfPricesID' => 0
    	));
    	
    	$subSopCount = 0;
    	
    	foreach ($submissions as $submission){
    		$submission->ScheduleOfPricesV2()->add($submission->ScheduleOfPrices());
    		$subSopCount++;
    	}
    	
    	$submissions = Submission::get()->exclude(array(
    			'CoverLetterID' => 0
    	));
    	
    	$subClCount = 0;
    	
    	foreach ($submissions as $submission){
    		$submission->CoverLetterV2()->add($submission->CoverLetter());
    		$subClCount++;
    	}
    	
    	$submissions = Submission::get()->exclude(array(
    			'TenderDocumentID' => 0
    	));
    	
    	$subTdCount = 0;

    	foreach ($submissions as $submission){
    		$submission->TenderDocumentV2()->add($submission->TenderDocument());
    		$subTdCount++;
    	}
    	
    	$submissions = Submission::get()->exclude(array(
    			'HealthSafetyPolicyID' => 0
    	));
    	
    	$subHspCount = 0;
    	
    	foreach ($submissions as $submission){
    		$submission->HealthSafetyPolicyV2()->add($submission->HealthSafetyPolicy());
    		$subHspCount++;
    	}
    	
    	$submissions = Submission::get()->exclude(array(
    			'DrawingsID' => 0
    	));
    	
    	$subDwCount = 0;
    	
    	foreach ($submissions as $submission){
    		$submission->DrawingsV2()->add($submission->Drawings());
    		$subDwCount++;
    	}
    	
    	$submissions = Submission::get()->exclude(array(
    			'OtherDocumentID' => 0
    	));
    	
    	$subOdCount = 0;
    	
    	foreach ($submissions as $submission){
    		$submission->OtherDocumentV2()->add($submission->OtherDocument());
    		$subOdCount++;
    	}
    	
    	$submissions = Submission::get()->exclude(array(
    			'QuoteID' => 0
    	));
    	
    	$subQtCount = 0;
    	
    	foreach ($submissions as $submission){
    		$submission->QuoteV2()->add($submission->Quote());
    		$subQtCount++;
    	}
    	
    	echo "Moving old documents completed";
    	
    	?>
    	<table>
  			<tr><td>Tenders </td><td>&nbsp;</td></tr>
  			<tr><td>Tender-ScheduleOfPrices: </td><td><?php echo $tenSopCount;?></td></tr>
  			<tr><td>Tender-Specifications: </td><td><?php echo $tenSpecCount;?></td></tr>
  			<tr><td>Tender-Drawings: </td><td><?php echo $tenDrawCount;?></td></tr>
  			<tr><td>Tender-TermsOfPayment: </td><td><?php echo $tenTopCount;?></td></tr>
  			<tr><td>Tender-StandardConditions: </td><td><?php echo $tenStdconCount;?></td></tr>
  			<tr><td>Tender-SpecialConditions: </td><td><?php echo $tenSpecialCount;?></td></tr>
  			<tr><td>Tender-ConditionsOfTendering: </td><td><?php echo $tenCotCount;?></td></tr>
  			<tr><td>Submissions </td><td>&nbsp;</td></tr>
  			<tr><td>ScheduleOfPrices </td><td><?php echo $subSopCount;?></td></tr>
  			<tr><td>CoverLetter</td><td><?php echo $subClCount;?></td></tr>
  			<tr><td>TenderDocument </td><td><?php echo $subTdCount;?></td></tr>
  			<tr><td>HealthSafetyPolicy</td><td><?php echo $subHspCount;?></td></tr>
  			<tr><td>Drawings</td><td><?php echo $subDwCount;?></td></tr>
  			<tr><td>OtherDocument</td><td><?php echo $subOdCount;?></td></tr>
  			<tr><td>Quote</td><td><?php echo $subQtCount;?></td></tr>
		</table>
    	
<?php     	
    	
    }
}
