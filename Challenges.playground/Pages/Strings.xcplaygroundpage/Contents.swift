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
