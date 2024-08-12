<?php
require_once('input/parser.php');



class File { 
  // everything is a file
  public $name;
  public $parentDir;
  public $size;

  public function __construct($name, $parentDir, $size) {
    $this->name = $name;
    $this->parentDir = $parentDir;
    $this->size = $size;
  }
}



class Dir extends File {
  public $children;

  public function __construct($name, $parentDir = null) {
    $this->name = $name;
    $this->parentDir = $parentDir;
    $this->size = 0;
    $this->children = [];
  }

  public function __toString() {
    return $this->name;
  }

  private function contains($name) {
    foreach ($this->children as $child) {
      if ($child->name == $name) {
        return true;
      }
    }
    return false;
  }

  public function addChild($child) {
    if (!$this->contains($child->name)) {
      $child->parentDir = $this;
      $this->children[] = $child;
    }
  }

  public function findChild($name) {
    foreach ($this->children as $child) {
      if ($child->name == $name) {
        return $child;
      }
    }
    return null;
  }

  public function calculateDirSizes() {
    $this->size = 0;
    foreach ($this->children as $child) {
      if ($child instanceof Dir) {
        $this->size += $child->calculateDirSizes();
      } else {
        $this->size += $child->size;
      }
    }
    return $this->size;
  }

  public function generateSmallDirSizes() {
    foreach ($this->children as $child) {
      if ($child instanceof Dir) {
        yield from $child->generateSmallDirSizes();
      }
    }
    if ($this->size <= 100000) {
      yield $this->size;
    }
  }
}



class Solution {
  private $parser;
  private $dirTree = null;
  private $neededSpace = 0;
  private $dirToDeleteSize = 0;

  public function __construct($day) {
    $this->parser = new Parser($day);
    $this->constructDirTree();
  }

  private function constructDirTree() {
    $root = new Dir("/");
    $root->parentDir = $root;
    $currentDir = $root;
    foreach ($this->parser->yieldLines() as $line) {
      $line = explode(" ", trim($line));
      if ($line[0] == "$") {
        if ($line[1] == "cd") {
          if ($line[2] == "/") {
            $currentDir = $root;
          } else if ($line[2] == "..") {
            $currentDir = $currentDir->parentDir;
          } else {
            $currentDir = $currentDir->findChild($line[2]);
          }
        }
      } else if (is_numeric($line[0])) {
        $currentDir->addChild(new File($line[1], $currentDir, $line[0]));
      } else if ($line[0] == "dir") {
        $currentDir->addChild(new Dir($line[1], $currentDir));
      }
    }
    $root->calculateDirSizes();
    $this->neededSpace = 30000000 - (70000000 - $root->size);
    $this->dirToDeleteSize = $root->size;
    $this->dirTree = $root;
  }

  private function findDirToDelete($dir) {
   if ($dir->size < $this->neededSpace) {
     return;
   }
   if ($dir->size < $this->dirToDeleteSize) {
     $this->dirToDeleteSize = $dir->size;
   }
   foreach ($dir->children as $child) {
     if ($child instanceof Dir) {
       $this->findDirToDelete($child);
     }
   }
  }

  public function part1() {
    $result = 0;
    foreach ($this->dirTree->generateSmallDirSizes() as $size) {
      $result += $size;
    }
    return $result;
  }

  public function part2() {
    $this->findDirToDelete($this->dirTree);
    return $this->dirToDeleteSize;
  }
}


$solution = new Solution("07");

print("Part 1: " . $solution->part1() . "\n");
print("Part 2: " . $solution->part2() . "\n");
