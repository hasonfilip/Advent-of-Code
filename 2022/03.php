<?php


class Solution {
  private $file;

  public function __construct($file) {
    $this->file = $file;
  }

  private function resetFilePointer() {
    fseek($this->file, 0);
  }

  private function findCommonChars($first, $second) {
    $commonChars = "";
    foreach (str_split($first) as $char) {
      if (str_contains($second, $char))
        $commonChars .= $char;
    }
    return $commonChars;
  }

  private function calculatePriority($char) {
    return ord($char) >= ord('a') ?
      ord($char) - ord('a') + 1 :
      ord($char) - ord('A') + 27;
  }

  public function part1() {
    $this->resetFilePointer();
    $result = 0;
    while(($line = fgets($this->file)) !== false) {
      $firstComparement = substr($line, 0, ceil(strlen($line)/2) - 1);
      $secondComparement = substr($line, ceil(strlen($line)/2) - 1);
      $commonChars = $this->findCommonChars($firstComparement, $secondComparement);
      if (isset($commonChars[0]))
        $result += $this->calculatePriority($commonChars[0]);
    }
    return $result;
  }

  public function part2() {
    $this->resetFilePointer();
    $result = 0;
    $group = ["", "", ""];
    $memberIndex = 0;
    while(($line = fgets($this->file)) !== false) {
      $group[$memberIndex] = $line;
      if ($memberIndex == 2) {
        $badge = $this->findCommonChars($this->findCommonChars($group[0], $group[1]), $group[2]);
        if (isset($badge[0]))
          $result += $this->calculatePriority($badge[0]);
      }
      $memberIndex = ($memberIndex + 1) % 3;
    }
    return $result;
  }

  public function __destruct() {
    fclose($this->file);
  }
}


$solution = new Solution(fopen('input/03.txt', 'r'));

print("Part 1: " . $solution->part1() . "\n");
print("Part 2: " . $solution->part2() . "\n");
