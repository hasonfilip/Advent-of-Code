<?php
require_once('input/parser.php');


class Rope {
  private $head;
  private $tail;
  public $visited;

public function __construct() {
    $this->head = [0, 0];
    $this->tail = [0, 0];
    $this->visited = [[0, 0]];
  }

  private function pullTail() {
    $this->tail[0] = $this->head[0];
    $this->tail[1] = $this->head[1];
    if (!in_array($this->tail, $this->visited)) {
      $this->visited[] = $this->tail;
    }
  }

  public function move($direction) {
    switch ($direction) {
    case 'U':
      if ($this->head[1] - $this->tail[1] == 1)
        $this->pullTail();
      $this->head[1] ++;
      break;
    case 'D':
      if ($this->head[1] - $this->tail[1] == -1) 
        $this->pullTail();
      $this->head[1] --;
      break;
    case 'L':
      if ($this->head[0] - $this->tail[0] == -1) 
        $this->pullTail();
      $this->head[0] --;
      break;
    case 'R':
      if ($this->head[0] - $this->tail[0] == 1) 
        $this->pullTail();
      $this->head[0]++;
      break;
    }
  }

  public function countVisited() {
    return count($this->visited);
  }
}


class Solution {
  private $parser;

  public function __construct($day) {
    $this->parser = new Parser($day);
  }

  public function part1() {
    $rope = new Rope();
    foreach ($this->parser->yieldLines() as $line) {
      [$direction, $distance] = explode(' ', trim($line));
      for ($i = 0; $i < $distance; $i++) {
        $rope->move($direction);
      }
    }
    return $rope->countVisited();
  }

  public function part2() {
    return 0;
  }
}


$solution = new Solution("09");

print("Part 1: " . $solution->part1() . "\n");
print("Part 2: " . $solution->part2() . "\n");
