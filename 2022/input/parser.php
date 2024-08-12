<?php

class Parser
{
    private $file;

    public function __construct($day_number)
    {
        $this->file = fopen(__DIR__ . "/$day_number.txt", "r");
    }

    public function yieldLines()
    {
      fseek($this->file, 0);
      while (!feof($this->file)) {
          yield fgets($this->file);
      }
    }

    public function yieldPart()
    {
      while (!feof($this->file)) {
        $line = fgets($this->file);
        if (trim($line) === '') {
          return;
        } else {
          yield $line;
        }
      }
    }

    public function readLine()
    {
        return fgets($this->file);
    }

    public function __destruct()
    {
        fclose($this->file);
    }
}
    
