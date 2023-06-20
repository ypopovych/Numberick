//=----------------------------------------------------------------------------=
// This source file is part of the Numberick open source project.
//
// Copyright (c) 2023 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if DEBUG

import NBKCoreKit
import XCTest

//*============================================================================*
// MARK: * NBK x Collection
//*============================================================================*

final class NBKCollectionTests: XCTestCase {
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Remove Count
    //=------------------------------------------------------------------------=
    
    func testRemovePrefixCount() {
        NBKAssertRemovePrefixCount(0, [             ], [1, 2, 3, 4, 5])
        NBKAssertRemovePrefixCount(1, [1            ], [   2, 3, 4, 5])
        NBKAssertRemovePrefixCount(2, [1, 2         ], [      3, 4, 5])
        NBKAssertRemovePrefixCount(3, [1, 2, 3      ], [         4, 5])
        NBKAssertRemovePrefixCount(4, [1, 2, 3, 4   ], [            5])
        NBKAssertRemovePrefixCount(5, [1, 2, 3, 4, 5], [             ])
    }
    
    func testRemoveSuffixCount() {
        NBKAssertRemoveSuffixCount(0, [1, 2, 3, 4, 5], [             ])
        NBKAssertRemoveSuffixCount(1, [1, 2, 3, 4   ], [            5])
        NBKAssertRemoveSuffixCount(2, [1, 2, 3      ], [         4, 5])
        NBKAssertRemoveSuffixCount(3, [1, 2         ], [      3, 4, 5])
        NBKAssertRemoveSuffixCount(4, [1            ], [   2, 3, 4, 5])
        NBKAssertRemoveSuffixCount(5, [             ], [1, 2, 3, 4, 5])
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Remove Max Length
    //=------------------------------------------------------------------------=
    
    func testRemovePrefixMaxLength() {
        NBKAssertRemovePrefixMaxLength(0, [             ], [1, 2, 3, 4, 5])
        NBKAssertRemovePrefixMaxLength(1, [1            ], [   2, 3, 4, 5])
        NBKAssertRemovePrefixMaxLength(2, [1, 2         ], [      3, 4, 5])
        NBKAssertRemovePrefixMaxLength(3, [1, 2, 3      ], [         4, 5])
        NBKAssertRemovePrefixMaxLength(4, [1, 2, 3, 4   ], [            5])
        NBKAssertRemovePrefixMaxLength(5, [1, 2, 3, 4, 5], [             ])
        NBKAssertRemovePrefixMaxLength(6, [1, 2, 3, 4, 5], [             ])
        NBKAssertRemovePrefixMaxLength(7, [1, 2, 3, 4, 5], [             ])
        NBKAssertRemovePrefixMaxLength(8, [1, 2, 3, 4, 5], [             ])
        NBKAssertRemovePrefixMaxLength(9, [1, 2, 3, 4, 5], [             ])
    }
    
    func testRemoveSuffixMaxLength() {
        NBKAssertRemoveSuffixMaxLength(0, [1, 2, 3, 4, 5], [             ])
        NBKAssertRemoveSuffixMaxLength(1, [1, 2, 3, 4   ], [            5])
        NBKAssertRemoveSuffixMaxLength(2, [1, 2, 3      ], [         4, 5])
        NBKAssertRemoveSuffixMaxLength(3, [1, 2         ], [      3, 4, 5])
        NBKAssertRemoveSuffixMaxLength(4, [1            ], [   2, 3, 4, 5])
        NBKAssertRemoveSuffixMaxLength(5, [             ], [1, 2, 3, 4, 5])
        NBKAssertRemoveSuffixMaxLength(6, [             ], [1, 2, 3, 4, 5])
        NBKAssertRemoveSuffixMaxLength(7, [             ], [1, 2, 3, 4, 5])
        NBKAssertRemoveSuffixMaxLength(8, [             ], [1, 2, 3, 4, 5])
        NBKAssertRemoveSuffixMaxLength(9, [             ], [1, 2, 3, 4, 5])
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Utilities x Remove Count
//=----------------------------------------------------------------------------=

private func NBKAssertRemovePrefixCount(
_ count: Int, _ prefix: [Int], _ suffix: [Int],
file: StaticString = #file, line: UInt = #line) {
    var collection = (prefix + suffix)[...]
    let extraction = NBK.removePrefix(from: &collection, count: count)
    
    XCTAssertEqual(Array(extraction), prefix, file: file, line: line)
    XCTAssertEqual(Array(collection), suffix, file: file, line: line)
}

private func NBKAssertRemoveSuffixCount(
_ count: Int, _ prefix: [Int], _ suffix: [Int],
file: StaticString = #file, line: UInt = #line) {
    var collection = (prefix + suffix)[...]
    let extraction = NBK.removeSuffix(from: &collection, count: count)
    
    XCTAssertEqual(Array(collection), prefix, file: file, line: line)
    XCTAssertEqual(Array(extraction), suffix, file: file, line: line)
}

//=----------------------------------------------------------------------------=
// MARK: + Utilities x Remove Max Length
//=----------------------------------------------------------------------------=

private func NBKAssertRemovePrefixMaxLength(
_ maxLength: Int, _ prefix: [Int], _ suffix: [Int],
file: StaticString = #file, line: UInt = #line) {
    var collection = (prefix + suffix)[...]
    let extraction = NBK.removePrefix(from: &collection, maxLength: maxLength)
    
    XCTAssertEqual(Array(extraction), prefix, file: file, line: line)
    XCTAssertEqual(Array(collection), suffix, file: file, line: line)
}

private func NBKAssertRemoveSuffixMaxLength(
_ maxLength: Int, _ prefix: [Int], _ suffix: [Int],
file: StaticString = #file, line: UInt = #line) {
    var collection = (prefix + suffix)[...]
    let extraction = NBK.removeSuffix(from: &collection, maxLength: maxLength)
    
    XCTAssertEqual(Array(collection), prefix, file: file, line: line)
    XCTAssertEqual(Array(extraction), suffix, file: file, line: line)
}

#endif
