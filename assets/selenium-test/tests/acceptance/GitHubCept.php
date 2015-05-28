<?php
$I = new WebGuy($scenario);
$I->wantTo('see GitHub word in title ');
$I->amOnPage('/');
$I->seeInTitle('GitHub');