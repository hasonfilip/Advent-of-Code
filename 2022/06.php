<?php


class CharWindow {
  public $numberOfCharsRead = 0;
  private $charWindow = [];
  private $charWindowLength;

  public function __construct($charWindowLength) {
    $this->charWindowLength = $charWindowLength;
  }

  public function addChar($char) {
    $this->numberOfCharsRead++;
    if (count($this->charWindow) == $this->charWindowLength) {
      $this->charWindow = array_slice($this->charWindow, 1);
    }
    $this->charWindow[] = $char;
  }

  public function areCharsUnique() {
    if (count($this->charWindow) < $this->charWindowLength)
      return false;
    $uniqueChars = array_unique($this->charWindow);
    return count($this->charWindow) == count($uniqueChars);
  }

}



class Solution {
  private $input;

  public function __construct($file) {
    $this->input = fgets($file);
    fclose($file);
  }

  private function solve($charWindowLength) {
    $charWindow = new CharWindow($charWindowLength);
    for ($i = 0; !$charWindow->areCharsUnique(); $i++) {
      $charWindow->addChar($this->input[$i]);
    }
    return $charWindow->numberOfCharsRead;
  }

  public function part1() {
    return $this->solve(4);
  }

  public function part2() {
    return $this->solve(14);
  }
}


$solution = new Solution(fopen('input/06.txt', 'r'));

print("Part 1: " . $solution->part1() . "\n");
print("Part 2: " . $solution->part2() . "\n");
