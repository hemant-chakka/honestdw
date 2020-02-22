<?php 

class CustomSiteConfig extends DataExtension {

    private static $db = array(
        'PaypalEmail' => 'Varchar(100)',
    	'PaypalSandboxMode' => 'Boolean',
    	'GoogleAPIKey' => 'Varchar(255)',
    	'GoogleRecaptchaSiteKey' => 'Varchar(255)',
    	'MaxTenderCost' => 'Float(10,2)',
    	'RevealAddressCost' => 'Float(10,2)',
    	'RevealPhoneCost' => 'Float(10,2)',
    	'BoostTenderCost' => 'Float(10,2)'
    );

    public function updateCMSFields(FieldList $fields) {
        $fields->addFieldToTab("Root.Main", 
            new TextField("PaypalEmail", "Paypal Email")
        );
        $fields->addFieldToTab("Root.Main",
        	new CheckboxField('PaypalSandboxMode')
        );
        $fields->addFieldToTab("Root.Main",
        	new TextField("GoogleAPIKey", "Google API Key")
        );
        $fields->addFieldToTab("Root.Main",
        	new TextField("GoogleRecaptchaSiteKey", "Google Recaptcha Site Key")
        );
        $fields->addFieldToTab("Root.Main",
        	new TextField("MaxTenderCost", "Maximum Tender Cost")
        );
        $fields->addFieldToTab("Root.Main",
        	new TextField("RevealAddressCost", "Reveal Address Cost")
        );
        $fields->addFieldToTab("Root.Main",
        	new TextField("RevealPhoneCost", "Reveal Phone Cost")
        );
        $fields->addFieldToTab("Root.Main",
        	new TextField("BoostTenderCost", "Boost Tender Cost")
        );
    } 
}