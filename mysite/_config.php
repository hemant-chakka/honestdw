<?php

global $project;
$project = 'mysite';

global $database;
$database = 'hdwork';

// Use _ss_environment.php file for configuration
require_once("conf/ConfigureFromEnv.php");

// Set the site locale
i18n::set_locale('en_US');

// Set the default timezone
date_default_timezone_set('Pacific/Auckland');

// Extend MemberLoginForm
Object::useCustomClass('MemberLoginForm', 'CustomLoginForm');

require Director::baseFolder().DIRECTORY_SEPARATOR.'vendor'.DIRECTORY_SEPARATOR.'phpmailer'.DIRECTORY_SEPARATOR.'phpmailer'.DIRECTORY_SEPARATOR.'PHPMailerAutoload.php';
// you can specify a port as in 'yourserver.com:587'
Email::set_mailer(new SmtpMailer());

ini_set('memory_limit','500M');