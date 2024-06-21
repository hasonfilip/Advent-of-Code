#!/usr/bin/env python3
from enum import Enum

class Direction(Enum):
    UP = 0
    LEFT = 1
    DOWN = 2
    RIGHT = 3

class Coordinate:
    def __init__(self, x, y):
        self.x = x
        self.y = y

class Beams:
    def __init__(self, map = []):
        self.beams = []
        self.map = map
        self.found_positions = [] # [    [ [char] [char] [char] [char]  ] line
                                  #      [ [char] [char] [char] [char]  ]    ]
        
    def initialize_starting_position(self, starting_position, starting_direction):
        self.beams.append([starting_position, starting_direction])
        self.initialize_found_positions()

    def initialize_found_positions(self):
        self.found_positions = []
        for i, line in enumerate(self.map):
            self.found_positions.append([])
            for _ in range(len(line)):
                self.found_positions[i].append([])

    def get_next_position(self, position, direction):
        if direction == Direction.UP:
            return Coordinate(position.x, position.y - 1)
        elif direction == Direction.LEFT:
            return Coordinate(position.x - 1, position.y)
        elif direction == Direction.DOWN:
            return Coordinate(position.x, position.y + 1)
        elif direction == Direction.RIGHT:
            return Coordinate(position.x + 1, position.y)
        
    def is_out_of_map(self, position):
        if position.y < 0 or position.y >= len(self.map):
            return True
        if position.x < 0 or position.x >= len(self.map[0]):
            return True
        return False
        
    def move_one_step(self):
        new_beams = []        
        for beam in self.beams:
            new_beam = None
            position = beam[0]
            direction = beam[1]
            next_position = self.get_next_position(position, direction)
            if self.is_out_of_map(next_position):
                # Remove beam
                self.beams.remove(beam)
                continue
            if self.map[next_position.y][next_position.x] == "\\":
                if direction == Direction.UP:
                    direction = Direction.LEFT
                elif direction == Direction.LEFT:
                    direction = Direction.UP
                elif direction == Direction.DOWN:
                    direction = Direction.RIGHT
                elif direction == Direction.RIGHT:
                    direction = Direction.DOWN
            elif self.map[next_position.y][next_position.x] == "/":
                if direction == Direction.UP:
                    direction = Direction.RIGHT
                elif direction == Direction.LEFT:
                    direction = Direction.DOWN
                elif direction == Direction.DOWN:
                    direction = Direction.LEFT
                elif direction == Direction.RIGHT:
                    direction = Direction.UP

            elif self.map[next_position.y][next_position.x] == "|":
                if direction == Direction.UP or direction == Direction.DOWN:
                    # Keep going
                    pass
                else:
                    # split the beam
                    new_beam = [next_position, Direction.UP]
                    new_beams.append(new_beam)
                    beam[0] = next_position
                    direction = Direction.DOWN

            elif self.map[next_position.y][next_position.x] == "-":
                if direction == Direction.LEFT or direction == Direction.RIGHT:
                    # Keep going
                    pass
                else:
                    # split the beam
                    new_beam = [next_position, Direction.LEFT]
                    new_beams.append(new_beam)
                    beam[0] = next_position
                    direction = Direction.RIGHT
                    
            beam[0] = next_position
            beam[1] = direction
            if direction in self.found_positions[next_position.x][next_position.y]:
                # found a loop
                self.beams.remove(beam)
            else:
                self.found_positions[next_position.x][next_position.y].append(direction)
            if new_beam:
                if new_beam[1] in self.found_positions[new_beam[0].x][new_beam[0].y]:
                    # found a loop
                    new_beams.pop(-1)
                else:
                    self.found_positions[new_beam[0].x][new_beam[0].y].append(new_beam[1])
        self.beams.extend(new_beams)
        new_beams = []
                
    def count_energized_tiles(self):
        count = 0
        for i, line in enumerate(self.map):
            for j in range(len(line)):
                if len(self.found_positions[j][i]) > 0:
                    count += 1
        return count
    
    def run(self):
        while len(self.beams) > 0:
            self.move_one_step()
        return self.count_energized_tiles()

def part_1():
    map = []
    with open("input.txt") as f:
        for line in f:
            map.append(line.strip())
        
    beams = Beams(map)
    beams.initialize_starting_position(Coordinate(-1, 0), Direction.RIGHT)
    result = beams.run()
    print("Answer for part 1 is:", result)

def part_2():
    map = []
    with open("input.txt") as f:
        for line in f:
            map.append(line.strip())
        
    beams = Beams(map)
    best_result = 0
    for i in range(len(map)): # for each line
        beams.initialize_starting_position(Coordinate(-1, i), Direction.RIGHT)
        result = beams.run()
        if result > best_result:
            best_result = result

        beams.initialize_starting_position(Coordinate(len(map[i]), i), Direction.LEFT)
        result = beams.run()
        if result > best_result:
            best_result = result
        
    for i in range(len(map[0])): # for each column
        beams.initialize_starting_position(Coordinate(i, -1), Direction.DOWN)
        result = beams.run()
        if result > best_result:
            best_result = result

        beams.initialize_starting_position(Coordinate(i, len(map)), Direction.UP)
        
        result = beams.run()
        if result > best_result:
            best_result = result

    print("Answer for part 2 is:", best_result)
            

if __name__ == "__main__":
    part_1()
    part_2()
