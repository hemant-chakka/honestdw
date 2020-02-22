<?php

class TenderPage extends Page {
	
	public function getSubCategories(){
		$data = Session::get('CreateTenderForm');
		if(isset($data['ParentID']) && $data['ParentID'])
			$parentID = $data['ParentID'];
		else
			return false;
		return Category::get()->filter('ParentID', $parentID);
		
	}
	
	//Get the blank tenders if any
	public function getBlankTenderID(){
		$data = Session::get('CreateTenderForm');
		if(isset($data) && $data['ID']){
			return $data['ID'];
		}else{
			$tender = new Tender();
			$tender->ClientID = Member::currentUserID();
			$tender->Status = 'Blank';
			$tender->write();
			$data = array();
			$data['ID'] = $tender->ID;
			Session::set('CreateTenderForm',$data);
			return $tender->ID;
		}
	}
}
class TenderPage_Controller extends Page_Controller {
	
	private static $allowed_actions = array(
			'getSubCategoriesDD',
			'previewTender',
			'createTender',
			'submitTender',
			'uploadImages',
			'uploadVideos',
			'uploadAdditionalDoc',
			'deleteAdditionalDoc',
			'showPayments',
			'deleteTenderImage',
			'setCoverPhoto',
			'deleteTenderVideo',
			'deleteTenderDoc',
			'deleteTenderSubmitDoc',
			'watch',
			'unwatch',
			'archive',
			'award',
			'extendTender',
			'withdrawTender',
			'view',
			'payPendingTender',
			'payPendingSubmission',
			'revealAddress',
			'revealPhone',
			'boostTender',
			'payOutstandingAmount'
	);
	
	private static $url_handlers = array(
			
			'get-prices/$Action/$ID' => 'showPayments',
			'get-prices/$Action/$ID' => 'deleteTenderImage'
			
	);
	
	
	public function init() {
		parent::init();
		Requirements::css('themes/hdwork/css/uploadfile.css');
		Requirements::javascript('themes/hdwork/javascript/jquery.uploadfile.min.js');
		Requirements::javascript('mysite/js/create-tender.js');
		
		$count = $this->getDocsUploadedCount();
		$cost = $count;
		$data = Session::get('CreateTenderForm');
		if(isset($data)){
			//if(isset($data['ClientAdvertiseCost']) && $data['ClientAdvertiseCost'])
				//$cost = $data['ClientAdvertiseCost'];
			//if(isset($data['AdditionalInfoSelect']) && $data['AdditionalInfoSelect'])
				//$count = $data['AdditionalInfoSelect'];
				
			if(isset($data['Estimate']) && $data['Estimate'] == 'checked')
				$count++;
				
			
		}
		
		$minCloseDate = $this->minCloseDate();
		$maxCloseDate = $this->maxCloseDate();
		$today = $this->today();
		
		$imageCount = 20 - $this->getPhotosUploadedCount();
		
		$videoCount = 3 - $this->getVideosUploadedCount();
		
		$tender = Tender::get()->byID($data['ID']);
		
		if($tender){
			$sopCount = 25 - $tender->ScheduleOfPricesV2()->count();
			$specsCount = 25 - $tender->SpecificationsV2()->count();
			$drawingsCount = 25 - $tender->DrawingsV2()->count();
			$topCount = 25 - $tender->TermsOfPaymentV2()->count();
			$stdcondCount = 25 - $tender->StandardConditionsV2()->count();
			$spcondCount = 25 - $tender->SpecialConditionsV2()->count();
			$cotCount = 25 - $tender->ConditionsOfTenderingV2()->count();
		}else{
			$sopCount = 25;
			$specsCount = 25;
			$drawingsCount = 25;
			$topCount = 25;
			$stdcondCount = 25;
			$spcondCount = 25;
			$cotCount = 25;
		}
		
		Requirements::customScript(<<<JS
			
			var cost = $count;

			var count = $count;
			
			var minCloseDate = '$minCloseDate';

			var maxCloseDate = '$maxCloseDate';

			var today = '$today';

			var imageCount = $imageCount;

			var videoCount = $videoCount;

			var sopCount = $sopCount;

			var specsCount = $specsCount;

			var drawingsCount = $drawingsCount;

			var topCount = $topCount;

			var stdcondCount = $stdcondCount;
				
			var spcondCount = $spcondCount;

			var cotCount = $cotCount;

JS
				);
		$config = SiteConfig::current_site_config();
		$googleApiKey = $config->GoogleAPIKey;
		Requirements::javascript("https://maps.googleapis.com/maps/api/js?key=$googleApiKey&libraries=places&callback=initAutocomplete");
		Requirements::javascript('https://www.google.com/recaptcha/api.js');
		
	}
	//Preview tender
	public function previewTender() {
		$data = $_POST;
		
		$data['ViewOnSite'] = isset($data['ViewOnSite'])?'checked':'';
		$data['Estimate'] = isset($data['Estimate'])?'checked':'';
		//$data['ScheduleOfPrices'] = isset($data['ScheduleOfPrices'])?'checked':'';
		//$data['Specifications'] = isset($data['Specifications'])?'checked':'';
		//$data['Drawings'] = isset($data['Drawings'])?'checked':'';
		//$data['TermsOfPayment'] = isset($data['TermsOfPayment'])?'checked':'';
		//$data['StandardConditions'] = isset($data['StandardConditions'])?'checked':'';
		//$data['SpecialConditions'] = isset($data['SpecialConditions'])?'checked':'';
		//$data['ConditionsOfTendering'] = isset($data['ConditionsOfTendering'])?'checked':'';
		$data['HealthSafetyPolicyRequired'] = isset($data['HealthSafetyPolicyRequired'])?'checked':'';
		$data['TenderDocRequired'] = isset($data['TenderDocRequired'])?'checked':'';
		$data['CoverLetterRequired'] = isset($data['CoverLetterRequired'])?'checked':'';
		$data['DrawingsRequired'] = isset($data['DrawingsRequired'])?'checked':'';
		$data['OthersRequired'] = isset($data['OthersRequired'])?'checked':'';
		$data['AddressLine1Visible'] = isset($data['AddressLine1Visible'])?'checked':'';
		$data['AddressLine2Visible'] = isset($data['AddressLine2Visible'])?'checked':'';
		$data['CityVisible'] = isset($data['CityVisible'])?'checked':'';
		
		$startDate = strtotime($data['StartDateDis']);
		$data['StartDate']= date('Y-m-d H:i:s',$startDate);
		
		$endDate = strtotime($data['EndDateDis']);
		$data['EndDate']= date('Y-m-d H:i:s',$endDate);
		
		Session::set('CreateTenderForm', $data);
		if($data['g-recaptcha-response'] == ''){
			$this->setMessage('danger', "Sorry, you must submit the captcha in order to create a tender.");
			//Return back to form
			return $this->redirectBack();
		}
		
		$tender = Tender::get()->byID($data['ID']);
		$errorMsg = '';
		if(!$data['Title'])
			$errorMsg .= ($errorMsg =='')?'Title': ",Title";
		if(!$data['CategoryID'])
			$errorMsg .= ($errorMsg =='')?'Category': ",Category";
		if(!$data['Description'])
			$errorMsg .= ($errorMsg =='')?'Description': ",Description";
		
		if(!isset($data['PriceType']))
			$errorMsg .= ($errorMsg =='')?'Price Type': ",Price Type";
		
		if(!isset($data['TenderType']))
			$errorMsg .= ($errorMsg =='')?'Tender Type': ",Tender Type";
		
		if(!isset($data['AssessTenderControl']))
			$errorMsg .= ($errorMsg =='')?'Assess Tender': ",Assess Tender";
		
		if(!$data['EndDate'])
			$errorMsg .= ($errorMsg =='')?'Tender Close Date': ",Tender Close Date";
		
		if($data['Estimate'] == 'checked' && !$data['ClientEstimate'])
			$errorMsg .= ($errorMsg =='')?"Client Estimate": ",Client Estimate";
		
		if($data['OthersRequired'] == 'checked' && !$data['OthersText'])
			$errorMsg .= ($errorMsg =='')?"Others Text": ",Others Text";
		
		
		foreach ($data as $key => $value){
			if($key == 'ViewOnSite' || $key == 'Estimate' || $key == 'OthersRequired' || $key == 'HealthSafetyPolicyRequired' || $key == 'TenderDocRequired' || $key == 'CoverLetterRequired' || $key == 'DrawingsRequired' || $key == 'AddressLine1Visible' || $key == 'AddressLine2Visible' || $key == 'CityVisible')
				continue;
			if($data[$key] == 'checked'){
				$keyid = $key.'ID';
				if($tender->$keyid == 0 )
					$errorMsg .= ($errorMsg =='')?"$key upload": ",$key upload";
			}
		}
		
		
		if($errorMsg != ''){
			$this->setMessage('danger', "$errorMsg field(s) is/are required");
			return $this->redirectBack();
		}
		
		
		return $this->redirect('/preview-tender');
	}
	//Create tender - write to database
	public function createTender() {
		$data = Session::get('CreateTenderForm');
		
		$member = Member::currentUser();
		$tender = Tender::get()->byID($data['ID']);
		if($tender){
			$tender->Title = $data['Title'];
			$addressLine1 = isset($data['AddressLine1'])? $data['AddressLine1']:'';
			$addressLine2 = isset($data['AddressLine2'])? $data['AddressLine2']:'';
			$city = isset($data['City'])? $data['City']:'';
			$state = isset($data['State'])? $data['State']:'';
			$postCode = isset($data['PostCode'])? $data['PostCode']:'';
			$country = isset($data['Country'])? $data['Country']:'';
			
			$tender->Description = $data['Description'];
			$tender->AddressLine1 = $addressLine1;
			$tender->AddressLine2= $addressLine2;
			$tender->City = $city;
			$tender->State = $state;
			$tender->PostCode = $postCode;
			$tender->Country= $country;
			
			$addressStr = '';
			
			if($addressLine1){
				$addressStr .= str_replace(' ', '+', $addressLine1);
				
			}
			
			if($addressLine2){
				if($addressStr == '')	
					$addressStr .= str_replace(' ', '+', $addressLine2);
				else
					$addressStr .= '+'. str_replace(' ', '+', $addressLine2);
					
			}
			
			if($city){
				if($addressStr == '')
					$addressStr .= str_replace(' ', '+', $city);
				else
					$addressStr .= '+'. str_replace(' ', '+', $city);
						
			}
				
			if($state){
				if($addressStr == '')
					$addressStr .= str_replace(' ', '+', $state);
				else
					$addressStr .= '+'. str_replace(' ', '+', $state);
						
			}
			
			if($postCode){
				if($addressStr == '')
					$addressStr .= str_replace(' ', '+', $postCode);
				else
					$addressStr .= '+'. str_replace(' ', '+', $postCode);
						
			}
			
			if($country){
				if($addressStr == '')
					$addressStr .= str_replace(' ', '+', $country);
				else
					$addressStr .= '+'. str_replace(' ', '+', $country);
						
			}
			
			$location = $this->getLocation($addressStr);
			
			if($data['AddressLine1Visible'] == 'checked')
				$tender->AddressLine1Visible= 1;
			
			if($data['AddressLine2Visible'] == 'checked')
				$tender->AddressLine2Visible= 1;
			
			if($data['CityVisible'] == 'checked')
				$tender->CityVisible = 1;
			
			if($location){
				$tender->Latitude = $location['lat'];
				$tender->Longitude = $location['lng'];
			}
			$tender->PriceType = $data['PriceType'];
			$tender->TenderType = $data['TenderType'];
			$tender->AssessTenderControl= $data['AssessTenderControl'];
			
			if($data['ViewOnSite'] == 'checked'){
				$tender->ViewOnSite = 1;
				$tender->ViewOnSitePhone= $data['ViewOnSitePhone'];
			}
			$date = new DateTime();
			$startDate = $date->format('Y-m-d H:i:s');
			$tender->StartDate = $startDate;
			$tender->EndDate= $data['EndDate'];
			if($data['Estimate'] == 'checked')
				$tender->Estimate= 1;
			if(isset($data['ClientEstimate']))
				$tender->ClientEstimate= $data['ClientEstimate'];
			if($data['CoverLetterRequired'] == 'checked')
				$tender->CoverLetterRequired= 1;
			
			if($data['TenderDocRequired'] == 'checked')
				$tender->TenderDocRequired= 1;
			
			if($data['HealthSafetyPolicyRequired'] == 'checked')
				$tender->HealthSafetyPolicyRequired= 1;
					
			if($data['DrawingsRequired'] == 'checked')
				$tender->DrawingsRequired= 1;
						
			if($data['OthersRequired'] == 'checked'){
				$tender->OthersRequired= 1;
				$tender->OthersText= $data['OthersText'];
			}
			
			$tender->ClientAdvertiseCost = $data['ClientAdvertiseCost'];
			$tender->Status= 'Pending';
			$tender->Stage= 'Pending';
			$tender->ClientID = $member->ID;
			$tender->CategoryID = $data['CategoryID'];
			$tender->write();
			Session::clear('CreateTenderForm');
			if($data['ClientAdvertiseCost'] > 0){
				$credit = $this->creditAvailed() ? $this->creditAvailed(): 0;
				$tenderCost = $tender->getTenderAdvertiseCost();
				$newCredit = $credit + $tenderCost;
				if($newCredit < 20){
					//Pay by credit if the current balance is less than 20
					$tender->Status = 'Paid';
					$tender->Stage = 'Assess';
					$tender->write();
					// Create a payment record
					$payment = new Payment();
					$payment->TransactionRef= 'Credit';
					$payment->Method = 'Credit';
					$payment->Credit = $tenderCost;
					$payment->MemberID = $member->ID;
					$payment->TenderID = $tender->ID;
					$payment->SubmissionID = 0;
					$payment->write();
					//Register the cron
					if($tender->TenderType == 'Open'){
						$tenderId = $tender->ID;
						$cronJob = new CronJob();
						$cronJob->Cron = "NotifyContCron";
						$cronJob->Params = "$tenderId";
						$cronJob->Status = 1;
						$cronJob->write();
					}
					$this->setMessage('success', "The tender is created successfully.Current account balance is $$newCredit. Payment options are: Paypal, POLI. Payment not required until balance equals or exceeds $20.");
					return $this->redirect('/get-prices');
				}
				return $this->redirect('/get-prices/showPayments/'.$tender->ID.'?payer=client');
			}
			$tender->Status= 'Free';
			$tender->Stage= 'Assess';
			$tender->write();
			$this->setMessage('success', 'The tender is created successfully');
			return $this->redirect('/get-prices');
		}else{
			$this->setMessage('danger', 'The tender could not be created due to some reason,please try later.');
		}
		return $this->redirect('/get-prices');
	}
	
	//Delete a Tender Image
	public function deleteTenderImage(){
		
		$imageId = $this->getRequest()->param('ID');
		
		$tenderImage = TenderImage::get()->byID($imageId);
		
		$tenderImage->Image()->deleteFormattedImages();
		
		unlink($tenderImage->Image()->AbsoluteLink());
		
		$tenderImage->Image()->delete();
		
		$tenderImage->delete();
		
		return $this->redirectBack();
		
	}
	//Delete a Tender Video
	public function deleteTenderVideo(){
		
		$videoId = $this->getRequest()->param('ID');
		
		$tenderVideo = TenderVideo::get()->byID($videoId);
		
		unlink($tenderVideo->Video()->AbsoluteLink());
		
		$tenderVideo->Video()->delete();
		
		$tenderVideo->delete();
		
		return $this->redirectBack();
		
	}
	//Delete a Tender Document
	public function deleteTenderDoc(){
		
		$docId = $this->getRequest()->param('ID');
		
		$tenderId = $_GET['tenderId'];
		
		$doc = $_GET['doc'];
		
		$tender = Tender::get()->byID($tenderId);
		
		$tenderDoc = File::get()->byID($docId);
		
		$tender->$doc()->remove($tenderDoc);
		
		unlink($tenderDoc->AbsoluteLink());
		
		$tenderDoc->delete();
		
		return $this->redirectBack();
		
	}
	//Delete a Tender Submit Document
	public function deleteTenderSubmitDoc(){
		
		$docId = $this->getRequest()->param('ID');
		
		$submitId = $_GET['submitId'];
		
		$doc = $_GET['doc'];
		
		$submission = Submission::get()->byID($submitId);
		
		$submitDoc = File::get()->byID($docId);
		
		$submission->$doc()->remove($submitDoc);
		
		unlink($submitDoc->AbsoluteLink());
		
		$submitDoc->delete();
		
		return $this->redirectBack();
		
	}
	//Set as cover photo
	public function setCoverPhoto(){
		
		$imageId = $this->getRequest()->param('ID');
		
		$tenderImage = TenderImage::get()->byID($imageId);
		
		$tenderImages = TenderImage::get()->filter(array('TenderID' => $tenderImage->TenderID));
		
		foreach ($tenderImages as $tenderImg){
			$tenderImg->CoverPhoto = 0;
			$tenderImg->write();
		}
		
		$tenderImage->CoverPhoto = 1;

		$tenderImage->write();
		
		return $this->redirectBack();
		
	}
	// Get sub categories dropdown options
	public function getSubCategoriesDD(){
		$parentID = $_GET['parentID'];
		$categories = Category::get()->filter('ParentID', $parentID);
		$arrayData = new ArrayData(array(
				'Categories' => $categories
		));
		return $arrayData->renderWith('SubCategoriesDD');
	}
	
	// Upload images
	public function uploadImages(){
		//$output_dir = "uploads/";
		if(isset($_FILES["myphoto"]))
		{
			$ret = array();
			$tenderId = $_POST['TenderID'];
			$memberId = Member::currentUserID();
			$tenderFolder = Folder::find_or_make("/Uploads/tenders/$tenderId/");
			$tenderFolderPath = $tenderFolder->Filename;
			$absolutePath = Director::baseFolder()."/{$tenderFolderPath}";
			
			//	This is for custom errors;
			/*	$custom_error= array();
			 $custom_error['jquery-upload-file-error']="File already exists";
			 echo json_encode($custom_error);
			 die();
			 */
			$error =$_FILES["myphoto"]["error"];
			//You need to handle  both cases
			//If Any browser does not support serializing of multiple files using FormData()
			if(!is_array($_FILES["myphoto"]["name"])) //single file
			{
				$fileName = $_FILES["myphoto"]["name"];
				$fileName = str_replace(' ', '-', $fileName);
				$fileName = str_replace('_', '-', $fileName);
				move_uploaded_file($_FILES["myphoto"]["tmp_name"],$absolutePath.$fileName);
				// Create a file object for the original image
				$image = new File();
				$image->ClassName = 'Image';
				$image->Name = $fileName;
				$image->Title = $fileName;
				$image->ParentID = $tenderFolder->ID;
				$image->OwnerID = $memberId;
				$image->write();
				//Check if the tender is assigned a cover photo
				$tenderImageCP = TenderImage::get()->filter(array(
						'TenderID' => $tenderId,
						'CoverPhoto' => 1
				))->first();
				// Create the TenderImage record
				$tenderImage = new TenderImage();
				if(!$tenderImageCP)
					$tenderImage->CoverPhoto = 1;
				$tenderImage->TenderID = $tenderId;
				$tenderImage->ImageID = $image->ID;
				$tenderImage->write();
				$ret[]= $fileName;
			}
			else  //Multiple files, file[]
			{
				$fileCount = count($_FILES["myphoto"]["name"]);
				for($i=0; $i < $fileCount; $i++)
				{
					$fileName = $_FILES["myphoto"]["name"][$i];
					//move_uploaded_file($_FILES["myphoto"]["tmp_name"][$i],$output_dir.$fileName);
					$ret[]= $fileName;
				}
				
			}
			echo json_encode($ret);
		}
	}
	// Upload videos
	public function uploadVideos(){
		//$output_dir = "uploads/";
		if(isset($_FILES["myvideo"]))
		{
			$ret = array();
			$tenderId = $_POST['TenderID'];
			$memberId = Member::currentUserID();
			$tenderFolder = Folder::find_or_make("/Uploads/tenders/$tenderId/");
			$tenderFolderPath = $tenderFolder->Filename;
			$absolutePath = Director::baseFolder()."/{$tenderFolderPath}";
			
			//	This is for custom errors;
			/*	$custom_error= array();
			 $custom_error['jquery-upload-file-error']="File already exists";
			 echo json_encode($custom_error);
			 die();
			 */
			$error =$_FILES["myvideo"]["error"];
			//You need to handle  both cases
			//If Any browser does not support serializing of multiple files using FormData()
			if(!is_array($_FILES["myvideo"]["name"])) //single file
			{
				$fileName = $_FILES["myvideo"]["name"];
				$fileName = str_replace(' ', '-', $fileName);
				move_uploaded_file($_FILES["myvideo"]["tmp_name"],$absolutePath.$fileName);
				// Create a file object for the original image
				
				
				$video = new File();
				$video->ClassName = 'File';
				$video->Name = $fileName;
				$video->Title = $fileName;
				$video->ParentID = $tenderFolder->ID;
				$video->OwnerID = $memberId;
				$video->write();
				
				
				// Create the TenderVideo record
				$tenderVideo = new TenderVideo();
				$tenderVideo->TenderID = $tenderId;
				$tenderVideo->VideoID = $video->ID;
				$tenderVideo->write();
					
				$ret[]= $fileName;
			}
			else  //Multiple files, file[]
			{
				$fileCount = count($_FILES["myvideo"]["name"]);
				for($i=0; $i < $fileCount; $i++)
				{
					$fileName = $_FILES["myvideo"]["name"][$i];
					//move_uploaded_file($_FILES["myvideo"]["tmp_name"][$i],$output_dir.$fileName);
					$ret[]= $fileName;
				}
				
			}
			echo json_encode($ret);
		}
	}
	// Upload additional documents
	public function uploadAdditionalDoc(){
		//$output_dir = "uploads/";
		if(isset($_FILES["myfile"]))
		{
			$ret = array();
			$tenderId = $_POST['TenderID'];
			$fileId = $_POST['DocType'];
			$memberId = Member::currentUserID();
			$tenderFolder = Folder::find_or_make("/Uploads/tenders/$tenderId/");
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
				
				// add the file to the tender
				$tender = Tender::get()->byID($tenderId);
				$tender->$fileId()->add($file);
				//Update Tender record
				//$tender = Tender::get()->byID($tenderId);
				//$tender->$fileId= $file->ID;
				//$tender->write();
				Config::inst()->update('DataObject', 'validation_enabled',true);
				$ret[]= $file->ID;
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
	// Delete additional documents
	public function deleteAdditionalDoc(){
		
		if(isset($_POST["op"]) && $_POST["op"] == "delete" && isset($_POST['fileId']))
		{
			
			$docId = $_POST['fileId'];
			
			$tenderId = $_POST['tenderId'];
			
			$doc = $_POST['doc'];
			
			$tender = Tender::get()->byID($tenderId);
			
			
			$tenderDoc = File::get()->byID($docId);
			
			if($tenderDoc){
			
				$tender->$doc()->remove($tenderDoc);
			
				unlink($tenderDoc->getFullPath());
			
				$tenderDoc->delete();
			
				//echo "Deleted File".$docId;
			}
		}
	}
	//Make pending tender payment
	public function payPendingTender(){
		$tenderId = $this->getRequest()->param('ID');
		$tender = Tender::get()->byID($tenderId);
		$oldCredit = $this->creditAvailed() ? $this->creditAvailed(): 0;
		$tenderCost = $tender->getTenderAdvertiseCost();
		$credit = $oldCredit + $tenderCost;
		if($credit < 20){
			//Pay by credit if the current balance is less than 10
			$tender->Status = 'Paid';
			$tender->Stage = 'Assess';
			$tender->write();
			// Create a payment record
			$payment = new Payment();
			$payment->TransactionRef= 'Credit';
			$payment->Method = 'Credit';
			$payment->Credit = $tenderCost;
			$payment->MemberID = Member::currentUserID();
			$payment->TenderID = $tender->ID;
			$payment->SubmissionID = 0;
			$payment->write();
			$this->setMessage('success', "The tender is created successfully.Current account balance is $$credit. Payment options are: Paypal, POLI. Payment not required until balance equals or exceeds $20.");
			return $this->redirectBack();
		}
		return $this->redirect('/get-prices/showPayments/'.$tender->ID.'?payer=client');
	}
	//Make pending submisssion payment
	public function payPendingSubmission(){
		$submissionId = $this->getRequest()->param('ID');
		$submission = Submission::get()->byID($submissionId);
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
			// Create a payment record
			$payment = new Payment();
			$payment->TransactionRef= 'Credit';
			$payment->Method = 'Credit';
			$payment->Credit = $submitCost;
			$payment->MemberID = Member::currentUserID();
			$payment->TenderID = $submission->TenderID;
			$payment->SubmissionID = $submission->ID;
			$payment->write();
			$this->setMessage('success', "The tender is submitted successfully.Current account balance is $$credit. Payment options are: Paypal, POLI. Payment not required until balance equals or exceeds $20.");
			return $this->redirectBack();
		}
		return $this->redirect('/get-prices/showPayments/'.$submission->ID.'?payer=contractor');
	}
	// Show payment popup
	public function showPayments(){
		$refId = $this->getRequest()->param('ID');
		$payer = $_GET['payer'];
		if($payer == 'client'){
			$tender = Tender::get()->byID($refId);
			$title = $tender->Title;
			$amount = $tender->ClientAdvertiseCost;
			$credit = $this->creditAvailed() + $tender->getTenderAdvertiseCost();
			$refName = 'tenderId';
		}
		
		if($payer == 'contractor'){
			$submission = Submission::get()->byID($refId);
			$title = $submission->Tender()->Title;
			$amount = $submission->ContractorTenderCost;
			$credit = $this->creditAvailed() + $submission->getSubmissionCost();
			$refName = 'submitId';
		}
		
		Requirements::customScript(<<<JS

			$('#GetPayments').click();
				
JS
				);
		$data = array(
				'RefID' => $refId,
				'RefName' => $refName,
				'Payer' => $payer,
				'Title' => $title,
				'Amount' => $amount,
				'Credit' => $credit
				
		);
		return $this->customise($data)->renderWith(array('TenderPage_showPayments','Page'));
	}
	//watch a tender
	public function watch(){
		$memberId = Member::currentUserID();
		$tenderId = $this->getRequest()->param('ID');
		$tender = Tender::get()->byID($tenderId);
		if($memberId == $tender->ClientID){
			$this->setMessage('danger', 'You cannot watch your own tender.');
			return $this->redirectBack();
		}
		$watching = new Watching();
		$watching->ContractorID = $memberId;
		$watching->TenderID = $tenderId;
		$watching->write();
		return $this->redirectBack();
	}
	//unwatch a tender
	public function unwatch(){
		$memberId = Member::currentUserID();
		$tenderId = $this->getRequest()->param('ID');
		$watching = Watching::get()->filter(array(
				'ContractorID' => $memberId,
				'TenderID' => $tenderId,
				'SubmissionID' => 0
		))->first();
		if(!$watching){
			$this->setMessage('warning', 'You cannot unwatch as you have already submitted this tender.');
			return $this->redirectBack();
		}
		$watching->delete();
		return $this->redirectBack();
	}
	
	//Archive a tender submission
	public function archive(){
		$submitId = $this->getRequest()->param('ID');
		$submission = Submission::get()->byID($submitId);
		$submission->Stage = 'Archive';
		$submission->write();
		$tender = $submission->Tender();
		$tender->Stage = 'Archive';
		$tender->write();
		$this->setMessage('success', 'Tender archived successfully.');
		return $this->redirectBack();
	}
	//Award a tender submission
	public function award(){
		$submitId = $this->getRequest()->param('ID');
		$submission = Submission::get()->byID($submitId);
		$submission->Stage = 'Awarded';
		$submission->write();
		$tender = $submission->Tender();
		$tender->Stage = 'Awarded';
		$tender->write();
		//notify contractor
		$tenderTitle = $tender->Title;
		$tenderId = $tender->ID;
		$email = new Email();
		$email
		->setTo($submission->Contractor()->Email)
		->setSubject("Tender Award: $tenderTitle, $tenderId")
		->setTemplate('AwardTenderContEmail')
		->populateTemplate(new ArrayData(array(
				'Tender' => $tender
		)));
		$email->send();
		//notify client
		$email = new Email();
		$email
		->setTo($tender->Client()->Email)
		->setSubject( "Tender Award: $tenderTitle, $tenderId - Client")
		->setTemplate('AwardTenderClientEmail')
		->populateTemplate(new ArrayData(array(
				'Tender' => $tender,
				'Submission' => $submission
		)));
		$email->send();
		$this->setMessage('success', 'Tender awarded successfully.');
		return $this->redirectBack();
	}
	//Extend tender close date
	public function extendTender(){
		$data = $_POST;
		$tender = Tender::get()->byID($data['ID']);
		$oldEndDate = $tender->EndDate;
		$endDate = strtotime($data['EndDateDis']);
		$endDate = date('Y-m-d H:i:s',$endDate);
		$tender->EndDate = $endDate;
		$tender->EndDateNotify1 = 0;
		$tender->EndDateNotify2 = 0;
		$tender->write();
		$watchers = Watching::get()->filter(array(
				'TenderID' => $data['ID']
		));
		$tenderTitle = $tender->Title;
		$tenderId = $data['ID'];
		//Notify all tenderers
		foreach ($watchers as $watcher){
			$email = new Email();
			$email
			->setTo($watcher->Contractor()->Email)
			->setSubject("Tender Extended: $tenderTitle, $tenderId")
			->setTemplate('TenderExtendedEmail')
			->populateTemplate(new ArrayData(array(
					'Tender' => $tender
			)));
			$email->send();
		}
		$this->setMessage('success', 'Tender extended successfully.');
		return $this->redirectBack();
	}
	//Withdraw tender
	public function withdrawTender(){
		$data = $_POST;
		$tender = Tender::get()->byID($data['ID']);
		$tender->Stage = 'Archive';
		$tender->write();
		$tenderTitle = $tender->Title;
		$tenderId = $data['ID'];
		$watchers = Watching::get()->filter(array(
				'TenderID' => $tenderId
		));
		foreach ($watchers as $watcher){
			$email = new Email();
			$email
			->setTo($watcher->Contractor()->Email)
			->setSubject("Tender Withdrawn: $tenderTitle, $tenderId")
			->setTemplate('TenderWithdrawnEmail')
			->populateTemplate(new ArrayData(array(
					'Tender' => $tender,
			)));
			$email->send();
		}
		$this->setMessage('success', 'Tender withdrawn successfully.');
		return $this->redirectBack();
	}
	//Boost tender
	public function boostTender(){
		$data = $_POST;
		$tender = Tender::get()->byID($data['ID']);
		$member = Member::currentUser();
		$config = SiteConfig::current_site_config();
		$boostTenderCost = $config->BoostTenderCost;
		// Create a payment record
		$payment = new Payment();
		$payment->TransactionRef= 'Credit';
		$payment->Method = 'Credit';
		$payment->Credit = $boostTenderCost;
		$payment->MemberID = $member->ID;
		$payment->TenderID = $tender->ID;
		$payment->write();
		//Send an email to the client
		$tenderTitle = $tender->Title;
		$tenderId = $tender->ID;
		$email = new Email();
		$email
		->setTo($tender->Client()->Email)
		->setSubject("Tender Boosted: $tenderTitle, $tenderId")
		->setTemplate('BoostTenderEmail')
		->populateTemplate(new ArrayData(array(
				'Tender' => $tender,
		)));
		$email->send();
		//Send an email to the admin
		$tenderTitle = $tender->Title;
		$tenderId = $tender->ID;
		$email = new Email();
		$email
		->setTo('admin@honestdayswork.nz')
		->setSubject("Tender Boosted: $tenderTitle, $tenderId")
		->setTemplate('BoostTenderAdminEmail')
		->populateTemplate(new ArrayData(array(
				'Tender' => $tender,
		)));
		$email->send();
		$this->setMessage('success', 'Tender boosted successfully.');
		return $this->redirectBack();
	}
	//View a submitted tender
	public function view(){
		Requirements::css('themes/hdwork/css/uploadfile.css');
		Requirements::javascript('themes/hdwork/javascript/jquery.uploadfile.min.js');
		Requirements::javascript('mysite/js/submit-tender.js');
		$member = Member::currentUser();
		$tenderId = $this->getRequest()->param('ID');
		$tender = Tender::get()->byID($tenderId);
		$latitude = $tender->Latitude;
		$longitude = $tender->Longitude;
		//Get the submission id
		$submitId = $_GET['submitId'];
		$submission = Submission::get()->byID($submitId);
					
		$qandaId = Session::get('QaAID');
		if($qandaId){
			$qanda = QuestionAndAnswer::get()->byID($qandaId);
		}else{
			$qanda = new QuestionAndAnswer();
			$qanda->Status = 0;
			$qanda->write();
			Session::set('QaAID', $qanda->ID);
		}
		
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
		return $this->customise($data)->renderWith(array('TenderPage_submitview','Page'));
	}
	//Reveal address after a debit in the user account
	public function revealAddress(){
		$member = Member::currentUser();
		$tenderId = $this->getRequest()->param('ID');
		$reveal = Reveal::get()->filter(array(
				'ContractorID' => $member->ID,
				'TenderID' => $tenderId
		))->first();
		if(!$reveal){
			$reveal = new Reveal();
			$reveal->RevealAddress = 1;
			$reveal->ContractorID = $member->ID;
			$reveal->TenderID = $tenderId;
			$reveal->write();
		}else{
			$reveal->RevealAddress = 1;
			$reveal->write();
		}
		$config = SiteConfig::current_site_config();
		$revealAddressCost = $config->RevealAddressCost;
		// Create a payment record - credit $2.5 to the user
		$payment = new Payment();
		$payment->TransactionRef= 'Credit';
		$payment->Method = 'Credit';
		$payment->Credit = $revealAddressCost;
		$payment->MemberID = $member->ID;
		$payment->TenderID = $tenderId;
		$payment->SubmissionID = 0;
		$payment->write();
		return $this->redirectBack();
	}
	//Reveal phone after a debit in the user account
	public function revealPhone(){
		$member = Member::currentUser();
		$tenderId = $this->getRequest()->param('ID');
		$reveal = Reveal::get()->filter(array(
				'ContractorID' => $member->ID,
				'TenderID' => $tenderId
		))->first();
		if(!$reveal){
			$reveal = new Reveal();
			$reveal->RevealPhone = 1;
			$reveal->ContractorID = $member->ID;
			$reveal->TenderID = $tenderId;
			$reveal->write();
		}else{
			$reveal->RevealPhone = 1;
			$reveal->write();
		}
		$config = SiteConfig::current_site_config();
		$revealPhoneCost = $config->RevealPhoneCost;
		// Create a payment record - credit $2.5 to the user
		$payment = new Payment();
		$payment->TransactionRef= 'Credit';
		$payment->Method = 'Credit';
		$payment->Credit = $revealPhoneCost;
		$payment->MemberID = $member->ID;
		$payment->TenderID = $tenderId;
		$payment->SubmissionID = 0;
		$payment->write();
		return $this->redirectBack();
	}
	//Pay outstanding amount initiated by the user 
	public function payOutstandingAmount(){
		Requirements::customScript(<<<JS

			$('#GetPayments').click();
				
JS
				);
		
		$amount = ($_POST['SelfPayAmt'] > 100)? 100: $_POST['SelfPayAmt'];
		$data = array(
				'RefID' => Member::currentUserID(),
				'RefName' => 'memberId',
				'Payer' => 'member',
				'Credit' => $amount
				
		);
		return $this->customise($data)->renderWith(array('TenderPage_showPayments','Page'));
	}
	
	
}
