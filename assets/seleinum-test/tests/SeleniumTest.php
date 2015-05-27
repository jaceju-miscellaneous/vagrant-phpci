<?php

class SeleniumTest extends PHPUnit_Extensions_SeleniumTestCase
{
    protected function setUp()
    {
        $this->setBrowser('*firefox');
        $this->setBrowserUrl("https://www.google.com.tw/");
    }

    public function testMyTestCase()
    {
        $this->open("/");
        $this->type("id=lst-ib", "Google");
        $this->click("name=btnK");
        $this->assertTrue($this->isTextPresent("Google"));
    }
}