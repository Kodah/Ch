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


//: # 7
//: “Write a function that returns a string with any consecutive spaces replaced with a single space.”

func chal7(_ s: String) -> String {
    let reg = try! NSRegularExpression.init(pattern: " {2,}", options: .caseInsensitive)
    
    reg.matches(in: s, options: .reportCompletion, range: NSRangeFromString(s))
    return reg.stringByReplacingMatches(in: s,
                                        options: .reportProgress,
                                        range: NSString(string: s).range(of: s),
                                        withTemplate: " ")
}

extension Tester {
    func test7() {
        XCTAssertEqual(chal7("a   b   c"), "a b c")
        XCTAssertEqual(chal7("    a"), " a")
        XCTAssertEqual(chal7("abc"), "abc")
    }
}

//: # 8
//: Write a function that accepts two strings, and returns true if one string is rotation of the other, taking letter case into account. Tip: A string rotation is when you take a string, remove some letters from its end, then append them to the front. For example, “swift” rotated by two characters would be “ftswi”.

func chal8(_ s1: String, _ s2: String) -> Bool {
    guard Set(s1) == Set(s2) else { return false }
    
    var lastSlice = ""
    for i in 1 ... s1.count {
        let slice = String(Array(s1)[0..<i])
        
        if !s2.contains(slice) {
            let s1Remove = s1.range(of: lastSlice)!
            let s2Remove = s2.range(of: lastSlice)!
            var s1c = s1
            var s2c = s2
            s1c.removeSubrange(s1Remove)
            s2c.removeSubrange(s2Remove)
            return s2c == s1c
        }
        lastSlice = slice
    }
    
    
    return false
}

extension Tester {
    func test8() {
        XCTAssertTrue(chal8("swift", "ftswi"))
        XCTAssertTrue(chal8("abcde", "eabcd"))
        XCTAssertTrue(chal8("abcde", "cdeab"))
        XCTAssertFalse(chal8("abcde", "abced"))
        XCTAssertFalse(chal8("abc", "a"))
    }
}

//: # 9
//: “Write a function that returns true if it is given a string that is an English pangram, ignoring letter case. Tip: A pangram is a string that contains every letter of the alphabet at least once.”

func chal9(_ s: String) -> Bool {
    let alphabet = Set("abcdefghijklmnopqrstuvwxyz")
    let input = s.lowercased().replacingOccurrences(of: " ", with: "")
    
    return alphabet == Set(input)
}

extension Tester {
    func test9() {
        XCTAssertTrue(chal9("The quick brown fox jumps over the lazy dog"))
        XCTAssertFalse(chal9("The quick brown fox jumped over the lazy dog"))
    }
}


//: # 10
//: “Given a string in English, return a tuple containing the number of vowels and consonants. Tip: Vowels are the letters, A, E, I, O, and U; consonants are the letters B, C, D, F, G, H, J, K, L, M, N, P, Q, R, S, T, V, W, X, Y, Z.”


func chal10(_ s: String) -> (Int, Int) {

    let input = s.replacingOccurrences(of: " ", with: "")
    
    let reg = try! NSRegularExpression(pattern: "[aeiou]", options: .caseInsensitive)
    let cutString = reg.stringByReplacingMatches(in: input,
                                 options: .reportCompletion,
                                 range: NSString(string: input).range(of: input),
                                 withTemplate: "")
    let cons = cutString.count
    let vowels = input.count - cons
    
    return (vowels, cons)
}


extension Tester {
    func test10() {
        XCTAssertEqual(chal10("Swift Coding Challenges").0, 6)
        XCTAssertEqual(chal10("Swift Coding Challenges").1, 15)
        XCTAssertEqual(chal10("Mississippi").0, 4)
        XCTAssertEqual(chal10("Mississippi").1, 7)
    }
}


//: # 11
//: “Write a function that accepts two strings, and returns true if they are identical in length but have no more than three different letters, taking case and string order into account.”

func chal11(_ s1: String, _ s2: String) -> Bool {
    guard s1.count == s2.count else { return false }
    
    let differences = zip(s1, s2).reduce(0) {
         $1.0 != $1.1 ? $0+1 : $0
    }
    return differences <= 3
}


extension Tester {
    func test11() {
        XCTAssertTrue(chal11("Clamp", "Cramp"))
        XCTAssertTrue(chal11("Clamp", "Crams"))
        XCTAssertTrue(chal11("Clamp", "Grams"))
        XCTAssertFalse(chal11("Clamp", "Grans"))
        XCTAssertFalse(chal11("Clamp", "Clam"))
        XCTAssertFalse(chal11("Clamp", "maple"))
    }
}

//: # 12
//: Write a function that accepts a string of words with a similar prefix, separated by spaces, and returns the longest substring that prefixes all words.

func chal12(_ s: String) -> String {
    
    let words = s.split(separator: " ")
    let shortestWord = words.min() { $0.count < $1.count }?.count
    var index = 0
    for i in 0 ..< shortestWord! {
        index = i
        let letters = words.map{ Array($0)[i] }
        if Set(letters).count != 1 {
            break
        }
    }
    return String(s.prefix(index))
}

extension Tester {
    func test12() {
        XCTAssertEqual(chal12("swift switch swill swim"), "swi")
        XCTAssertEqual(chal12("flip flap flop"), "fl")
    }
}


//: # 13
//: “Write a function that accepts a string as input, then returns how often each letter is repeated in a single run, taking case into account. Tip: This approach is used in a simple lossless compression technique called run-length encoding.”
func chal13(_ s: String) -> String {

    var output = ""
    var lastLetter = ""
    var count = 0
    
    for l in s {
        let letter = String(l)
        if letter == lastLetter || count == 0 {
            count += 1
        } else {
            output += "\(lastLetter)\(count)"
            count = 1
        }
        lastLetter = letter
        
    }
    output += "\(lastLetter)\(count)"
    
    return output
}

extension Tester {
    func test13() {
        XCTAssertEqual(chal13("aabbcc"), "a2b2c2")
        XCTAssertEqual(chal13("aaabaaabaaa"), "a3b1a3b1a3")
        XCTAssertEqual(chal13("aaAAaa"), "a2A2a2")
    }
}


