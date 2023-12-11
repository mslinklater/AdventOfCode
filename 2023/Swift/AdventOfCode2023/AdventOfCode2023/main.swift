//
//  main.swift
//  AdventOfCode2023
//
//  Created by Martin Linklater on 26/11/2023.
//

import Foundation

print("Advent of Code 2023")

let day = 11

switch day {
case 1:
    let day1 = Day01()
    assert(day1.run(filename: "Day1Test1", part: 1) == 142)
    print("Day 1 part 1 = \(day1.run(filename: "Day1Input", part: 1))")
    assert(day1.run(filename: "Day1Test2", part: 2) == 281)
    print("Day 1 part 2 = \(day1.run(filename: "Day1Input", part: 2))")
case 2:
    let day2 = Day02()
    assert(day2.run(filename: "Day2Test1", part: 1) == 8)
    print("Day 2 part 1 = \(day2.run(filename: "Day2Input", part: 1))")
    assert(day2.run(filename: "Day2Test1", part: 2) == 2286)
    print("Day 2 part 2 = \(day2.run(filename: "Day2Input", part: 2))")
case 3:
    let day3 = Day03()
    assert(day3.run(filename: "Day3Test1", part: 1) == 4361)
    assert(day3.run(filename: "Day3Test1", part: 1) == 4361)
    print("Day 3 My test = \(day3.run(filename: "Day3MyTest", part: 1))")
    print("Day 3 part 1 = \(day3.run(filename: "Day3Input", part: 1))")
    assert(day3.run(filename: "Day3Test1", part: 2) == 467835)
    print("Day 3 part 2 = \(day3.run(filename: "Day3Input", part: 2))")
case 4:
    let day4 = Day04()
    assert(day4.run(filename: "Day4Test", part: 1) == 13)
    print("Day 4 part 1 = \(day4.run(filename: "Day4Input", part: 1))")
    assert(day4.run(filename: "Day4Test", part: 2) == 30)
    print("Day 4 part 2 = \(day4.run(filename: "Day4Input", part: 2))")
case 5:
    let day5 = Day05()
    assert(day5.run(filename: "Day5Test", part: 1) == 35)
    print("Day 5 part 1 = \(day5.run(filename: "Day5Input", part: 1))")
    assert(day5.run(filename: "Day5Test", part: 2) == 46)
    print("Day 5 part 2 = \(day5.run(filename: "Day5Input", part: 2))") // TODO !
case 6:
    let day6 = Day06()
    assert(day6.run(filename: "Day6Test", part: 1) == 288)
    print("Day 6 part 1 = \(day6.run(filename: "Day6Input", part: 1))")
    print("Day 6 part 2 = \(day6.run(filename: "Day6Input", part: 2))")
case 7:
    // This needs cleaning up
    let day7 = Day07()
    assert(day7.run(filename: "Day7Test", part: 1) == 6440)
    print("Day 7 part 1 = \(day7.run(filename: "Day7Input", part: 1))")
    let day7b = Day07b()
    assert(day7b.run(filename: "Day7Test", part: 1) == 5905)
    print("Day 7 part 2 = \(day7b.run(filename: "Day7Input", part: 1))")
case 8:
    let day8 = Day08()
    assert(day8.run(filename: "Day8Test", part: 1) == 6)
    print("Day 8 part 1 = \(day8.run(filename: "Day8Input", part: 1))")
    print("Day 8 part 2 = \(day8.run(filename: "Day8Input", part: 2))")
case 9:
    let day9 = Day09()
    assert(day9.run(filename: "Day9Test", part: 1) == 114)
    print("Day 9 part 1 = \(day9.run(filename: "Day9Input", part: 1))")
    assert(day9.run(filename: "Day9Test", part: 2) == 2)
    print("Day 9 part 2 = \(day9.run(filename: "Day9Input", part: 2))")
case 10:
    let day10 = Day10()
    assert(day10.run(filename: "Day10Test1", part: 1) == 4)
    assert(day10.run(filename: "Day10Test2", part: 1) == 8)
    print("Day 10 part 1 = \(day10.run(filename: "Day10Input", part: 1))")
    assert(day10.run(filename: "Day10Test3", part: 2) == 4)
    assert(day10.run(filename: "Day10Test4", part: 2) == 4)
    assert(day10.run(filename: "Day10Test5", part: 2) == 8)
    print("Day 10 part 2 = \(day10.run(filename: "Day10Input", part: 2))")
case 11:
    let day11 = Day11()
    assert(day11.run(filename: "Day11Test", part: 1) == 374)
default:
    assert(false)
}


print("FINISHED")
