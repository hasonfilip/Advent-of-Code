<?php
require_once('input/parser.php');


class CPU {
  private $X = 1;
  private $cycles = 0;
  public $signal = 0;
  private $row = "";
  private $image = "";
  
  private function calculateSignal() {
    if (($this->cycles - 20) % 40 == 0) {
      $this->signal += $this->X * $this->cycles;
    }
  }

  public function tick() {
    $this->cycles++;
    $this->calculateSignal();
    $this->addPixel();
  }

  public function addx($value) {
    $this->X += $value;
  }

  private function addPixel() {
    $this->row .= abs($this->X - (($this->cycles - 1) % 40)) < 2 ? "#" : ".";
    if (strlen($this->row) == 40) {
      $this->image .= "\t" . $this->row . "\n";
      $this->row = "";
    }
  }

  public function renderImage() {
    print("\n\n");
    print($this->image);
    print("\n\n");
  }
}

class Solution {
  private $parser;
  private $cpu;

  public function __construct($day) {
    $this->cpu = new CPU();
    $this->parser = new Parser($day);
    foreach ($this->parser->yieldLines() as $line) {
      $instruction = explode(" ", trim($line));
      if ($instruction[0] == "noop") {
        $this->cpu->tick();
      } else if ($instruction[0] == "addx") {
        $this->cpu->tick();
        $this->cpu->tick();
        $this->cpu->addx($instruction[1]);
      }
    }
  }

  public function part1() {
    return $this->cpu->signal;
  }

  public function part2() {
    $this->cpu->renderImage();
  }
}


$solution = new Solution("10");

print("Part 1: "  . $solution->part1() . "\n");
print("Part 2:\n"); $solution->part2();

