import Foundation
import XCTest
class Tester: XCTestCase { }
Tester.defaultTestSuite.run()
//: # 1
//: Write a function that accepts a String as its only parameter, and returns true if the string has only unique letters, taking letter case into account.

func challenge1(input: String) -> Bool {
    return Set(input).count == input.count
}


extension Tester {
    func test_challenge_1() {
        XCTAssertTrue(challenge1(input: "No duplicates"))
        XCTAssertTrue(challenge1(input: "abcdefghijklmnopqrstuvwxyz"))
        XCTAssertTrue(challenge1(input: "AaBbCc"))
        
        XCTAssertFalse(challenge1(input: "Hello, world"))
    }
}



//: # 2
//: Write a function that accepts a String as its only parameter, and returns true if the string reads the same when reversed, ignoring case.
func challenge2(input: String) -> Bool {
    return input.lowercased() == String(input.reversed()).lowercased()
}

extension Tester {
    func test_challenge_2() {
        XCTAssertTrue(challenge2(input: "rotator"))
        XCTAssertTrue(challenge2(input: "Rats live on no evil star"))
        XCTAssertFalse(challenge2(input: "Never odd or even"))
        XCTAssertFalse(challenge2(input: "Hello, World"))
    }
}



//: # 3
//: “Write a function that accepts two String parameters, and returns true if they contain the same characters in any order taking into account letter case.”

func challenge3(input1: String, input2: String) -> Bool {
    return input1.sorted() == input2.sorted()
}

extension Tester {
    func test_challenge_3() {
        XCTAssertTrue(challenge3(input1: "abca", input2: "abca"))
        XCTAssertTrue(challenge3(input1: "abca", input2: "cbaa"))
        XCTAssertTrue(challenge3(input1: "a1 b2", input2: "b1 a2"))
        XCTAssertFalse(challenge3(input1: "abc", input2: "Abc"))
        XCTAssertFalse(challenge3(input1: "abc", input2: "cbAa"))
        XCTAssertFalse(challenge3(input1: "aaa", input2: "a"))
    }
}


//: # 4
//: “Write your own version of the contains() method on String that ignores letter case, and without using the existing contains() method.”


extension String {
    func fuzzyContains(_ s: String) -> Bool {
        guard s.count < self.count else { return false }
        for i in 0...self.count - s.count {
            let slice = Array(self)[i...i+s.count-1]
            if String(slice).lowercased() == s.lowercased() { return true }
        }
        
        return false
    }
    
    func bookExample(_ s: String) -> Bool {
        return self.range(of: s, options: .caseInsensitive) != nil
    }
}
extension Tester {
    func test4() {
        XCTAssertTrue("Hello, world".fuzzyContains("Hello"), "fuzzy 1")
        XCTAssertTrue("Hello, world".fuzzyContains("WORLD"), "fuzzy 2")
        XCTAssertFalse("Hello, world".fuzzyContains("Goodbye"), "fuzzy 3")
        
        XCTAssertTrue("Hello, world".bookExample("Hello"), "fuzzy 1")
        XCTAssertTrue("Hello, world".bookExample("WORLD"), "fuzzy 2")
        XCTAssertFalse("Hello, world".bookExample("Goodbye"), "fuzzy 3")
    }
}


//: # 5
//: “Write a function that accepts a string, and returns how many times a specific character appears, taking case into account. Tip: If you can solve this without using a for-in loop, you can consider it a Tricky challenge.”

func challenge5(input1: String, input2: Character) -> Int {
    return input1.filter { $0 == input2 }.count
}

extension Tester {
    func test_challenge_5() {
        XCTAssertEqual(challenge5(input1: "The rain in Spain", input2: "a"), 2)
        XCTAssertEqual(challenge5(input1: "Mississippi", input2: "i"), 4)
    }
}

//: # 6
//: “Write a function that accepts a string as its input, and returns the same string just with duplicate letters removed.”


func challenge6(input1: String) -> String {
    
    var unique = Set(input1)
    
    let s = input1.reduce("") {
        unique.remove($1) != nil ? "\($0)\($1)" : $0
       
    }

    return s
}

extension Tester {
    func test_challenge_6() {
        XCTAssertEqual(challenge6(input1: "wombat"), "wombat")
        XCTAssertEqual(challenge6(input1: "hello"), "helo")
        XCTAssertEqual(challenge6(input1: "Mississippi"), "Misp")
    }
}









