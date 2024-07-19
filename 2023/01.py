#!/usr/bin/env python3


class Solution:
    def __init__(self):
        self.input_file = open("input/01.txt", "r")
        self.result = 0
        self.original = [
            "one",
            "two",
            "three",
            "five",
            "seven",
            "nine",
            "eight",
            "one",
            "three",
            "four",
            "five",
            "six",
            "seven",
            "nine",
            "eight",
            "two",
        ]
        self.replacement = [
            "onee",
            "twoo",
            "threee",
            "fivee",
            "sevenn",
            "ninee",
            "eightt",
            "1",
            "3",
            "4",
            "5",
            "6",
            "7",
            "9",
            "8",
            "2",
        ]

    def __del__(self):
        self.input_file.close()

    def reset(self):
        self.input_file.seek(0)
        self.result = 0

    def replace_words(self, line):
        for i in range(len(self.original)):
            line = line.replace(self.original[i], self.replacement[i])
        return line

    def process_line(self, line):
        first_number = None
        second_number = None
        for character in line:
            if character.isnumeric():
                if first_number is None:
                    first_number = character
                else:
                    second_number = character

        if second_number is None:
            second_number = first_number

        if first_number is not None:
            self.result += int(first_number + second_number)

    def part_1(self):
        self.reset()
        for line in self.input_file:
            self.process_line(line)
        print("Answer for part 1 is:", self.result)

    def part_2(self):
        self.reset()
        for line in self.input_file:
            line = self.replace_words(line)
            self.process_line(line)
        print("Answer for part 2 is:", self.result)


def main():
    solution = Solution()
    solution.part_1()
    solution.part_2()


if __name__ == "__main__":
    main()
