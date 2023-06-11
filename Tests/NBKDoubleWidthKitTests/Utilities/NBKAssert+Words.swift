//=----------------------------------------------------------------------------=
// This source file is part of the Numberick open source project.
//
// Copyright (c) 2023 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import NBKCoreKit
import NBKDoubleWidthKit
import XCTest

//*============================================================================*
// MARK: * NBK x Assert x Words
//*============================================================================*

func NBKAssertWords<H: NBKFixedWidthInteger>(
_ integer: NBKDoubleWidth<H>, _ words: [UInt],
file: StaticString = #file, line: UInt = #line) {
    var integer: NBKDoubleWidth<H> = integer
    var generic: some RandomAccessCollection<UInt> & MutableCollection = integer
    
    XCTAssertEqual(Array(integer),       words, file: file, line: line)
    XCTAssertEqual(Array(integer.words), words, file: file, line: line)
    
    XCTAssertEqual(integer.withContiguousStorage({        Array($0) }), words, file: file, line: line)
    XCTAssertEqual(integer.withContiguousMutableStorage({ Array($0) }), words, file: file, line: line)
    
    XCTAssertEqual(integer.withContiguousStorageIfAvailable({        Array($0) }), words, file: file, line: line)
    XCTAssertEqual(integer.withContiguousMutableStorageIfAvailable({ Array($0) }), words, file: file, line: line)
    
    XCTAssertEqual(generic.withContiguousStorageIfAvailable({        Array($0) }), words, file: file, line: line)
    XCTAssertEqual(generic.withContiguousMutableStorageIfAvailable({ Array($0) }), words, file: file, line: line)
}

func NBKAssertMinLastIndexReportingIsZeroOrMinusOne<H: NBKFixedWidthInteger>(
_ integer: NBKDoubleWidth<H>, _ minLastIndex: Int, _ isZeroOrMinusOne: Bool,
file: StaticString = #file, line: UInt = #line) {
    let result = integer.minLastIndexReportingIsZeroOrMinusOne()
    
    XCTAssertEqual(result.minLastIndex,     minLastIndex,     file: file, line: line)
    XCTAssertEqual(result.isZeroOrMinusOne, isZeroOrMinusOne, file: file, line: line)
}
