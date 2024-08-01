<?php

class ThreeBest {
  public $first;
  public $second;
  public $third;

  public function __construct() {
    $this->first = 0;
    $this->second = 0;
    $this->third = 0;
  }

  public function add($value) {
    if ($value > $this->first) {
      $this->third = $this->second;
      $this->second = $this->first;
      $this->first = $value;
    } elseif ($value > $this->second) {
      $this->third = $this->second;
      $this->second = $value;
    } elseif ($value > $this->third) {
      $this->third = $value;
    }
  }
}


class Solution {
  private $file;
  private $mostCalories;

  public function __construct($file) {
    $this->file = $file;
    $this->mostCalories = new ThreeBest();
  }

  public function solve() {
    $calories = 0;

    while (($line = fgets($this->file)) !== false) {
      $trimmedLine = trim($line);
      if ($trimmedLine === '') {
        $this->mostCalories->add($calories);
        $calories = 0;
      } else {
        $calories += $trimmedLine;
      }
    }
  }

  public function part1() {
    return $this->mostCalories->first;
  }

  public function part2() {
    return $this->mostCalories->first + $this->mostCalories->second + $this->mostCalories->third;
  }

  public function __destruct() {
    fclose($this->file);
  }
}

$solution = new Solution(fopen("input/01.txt", "r"));
$solution->solve();
print("Part 1: " . $solution->part1() . "\n");
print("Part 2: " . $solution->part2() . "\n");

