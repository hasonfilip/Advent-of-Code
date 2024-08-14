<?php
require_once('input/parser.php');


class Position {
  public $visited = false;
  public $elevation;
  public $symbol;

  public function __construct($char) {
    $this->symbol = $char;
    switch ($char) {
      case 'S':
        $this->elevation = 0;
        break;
      case 'E':
        $this->elevation = ord('z') - ord('a') + 2;
        break;
      default:
        $this->elevation = ord($char) - ord('a') + 1;
        break;
    }
  }
}

class heightMap {
  private $map = [];
  private $width;
  private $height;
  private $currentPositions = [];

  public function __construct($lines) {
    $this->height = count($lines);
    $this->width = strlen($lines[0]);
    for ($y = 0; $y < $this->height; $y++) {
      $this->map[$y] = [];
      for ($x = 0; $x < $this->width; $x++) {
        $this->map[$y][$x] = new Position($lines[$y][$x]);
      }
    }
  }

  public function printMap() {
    for ($y = 0; $y < $this->height; $y++) {
      for ($x = 0; $x < $this->width; $x++) {
        print($this->map[$y][$x]->symbol);
      }
      print("\n");
    }
    print("\n");
  }

  public function initializeStartingPositions($symbol) {
    $this->currentPositions = [];
    for ($y = 0; $y < $this->height; $y++) {
      for ($x = 0; $x < $this->width; $x++) {
        $this->map[$y][$x]->visited = false;
        if ($this->map[$y][$x]->symbol == $symbol) {
          $this->currentPositions[] = [$x, $y];
        }
      }
    }
  }

  private function adjacentPositions($x, $y) {
    if ($x > 0) {
      yield [$x - 1, $y];
    }
    if ($x < $this->width - 1) {
      yield [$x + 1, $y];
    }
    if ($y > 0) {
      yield [$x, $y - 1];
    }
    if ($y < $this->height - 1) {
      yield [$x, $y + 1];
    }
  }

  public function findShortestPath() {
    $steps = 0;
    while (!empty($this->currentPositions)) {
      $newPositions = [];
      $steps++;
      foreach ($this->currentPositions as $position) {
        $x = $position[0];
        $y = $position[1];
        $this->map[$y][$x]->visited = true;
        foreach ($this->adjacentPositions($x, $y) as $neighbor) {
          $nx = $neighbor[0];
          $ny = $neighbor[1];
          if ($this->map[$ny][$nx]->visited) {
            continue;
          } else if ($this->map[$ny][$nx]->elevation > $this->map[$y][$x]->elevation + 1) {
            continue;
          } else {
            $this->map[$ny][$nx]->visited = true;
          }
          if ($this->map[$ny][$nx]->symbol == 'E') {
            return $steps;
          }
          $newPositions[] = $neighbor;
        }
      }
      $this->currentPositions = $newPositions;
    }
    return -1;
  }
}


class Solution {
  private $parser;
  private $heightMap;

  public function __construct($day) {
    $this->parser = new Parser($day);
    $lines = [];
    foreach ($this->parser->yieldLines() as $line)
      $lines[] = trim($line);
    $this->heightMap = new heightMap($lines);
  }

  public function part1() {
    $this->heightMap->initializeStartingPositions('S');
    return $this->heightMap->findShortestPath();
  }

  public function part2() {
    $this->heightMap->initializeStartingPositions('a');
    return $this->heightMap->findShortestPath();
  }
}


$solution = new Solution("12");

print("Part 1: " . $solution->part1() . "\n");
print("Part 2: " . $solution->part2() . "\n");
