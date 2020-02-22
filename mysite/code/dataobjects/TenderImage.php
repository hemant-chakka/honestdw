<?php
class TenderImage extends DataObject {
	
	private static $db = array(

			'CoverPhoto' => 'Boolean'
			
	);
	
	private static $has_one = array(

			'Tender' => 'Tender',
			'Image' => 'Image'
			
	);
	//To find if a tender has cover photo
	public function HasCoverPhoto(){
		return TenderImage::get()->filter(array(
				'TenderID' => $this->TenderID,
				'CoverPhoto' => 1
		))->first();
	}
	
}