<?php
require_once('input/parser.php');

class Monkey {
  public $items;
  public $operation;
  private $argument;
  public $testDivisor;
  public $monkeyIndexOnSuccess;
  public $monkeyIndexOnFailure;
  public $inspectedItems;

  public function __construct($items, $operator, $argument, 
    $testDivisor, $monkeyIndexOnSuccess, $monkeyIndexOnFailure) {
    $this->items = $items;
    $this->argument = $argument;
    $this->testDivisor = $testDivisor;
    $this->monkeyIndexOnSuccess = $monkeyIndexOnSuccess;
    $this->monkeyIndexOnFailure = $monkeyIndexOnFailure;
    $this->inspectedItems = 0;

    if ($operator == '+') {
      if ($argument == "old") {
        $this->operation = function($item) {
          return $item + $item;
        };
      } else {
        $this->operation = function($item) {
          return $item + $this->argument;
        };
      }
    } else if ($operator == '*') {
      if ($argument == "old") {
        $this->operation = function($item) {
          return $item * $item;
        };
      } else {
        $this->operation = function($item) {
          return $item * $this->argument;
        };
      }
    }
  }
}

class Monkeys {
  public $monkeys;
  private $relief;
  private $commonMultiple = 1;

  public function __construct($relief = true) {
    $this->monkeys = [];
    $this->relief = $relief;
  }

  public function addMonkey($monkey) {
    $this->monkeys[] = $monkey;
  }

  public function calculateCommonMultiple() {
    foreach ($this->monkeys as $monkey) {
      $this->commonMultiple *= $monkey->testDivisor;
    }
  }

  public function runRound() {
    foreach ($this->monkeys as $monkey) {
      foreach ($monkey->items as $item) {
        $monkey->inspectedItems++;
        $item = ($monkey->operation)($item);
        if ($this->relief) 
          $item = floor($item / 3);
        else
          $item = $item % $this->commonMultiple;
        $this->monkeys[
          $item % $monkey->testDivisor == 0 ? 
          $monkey->monkeyIndexOnSuccess : 
          $monkey->monkeyIndexOnFailure
        ]->items[] = $item;
      }
      $monkey->items = [];
    }
  }

  public function calculateMonkeyBusiness() {
    $stMostInspectedItems = 0;
    $ndMostInspectedItems = 0;
    foreach ($this->monkeys as $monkey) {
      if ($monkey->inspectedItems > $stMostInspectedItems) {
        $ndMostInspectedItems = $stMostInspectedItems;
        $stMostInspectedItems = $monkey->inspectedItems;
      } elseif ($monkey->inspectedItems > $ndMostInspectedItems) {
        $ndMostInspectedItems = $monkey->inspectedItems;
      }
    }
    return $stMostInspectedItems * $ndMostInspectedItems;
  }
}


class Solution {
  private $parser;
  private $parts;

  public function __construct($day) {
    $this->parser = new Parser($day);
    $input = $this->parser->readAll();
    $this->parts = explode("\n\n", $input);
  }

  public function part1() {
    $monkeys = new Monkeys();
    foreach ($this->parts as $part) {
      $items = [];
      foreach (explode("\n", $part) as $line) {
        $lineParts = explode(": ", trim($line));
        switch ($lineParts[0]) {
          case "Starting items":
            $items = explode(", ", $lineParts[1]);
            break;
          case "Operation":
            $operationParts = explode(" ", $lineParts[1]);
            $operator = $operationParts[3];
            $argument = $operationParts[4];
            break;
          case "Test":
            $testParts = explode(" ", $lineParts[1]);
            $testDivisor = $testParts[2];
            break;
          case "If true":
            $ifTrueParts = explode(" ", $lineParts[1]);
            $successIndex = $ifTrueParts[3];
            break;
          case "If false":
            $ifFalseParts = explode(" ", $lineParts[1]);
            $failureIndex = $ifFalseParts[3];
            break;
        }
      }
      if (trim($part) != "")
        $monkeys->addMonkey(new Monkey($items, $operator, $argument,
          $testDivisor, $successIndex, $failureIndex));
    }
    $monkeys->calculateCommonMultiple();
    for ($i = 0; $i < 20; $i++) {
      $monkeys->runRound();
    }
    return $monkeys->calculateMonkeyBusiness();
  }

  public function part2() {
    $monkeys = new Monkeys(false);
    foreach ($this->parts as $part) {
      $items = [];
      foreach (explode("\n", $part) as $line) {
        $lineParts = explode(": ", trim($line));
        switch ($lineParts[0]) {
          case "Starting items":
            $items = explode(", ", $lineParts[1]);
            break;
          case "Operation":
            $operationParts = explode(" ", $lineParts[1]);
            $operator = $operationParts[3];
            $argument = $operationParts[4];
            break;
          case "Test":
            $testParts = explode(" ", $lineParts[1]);
            $testDivisor = $testParts[2];
            break;
          case "If true":
            $ifTrueParts = explode(" ", $lineParts[1]);
            $successIndex = $ifTrueParts[3];
            break;
          case "If false":
            $ifFalseParts = explode(" ", $lineParts[1]);
            $failureIndex = $ifFalseParts[3];
            break;
        }
      }
      if (trim($part) != "")
        $monkeys->addMonkey(new Monkey($items, $operator, $argument,
          $testDivisor, $successIndex, $failureIndex));
    }
    $monkeys->calculateCommonMultiple();
    for ($i = 0; $i < 10_000; $i++) {
      $monkeys->runRound();
    }
    return $monkeys->calculateMonkeyBusiness();
  }
}


$solution = new Solution("11");

print("Part 1: " . $solution->part1() . "\n");
print("Part 2: " . $solution->part2() . "\n");
