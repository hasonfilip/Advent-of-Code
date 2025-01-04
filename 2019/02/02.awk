#!/usr/bin/gawk -f

BEGIN {
  FS = ","
}

{
  for (i = 1; i <= NF; i++) {
    original_program[i-1] = $i
  }
}

END {
  print "Part 1: " run_program(12, 2)
  for (noun = 0; noun <= 99; noun++) {
    for (verb = 0; verb <= 99; verb++) {
      if (run_program(noun, verb) == 19690720) {
        print "Part 2: " 100 * noun + verb
        exit
      }
    }
  }
}

function run_program(noun, verb,    position) {
  reset_program()
  program[1] = noun
  program[2] = verb
  for (position = 0; program[position] != 99; position += 4) {
    switch(program[position]) {
    case 1:
      program[program[position+3]] = program[program[position+1]] + program[program[position+2]]
      break 
    case 2:
      program[program[position+3]] = program[program[position+1]] * program[program[position+2]]
      break 
    }
  }
  return program[0]
}

function reset_program(    i) {
  for (i = 0; i < length(original_program); i++) {
    program[i] = original_program[i]
  }
}
