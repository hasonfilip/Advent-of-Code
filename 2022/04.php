<?php


class Interval {
  public $start;
  public $end;

  public function __construct($rawInterval) {
    $intervals = explode('-', $rawInterval);
    $this->start = $intervals[0];
    $this->end = $intervals[1];
  }

  public function overlaps(Interval $interval) {
    return ($this->start <= $interval->end && $this->end >= $interval->start);
  }

  public function contains(Interval $interval) {
    return ($this->start <= $interval->start && $this->end >= $interval->end);
  }
}



class Solution {
  private $file;

  public function __construct($file) {
    $this->file = $file;
  }

  public function solve() {
    $result1 = 0;
    $result2 = 0;
    while (($line = fgets($this->file)) !== false) {
      $intervals = explode(',', $line);
      $firstInterval = new Interval($intervals[0]);
      $secondInterval = new Interval($intervals[1]);
      if($firstInterval->contains($secondInterval) || $secondInterval->contains($firstInterval))
        $result1++; 
      if($firstInterval->overlaps($secondInterval))
        $result2++;
    }
    print("Part 1: " . $result1 . "\n");
    print("Part 2: " . $result2 . "\n");
  }

  public function __destruct() {
    fclose($this->file);
  }
}

$solution = new Solution(fopen('input/04.txt', 'r'));
$solution->solve();
