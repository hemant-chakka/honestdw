<?php 

class EditProfilePage extends Page 
{
}

class EditProfilePage_Controller extends Page_Controller 
{
	private static $allowed_actions = array(
		'saveProfile',
		'submitVerification',
		'verifyAddress',
		'uploadLogo',
		'uploadPortfolio'
			
	);
	
	function init(){
		parent::init();
		Requirements::css('themes/hdwork/css/uploadfile.css');
		Requirements::javascript('themes/hdwork/javascript/jquery.uploadfile.min.js');
		Requirements::javascript('mysite/js/edit-profile.js');
		$config = SiteConfig::current_site_config();
		$googleApiKey = $config->GoogleAPIKey;
		Requirements::javascript("https://maps.googleapis.com/maps/api/js?key=$googleApiKey&libraries=places&callback=initAutocomplete");
	}

	//Save profile
	function saveProfile()
	{
		$data = $_POST;
		
		$member = Member::get()->filter(array(
				'Email' => Convert::raw2sql($data['Email'])
		))->exclude(array(
				'ID' => Member::currentUserID()
		));
		
		if($member){
			$this->setMessage('danger', 'Sorry, that Email address already exists.');
			$this->redirectBack();
		}
		
		if($data['Password']['_Password'] != $data['Password']['_ConfirmPassword']){
			$this->setMessage('danger', 'Sorry, the passwords do not match.');
			$this->redirectBack();
		}
		
		$currentMember = Member::currentUser();
		$currentMember->FirstName = $data['FirstName'];
		$currentMember->Surname = $data['Surname'];
		$currentMember->TradeUserName = $data['TradeUserName'];
		$currentMember->Email = $data['Email'];
		if($data['Password']['_Password'])
			$currentMember->changePassword($data['Password']['_Password']);
		$currentMember->PhoneNumber = $data['PhoneNumber'];
		//$currentMember->CategoriesInterested = serialize($data['CategoriesInterested']);
		$currentMember->BusinessProfile = $data['BusinessProfile'];
		$currentMember->RegionsWork= serialize($data['RegionsWork']);
		$currentMember->Certifications = $data['Certifications'];
		$currentMember->HourlyRates = $data['HourlyRates'];
		
		$currentMember->write();
		
		foreach ($data['CategoriesInterested'] as $catId){
			$catInt = CategoriesInterested::get()->filter(array(
					'MemberId' => $currentMember->ID,
					'CategoryID' => $catId
			))->first();
			if(!$catInt){
				$catInt = new CategoriesInterested();
				$catInt->MemberID = $currentMember->ID;
				$catInt->CategoryID = $catId;
				$catInt->write();
			}
			
		}
		
		$this->setMessage('success', 'Your profile has been saved!');
		return $this->redirectBack();
	}
	
	//Submit the address for verification
	public function submitVerification(){
		$data = $_POST;
		//Today
		$date = new DateTime();
		$today= $date->format('Y-m-d H:i:s');
		//Expiry date
		$date->add(new DateInterval('P2Y'));
		$expiry = $date->format('Y-m-d H:i:s');
		//Save data
		$currentMember = Member::currentUser();
		$currentMember->FirstName = $data['FirstName'];
		$currentMember->Surname = $data['Surname'];
		$currentMember->AddressLine1 = $data['AddressLine1'];
		$currentMember->AddressLine2 = $data['AddressLine2'];
		$currentMember->City = $data['City'];
		$currentMember->State = $data['State'];
		$currentMember->PostCode = $data['PostCode'];
		$currentMember->Country= $data['Country'];
		$currentMember->PhoneNumber = $data['PhoneNumber'];
		$currentMember->AVCode= mt_rand(100000,999999);
		$currentMember->AVRequestDate= $today;
		$currentMember->AVExpiryDate= $expiry;
		$currentMember->AVSubmitted= 1;
		$currentMember->write();
		//Send an email to the user and admin
		$currentMemberID = $currentMember->ID;
		$email = new Email();
		$email
		->setTo($currentMember->Email)
		->setBcc('admin@honestdayswork.nz')
		->setSubject("Address Verification: User $currentMemberID")
		->setTemplate('AddressVerificationEmail')
		->populateTemplate(new ArrayData(array(
				
		)));
		$email->send();
		$this->setMessage('success', 'Address submitted for verification,a verification code will be sent to your address.');
		return $this->redirectBack();
	}
	//Submit the address for verification
	public function verifyAddress(){
		$data = $_POST;
		$member = Member::currentUser();
		if($member->AVCode == $data['AVCode']){
			$member->AddressVerified = 1;
			$member->write();
			$this->setMessage('success', 'Address verified!');
			return $this->redirectBack();
		}
		$this->setMessage('danger', 'Address could not be verified,please try again.');
		return $this->redirectBack();
	}
	// Upload Logo
	public function uploadLogo(){
		if(isset($_FILES["myfile"]))
		{
			$ret = array();
			$member = Member::currentUser();
			$memberId = $member->ID;
			Folder::find_or_make("/Uploads/member/");
			$memberFolder = Folder::find_or_make("/Uploads/member/$memberId/");
			$memberFolderPath = $memberFolder->Filename;
			$absolutePath = Director::baseFolder()."/{$memberFolderPath}";
			
			$error =$_FILES["myfile"]["error"];
			//You need to handle  both cases
			//If Any browser does not support serializing of multiple files using FormData()
			if(!is_array($_FILES["myfile"]["name"])) //single file
			{
				$fileName = $_FILES["myfile"]["name"];
				$fileName = str_replace(' ', '-', $fileName);
				move_uploaded_file($_FILES["myfile"]["tmp_name"],$absolutePath.$fileName);
				
				Config::inst()->update('DataObject', 'validation_enabled',false);
				
				$file = new File();
				$file->ClassName = 'Image';
				$file->Name = $fileName;
				$file->Title = $fileName;
				$file->ParentID = $memberFolder->ID;
				$file->OwnerID = $memberId;
				$file->write();
				//Update Member record
				$member->LogoID = $file->ID;
				$member->write();
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
	// Upload portfolio images
	public function uploadPortfolio(){
		//$output_dir = "uploads/";
		if(isset($_FILES["myfolio"]))
		{
			$ret = array();
			$member = Member::currentUser();
			$memberId = $member->ID;
			Folder::find_or_make("/Uploads/member/");
			$memberFolder = Folder::find_or_make("/Uploads/member/$memberId/");
			$memberFolderPath = $memberFolder->Filename;
			$absolutePath = Director::baseFolder()."/{$memberFolderPath}";
			//	This is for custom errors;
			/*	$custom_error= array();
			 $custom_error['jquery-upload-file-error']="File already exists";
			 echo json_encode($custom_error);
			 die();
			 */
			$error =$_FILES["myfolio"]["error"];
			//You need to handle  both cases
			//If Any browser does not support serializing of multiple files using FormData()
			if(!is_array($_FILES["myfolio"]["name"])) //single file
			{
				$fileName = $_FILES["myfolio"]["name"];
				$fileName = str_replace(' ', '-', $fileName);
				move_uploaded_file($_FILES["myfolio"]["tmp_name"],$absolutePath.$fileName);
				// Create a file object for the original image
				$image = new Image();
				$image->ClassName = 'Image';
				$image->Name = $fileName;
				$image->Title = $fileName;
				$image->ParentID = $memberFolder->ID;
				$image->OwnerID = $memberId;
				$image->write();
				//Create the portfolio record
				$member->Portfolios()->add($image);
				$ret[]= $fileName;
			}
			else  //Multiple files, file[]
			{
				$fileCount = count($_FILES["myfolio"]["name"]);
				for($i=0; $i < $fileCount; $i++)
				{
					$fileName = $_FILES["myfolio"]["name"][$i];
					//move_uploaded_file($_FILES["myphoto"]["tmp_name"][$i],$output_dir.$fileName);
					$ret[]= $fileName;
				}
				
			}
			echo json_encode($ret);
		}
	}
}