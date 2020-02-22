<?php
class SimpleContentBlock extends DataObject {
	
	private static $db = array(
			'Title' => 'Varchar(100)',
			'ShowTitle'=>'Boolean',
			'Content' => 'HTMLText'
	);
	
	private static $has_one = array(
			"Page" => "Page",
			"BackgroundImage" => "Image"
	);
	
	private static $has_many = array(	
			
	);

	public function getCMSFields()
	{
		$f = new FieldList();		
			  
		$f->push(TextField::create('Title','Title/Heading'));	
		$f->push(CheckboxField::create('ShowTitle','Show title on the website?'));		
		$f->push(UploadField::create('BackgroundImage','Background Image - Upload a JPG,JPEG,or PNG file (optional)')->setFolderName('ContentBlockBackgrounds'));
		$f->push(HtmlEditorField::create('Content'));
		
		
		
		return $f;
	}
}