//
//  Day07.swift
//  AdventOfCode2023
//
//  Created by Martin Linklater on 07/12/2023.
//

import Foundation


class Day07 : DayBase {
    
    enum Card: Int, Comparable {
        case two
        case three
        case four
        case five
        case six
        case seven
        case eight
        case nine
        case ten
        case jack
        case queen
        case king
        case ace
        public static func < (lhs: Card, rhs: Card) -> Bool {
            return lhs.rawValue < rhs.rawValue
        }
    }
    
    let charMap = [
    "2": Card.two,
    "3": Card.three,
    "4": Card.four,
    "5": Card.five,
    "6": Card.six,
    "7": Card.seven,
    "8": Card.eight,
    "9": Card.nine,
    "T": Card.ten,
    "J": Card.jack,
    "Q": Card.queen,
    "K": Card.king,
    "A": Card.ace
    ]

    enum Rank: Int, Comparable {
        case highCard
        case onePair
        case twoPair
        case threeOfAKind
        case fullHouse
        case fourOfAKind
        case fiveOfAKind
        public static func < (lhs: Rank, rhs: Rank) -> Bool {
            return lhs.rawValue < rhs.rawValue
        }
    }
    
    struct Hand : Comparable {
        static func < (lhs: Day07.Hand, rhs: Day07.Hand) -> Bool {
            if lhs.rank == rhs.rank {
                for i in 0 ..< lhs.cards.count {
                    if lhs.cards[i] != rhs.cards[i] {
                        return lhs.cards[i] < rhs.cards[i]
                    }
                }
            } else {
                return lhs.rank < rhs.rank
            }
            assert(false)
        }
        
        var cards = [Card]()
        var stake = 0
        var rank = Rank.highCard
        
        mutating func workOutRank() {
            var cardCount = [Card:Int]()
            for card in cards {
                if cardCount[card] != nil {
                    cardCount[card] = cardCount[card]! + 1
                } else {
                    cardCount[card] = 1
                }
            }
            var numCounts = [0,0,0,0,0]
            for (_, c) in cardCount {
                numCounts[c - 1] += 1
            }
            // work out which rank
            if numCounts[4] > 0 {
                rank = .fiveOfAKind
            } else if numCounts[3] > 0 {
                rank = .fourOfAKind
            } else if numCounts[2] > 0 {
                if numCounts[1] > 0 {
                    rank = .fullHouse
                } else {
                    rank = .threeOfAKind
                }
            } else if numCounts[1] == 2 {
                rank = .twoPair
            } else if numCounts[1] == 1 {
                rank = .onePair
            }
        }
        
        // need a comparison operator here
            // compare by rank, then by highest card in order
    }
    
    var hands = [Hand]()
    
    override func run(filename: String, part: Int) -> Int {
        var total = 0
        hands.removeAll()
        parseInput(filename)
        if part == 1 {
            hands.sort()
            for i in 0 ..< hands.count {
                total += (i+1) * hands[i].stake
            }
        } else {
            assert(false)
        }
        
        return total
    }
    
    func parseInput(_ filename: String) {
        let lines = fileAsLines(filename: filename)
        for line in lines {
            if line.count > 0 {
                var newHand = Hand()
                let split = line.split(separator: " ")
                newHand.stake = Int(split[1])!
                for card in split[0] {
                    newHand.cards.append(charMap[String(card)]!)
                }
                newHand.workOutRank()
                hands.append(newHand)
            }
        }
    }
}

