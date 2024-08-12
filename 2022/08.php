<?php
require_once('input/parser.php');



class TreeMap {
  private $map;
  private $visibilityMap;
  private $scenicScoreMap;

  public function __construct() {
    $parser = new Parser("08");
    $input = $parser->readAll();
    $this->map = array_map('str_split', explode("\n", trim($input)));
    $this->visibilityMap = array_map(function($row) {
      return array_fill(0, count($row), " ");
    }, $this->map);
    $this->scenicScoreMap = array_map(function($row) {
      return array_fill(0, count($row), 1);
    }, $this->map);
  }

  private function printMap($map) {
    foreach ($map as $row) {
      print(implode("", $row) . "\n");
    }
    print("\n");
  }

  private function rotate() {
    $this->map = array_map(null, ...array_reverse($this->map));
    $this->visibilityMap = array_map(null, ...array_reverse($this->visibilityMap));
    $this->scenicScoreMap = array_map(null, ...array_reverse($this->scenicScoreMap));
  }

  private function fillVisibilityMap() {
    for ($_ = 0; $_ < 4; $_++) {
      foreach ($this->map as $rowIndex => $row) {
        $highestTree = -1;
        foreach ($row as $treeIndex => $tree) {
          if ($tree > $highestTree) {
            $highestTree = $tree;
            $this->visibilityMap[$rowIndex][$treeIndex] = "+";
          }
        } 
      }
      $this->rotate();
    }
  }

  public function countVisibleTrees() {
    $this->fillVisibilityMap();
    $result = 0;
    foreach ($this->visibilityMap as $row) {
      foreach ($row as $visible) {
        if ($visible === "+") {
          $result++;
        }
      }
    }
    return $result;
  }

  private function fillScenicScoreMap() {
    for ($_ = 0; $_ < 4; $_++) {
      foreach ($this->map as $rowIndex => $row) {
        foreach ($row as $treeIndex => $tree) {
          $visibleTrees = 1;
          while ($treeIndex + $visibleTrees < count($row)) {
            if ($row[$treeIndex + $visibleTrees++] >= $tree) {
              break;
            }
          }
          $this->scenicScoreMap[$rowIndex][$treeIndex] *= ($visibleTrees - 1);
        } 
      }
      $this->rotate();
    }
  }

  public function findBestScenicScore() {
    $this->fillScenicScoreMap();
    $result = 0;
    foreach ($this->scenicScoreMap as $row) {
      foreach ($row as $score) {
        if ($score > $result) {
          $result = $score;
        }
      }
    }
    return $result;
  }
}



class Solution {
  private $treeMap;

  public function __construct() {
    $this->treeMap = new TreeMap();
  }

  public function part1() {
    return $this->treeMap->countVisibleTrees();
  }

  public function part2() {
    return $this->treeMap->findBestScenicScore();
  }
}


$solution = new Solution();

print("Part 1: " . $solution->part1() . "\n");
print("Part 2: " . $solution->part2() . "\n");
