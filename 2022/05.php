<?php

class Stack {
  private $stack = [];

  public function push($value) {
    array_push($this->stack, $value);
  }

  public function pop() {
    return array_pop($this->stack);
  }

  public function peek() {
    return end($this->stack);
  }

  public function isEmpty() {
    return empty($this->stack);
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
    $result = "";
    while (!ctype_space($line = fgets($this->file))) {
      $stackScheme[] = str_split(($line));
    }
    $stackScheme = array_map(null, ...$stackScheme);
    $stacks = [];
    foreach ($stackScheme as $scheme) {
      $stack = array_reverse(array_filter($scheme, function($char) {
        return !ctype_space($char);
      }));
      if (!empty($stack) && is_numeric($stack[0])) {
        // print("-" . implode("", $stack) . "-\n");
        $stacks[] = new Stack();
        for ($i = 1; $i < count($stack); $i++) {
          $stacks[count($stacks) - 1]->push($stack[$i]);
        }
      }
    }
    while (($line = fgets($this->file)) !== false) {
      $exploded = explode(" ", $line);
      $numberOfCrates = $exploded[1];
      $sourceIndex = $exploded[3] - 1;
      $destinationIndex = $exploded[5] - 1;
      for ($i = 0; $i < $numberOfCrates; $i++) {
        $crate = $stacks[$sourceIndex]->pop();
        $stacks[$destinationIndex]->push($crate);
      }
    }
    foreach ($stacks as $stack) {
      $result .= $stack->peek();
    }
    return $result;
  }

  public function part2() {
    $this->resetFilePointer();
    $result = "";
    while (!ctype_space($line = fgets($this->file))) {
      $stackScheme[] = str_split(($line));
    }
    $stackScheme = array_map(null, ...$stackScheme);
    $stacks = [];
    foreach ($stackScheme as $scheme) {
      $stack = array_reverse(array_filter($scheme, function($char) {
        return !ctype_space($char);
      }));
      if (!empty($stack) && is_numeric($stack[0])) {
        $stacks[] = new Stack();
        for ($i = 1; $i < count($stack); $i++) {
          $stacks[count($stacks) - 1]->push($stack[$i]);
        }
      }
    }
    while (($line = fgets($this->file)) !== false) {
      $exploded = explode(" ", $line);
      $numberOfCrates = $exploded[1];
      $sourceIndex = $exploded[3] - 1;
      $destinationIndex = $exploded[5] - 1;
      $intermedStack = new Stack();
      for ($i = 0; $i < $numberOfCrates; $i++) {
        $crate = $stacks[$sourceIndex]->pop();
        $intermedStack->push($crate);
      }
      while (!$intermedStack->isEmpty()) {
        $stacks[$destinationIndex]->push($intermedStack->pop());
      }
    }
    foreach ($stacks as $stack) {
      $result .= $stack->peek();
    }
    return $result;
  }

  public function __destruct() {
    fclose($this->file);
  }
}


$solution = new Solution(fopen('input/05.txt', 'r'));

print("Part 1: " . $solution->part1() . "\n");
print("Part 2: " . $solution->part2() . "\n");
