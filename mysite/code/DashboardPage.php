<?php

class DashboardPage extends Page {
	
	public function getSubCategories(){
		$data = Session::get('TenderSearchForm');
		if(isset($data['ParentID']) && $data['ParentID'])
			$parentID = $data['ParentID'];
		else
			return false;
		return Category::get()->filter('ParentID', $parentID);
				
	}
	
}
class DashboardPage_Controller extends Page_Controller {
	
	private static $allowed_actions = array(
	
			'doSearch'
	);
	
	public function init() {
		parent::init();
		Requirements::css('themes/hdwork/css/jquery-ui.min.css');
		Requirements::javascript('themes/hdwork/javascript/jquery-ui.min.js');
		Requirements::javascript('themes/hdwork/javascript/jquery.ui.touch-punch.min.js');
		Requirements::javascript('mysite/js/dashboard.js');
	}
	//Search Tenders
	public function doSearch(){
		if(isset($_REQUEST['Keyword'])){ 
			$data = $_REQUEST;
			Session::set('TenderSearchForm', $data);
		}else{
			$data = Session::get('TenderSearchForm');
		}
		
		$date = new DateTime();
		$today = $date->format('Y-m-d H:i:s');
		$tenders = Tender::get()->filter(array(
				'Status' => array('Paid','Free'),
				'Stage' => 'Assess',
				'TenderType' => 'Open',
				'EndDate:GreaterThan' => $today
		));
		
		if(isset($data['Keyword']) && $keyword = $data['Keyword']){
			$tenders = $tenders->filterAny(array(
					'Title:PartialMatch' => $keyword,
					'Description:PartialMatch' => $keyword,
					'AddressLine1:PartialMatch' => $keyword,
					'AddressLine2:PartialMatch' => $keyword,
					'City:PartialMatch' => $keyword,
					'State:PartialMatch' => $keyword,
					'PostCode:PartialMatch' => $keyword,
					'Country:PartialMatch' => $keyword,
					'OthersText:PartialMatch' => $keyword
			));
		}
		
		if(isset($data['Region']) && $data['Region'] && ($data['Region'] != 'All Regions')){
			if($data['Region'] == 'North Island'){
				$regionArr = array();
				$regions = Region::get()->filter(array('IsLand' => 'North'));

				foreach ($regions as $region){
					$regionArr[] = $region->Name;
				}
				
				$tenders = $tenders->filter(
						'State' , $regionArr
				);
				
			}elseif($data['Region'] == 'South Island'){
				$regionArr = array();
				$regions = Region::get()->filter(array('IsLand' => 'South'));
				
				foreach ($regions as $region){
					$regionArr[] = $region->Name;
				}
				
				$tenders = $tenders->filter(
						'State' , $regionArr
				);
			}else{
				$tenders = $tenders->filter(array(
						'State' => $data['Region']
				));
			}
		}
		
		if(isset($data['Distance']) && $distance = $data['Distance']){
			if($tenders->count() > 0){
				foreach ($tenders as $tender){
					$tenderDist = $this->getDistanceBetween($data['Latitude'], $data['Longitude'], $tender->Latitude, $tender->Longitude);	
					if($tenderDist > $distance){
						$tenders = $tenders->exclude(array(
								'ID' => $tender->ID
						));
					}
				}
			}
		}
		
		//Search Tenders by categories
		if($data['ParentID']){
			if($data['CategoryID']){
				$tenders = $tenders->filter(array(
						'CategoryID' => $data['CategoryID']
				));
			}else{
				$category = Category::get()->byID($data['ParentID']);
				
				$catArr = array();
				foreach ($category->SubCategories() as $cat){
					$catArr[] = $cat->ID;
				}
				$tenders = $tenders->filter(array(
						'CategoryID' => $catArr
				));
			}
		}
		
		$tenders = $tenders->sort('Created','DESC');
		
		
		$data = array(
				'PaginatedPages' => new PaginatedList($tenders, $this->getRequest())
		);
		
		return $this->customise($data)->renderWith(array('DashboardPage_results','Page'));
	}

	// Get distance between two locations
	public function getDistanceBetween($latitudeFrom, $longitudeFrom, $latitudeTo, $longitudeTo){
		$rad = M_PI / 180;
		//Calculate distance from latitude and longitude
		$theta = $longitudeFrom - $longitudeTo;
		$dist = sin($latitudeFrom * $rad) * sin($latitudeTo * $rad) +  cos($latitudeFrom * $rad) * cos($latitudeTo * $rad) * cos($theta * $rad);
		
		return acos($dist) / $rad * 60 *  1.852;
	}
	//Clear tender search form session
	public function ClearTenderSearchFormSession(){
		Session::clear('TenderSearchForm');
	}
	//Set the distance slider value from session
	public function SetSliderValue(){
		if($data = Session::get('TenderSearchForm')){
			if($data['Distance'])
				$distance = $data['Distance'];
			else
				$distance = 0;
			
			Requirements::customScript(<<<JS
					
				distance = $distance;
					
JS
					);
			
			
		}
	}
}
