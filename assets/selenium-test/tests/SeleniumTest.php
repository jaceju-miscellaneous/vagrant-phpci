<?php

class SeleniumTest extends PHPUnit_Extensions_SeleniumTestCase
{
    public static $browsers = [
      // [
      //   'name'    => 'Google Chrome on Linux',
      //   'browser' => '*googlechrome',
      // ],
      [
        'name'    => 'Firefox on Linux',
        'browser' => '*firefox',
      ],
    ];

    protected function setUp()
    {
        $this->setTimeout(180);
        $this->setBrowserUrl("https://github.com/");
    }

    public function testMyTestCase()
    {
        $this->open("/");
        $this->assertEquals("GitHub · Build software better, together.", $this->getTitle());
    }
}