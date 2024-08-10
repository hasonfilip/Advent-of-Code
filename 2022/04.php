<?php


class Solution {
  private $file;

  public function __construct($file) {
    $this->file = $file;
  }

  private function resetFilePointer() {
    fseek($this->file, 0);
  }

  public function part1() {
    $this->resetFilePointer();
    $result = 0;
    while (($line = fgets($this->file)) !== false) {
      $intervals = explode(',', $line);
      $firstInterval = explode('-', $intervals[0]);
      $secondInterval = explode('-', $intervals[1]);
      if(($firstInterval[0] <= $secondInterval[0] && $firstInterval[1] >= $secondInterval[1]) ||
        ($firstInterval[0] >= $secondInterval[0] && $firstInterval[1] <= $secondInterval[1])) {
        $result++;
      }
    }
    return $result;
  }

  public function part2() {
    $this->resetFilePointer();
    $result = 0;
    while (($line = fgets($this->file)) !== false) {
      $intervals = explode(',', $line);
      $firstInterval = explode('-', $intervals[0]);
      $secondInterval = explode('-', $intervals[1]);
      if($firstInterval[0] <= $secondInterval[1] && $firstInterval[1] >= $secondInterval[0] ||
        $firstInterval[1] <= $secondInterval[0] && $firstInterval[0] >= $secondInterval[1]) {
        $result++;
      }
    }

    return $result;
  }

  public function __destruct() {
    fclose($this->file);
  }
}


$solution = new Solution(fopen('input/04.txt', 'r'));

print("Part 1: " . $solution->part1() . "\n");
print("Part 2: " . $solution->part2() . "\n");
