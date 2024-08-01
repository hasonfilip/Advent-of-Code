<?php

function extractChars($input) {
    if (preg_match('/(\S)\s*(\S)\s*/', $input, $matches)) {
        return [$matches[1], $matches[2]];
    } else {
        return [null, null];
    }
}

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
    $totalPoints = 0;
    while (($line = fgets($this->file)) !== false) {
      list($opponentChoice, $yourChoice) = extractChars($line);
      $points = 1 + ord($yourChoice) - ord('X');
      $result = ord($yourChoice) - ord($opponentChoice);
      if ($result === 24 || $result === 21) {
        // win
        $points += 6;
      } elseif ($result === 23) {
        // draw
        $points += 3;
      }
      $totalPoints += $points;
    }
    return $totalPoints;
  }

  public function part2() {
    $this->resetFilePointer();
    $totalPoints = 0;
    while (($line = fgets($this->file)) !== false) {
      list($opponentChoice, $result) = extractChars($line);
      $points = ord($opponentChoice) - ord('A');
      if ($result === 'Z') {
        // win
        $points += 1;
      } elseif ($result === 'X') {
        // loss
        $points += 2; // mod 3
      }
      $points = ($points % 3) + 1 + ((ord($result) - ord('X')) * 3);
      $totalPoints += $points;
    }
    return $totalPoints;
  }

  public function __destruct() {
    fclose($this->file);
  }
}

$solution = new Solution(fopen('input/02.txt', 'r'));
print("Part 1: " . $solution->part1() . "\n");
print("Part 2: " . $solution->part2() . "\n");
