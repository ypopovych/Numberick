//=----------------------------------------------------------------------------=
// This source file is part of the Numberick open source project.
//
// Copyright (c) 2023 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if DEBUG

import XCTest
#if !COCOAPODS
import NBKCoreKit
#else
import Numberick
#endif

//*============================================================================*
// MARK: * NBK x Limbs x Bits
//*============================================================================*

final class NBKTestsOnLimbsByBits: XCTestCase {
    
    private typealias U64 = [UInt64]
    private typealias U32 = [UInt32]
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testLeadingZeroBitCount() {
        NBKAssertLeadingZeroBitCount ([              ] as U64, 000)
        NBKAssertLeadingZeroBitCount ([00            ] as U64, 064)
        NBKAssertLeadingZeroBitCount ([00, 00        ] as U64, 128)
        NBKAssertLeadingZeroBitCount ([00, 00, 00    ] as U64, 192)
        NBKAssertLeadingZeroBitCount ([00, 00, 00, 00] as U64, 256)
        
        NBKAssertLeadingZeroBitCount ([02            ] as U64, 062)
        NBKAssertLeadingZeroBitCount ([02, 00        ] as U64, 126)
        NBKAssertLeadingZeroBitCount ([02, 00, 00    ] as U64, 190)
        NBKAssertLeadingZeroBitCount ([02, 00, 00, 00] as U64, 254)
        
        NBKAssertLeadingZeroBitCount ([02            ] as U64, 062)
        NBKAssertLeadingZeroBitCount ([00, 02        ] as U64, 062)
        NBKAssertLeadingZeroBitCount ([00, 00, 02    ] as U64, 062)
        NBKAssertLeadingZeroBitCount ([00, 00, 00, 02] as U64, 062)
        
        NBKAssertLeadingZeroBitCount ([02, 00, 00, 00] as U64, 254)
        NBKAssertLeadingZeroBitCount ([00, 02, 00, 00] as U64, 190)
        NBKAssertLeadingZeroBitCount ([00, 00, 02, 00] as U64, 126)
        NBKAssertLeadingZeroBitCount ([00, 00, 00, 02] as U64, 062)
    }
    
    func testTrailingZeroBitCount() {
        NBKAssertTrailingZeroBitCount([              ] as U64, 000)
        NBKAssertTrailingZeroBitCount([00            ] as U64, 064)
        NBKAssertTrailingZeroBitCount([00, 00        ] as U64, 128)
        NBKAssertTrailingZeroBitCount([00, 00, 00    ] as U64, 192)
        NBKAssertTrailingZeroBitCount([00, 00, 00, 00] as U64, 256)
        
        NBKAssertTrailingZeroBitCount([02            ] as U64, 001)
        NBKAssertTrailingZeroBitCount([02, 00        ] as U64, 001)
        NBKAssertTrailingZeroBitCount([02, 00, 00    ] as U64, 001)
        NBKAssertTrailingZeroBitCount([02, 00, 00, 00] as U64, 001)
        
        NBKAssertTrailingZeroBitCount([02            ] as U64, 001)
        NBKAssertTrailingZeroBitCount([00, 02        ] as U64, 065)
        NBKAssertTrailingZeroBitCount([00, 00, 02    ] as U64, 129)
        NBKAssertTrailingZeroBitCount([00, 00, 00, 02] as U64, 193)
        
        NBKAssertTrailingZeroBitCount([02, 00, 00, 00] as U64, 001)
        NBKAssertTrailingZeroBitCount([00, 02, 00, 00] as U64, 065)
        NBKAssertTrailingZeroBitCount([00, 00, 02, 00] as U64, 129)
        NBKAssertTrailingZeroBitCount([00, 00, 00, 02] as U64, 193)
    }
    
    func testMostSignificantBitTwosComplementOf() {
        NBKAssertMostSignificantBit(twosComplementOf:[00, 00, 00, 00] as U64, false)
        NBKAssertMostSignificantBit(twosComplementOf:[~0, ~0, ~0, ~0] as U64, false)
        
        NBKAssertMostSignificantBit(twosComplementOf:[01, 00, 00, 00] as U64, true )
        NBKAssertMostSignificantBit(twosComplementOf:[~1, ~0, ~0, ~0] as U64, false)
        
        NBKAssertMostSignificantBit(twosComplementOf:[ 0,  0,  0, ~0/2 + 1] as U64, true) // Int256.min
        NBKAssertMostSignificantBit(twosComplementOf:[~0, ~0, ~0, ~0/2 + 0] as U64, true) // Int256.max
    }
    
    func testMostSignificantBitTwosComplementOfReturnsNilWhenLimbsIsEmpty() {
        NBKAssertMostSignificantBit(twosComplementOf:[  ] as U64, nil  )
        NBKAssertMostSignificantBit(twosComplementOf:[ 0] as U64, false)
        NBKAssertMostSignificantBit(twosComplementOf:[ 1] as U64, true )
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Nonzero Bit Count
    //=------------------------------------------------------------------------=
    
    func testNonzeroBitCountEquals() {
        NBKAssertNonzeroBitCount([              ] as U64, 00)
        NBKAssertNonzeroBitCount([00, 00, 00, 00] as U64, 00)
        NBKAssertNonzeroBitCount([01, 00, 00, 00] as U64, 01)
        NBKAssertNonzeroBitCount([01, 03, 00, 00] as U64, 03)
        NBKAssertNonzeroBitCount([01, 03, 07, 00] as U64, 06)
        NBKAssertNonzeroBitCount([01, 03, 07, 15] as U64, 10)
        NBKAssertNonzeroBitCount([00, 03, 07, 15] as U64, 09)
        NBKAssertNonzeroBitCount([00, 00, 07, 15] as U64, 07)
        NBKAssertNonzeroBitCount([00, 00, 00, 15] as U64, 04)
        NBKAssertNonzeroBitCount([00, 00, 15, 07] as U64, 07)
        NBKAssertNonzeroBitCount([15, 07, 03, 01] as U64, 10)
        NBKAssertNonzeroBitCount([07, 03, 01, 00] as U64, 06)
        NBKAssertNonzeroBitCount([03, 01, 00, 00] as U64, 03)
        NBKAssertNonzeroBitCount([01, 00, 00, 00] as U64, 01)
        NBKAssertNonzeroBitCount([00, 00, 00, 00] as U64, 00)
        
        NBKAssertNonzeroBitCount([01, 00, 00, 00] as U64, 01)
        NBKAssertNonzeroBitCount([00, 02, 00, 00] as U64, 01)
        NBKAssertNonzeroBitCount([00, 00, 04, 00] as U64, 01)
        NBKAssertNonzeroBitCount([00, 00, 00, 08] as U64, 01)
        
        NBKAssertNonzeroBitCount([01, 00, 00, 00] as U64, 01)
        NBKAssertNonzeroBitCount([00, 01, 00, 00] as U64, 01)
        NBKAssertNonzeroBitCount([00, 00, 01, 00] as U64, 01)
        NBKAssertNonzeroBitCount([00, 00, 00, 01] as U64, 01)
        
        NBKAssertNonzeroBitCount([01, 00, 00, 00] as U64, 00, false)
        NBKAssertNonzeroBitCount([00, 01, 00, 00] as U64, 00, false)
        NBKAssertNonzeroBitCount([00, 00, 01, 00] as U64, 00, false)
        NBKAssertNonzeroBitCount([00, 00, 00, 01] as U64, 00, false)
    }
    
    func testNonzeroBitCountTwosComplementOf() {
        NBKAssertNonzeroBitCount(twosComplementOf:[              ] as U64, 000)
        NBKAssertNonzeroBitCount(twosComplementOf:[00, 00, 00, 00] as U64, 000)
        NBKAssertNonzeroBitCount(twosComplementOf:[~0, ~0, ~0, ~0] as U64, 001)
        
        NBKAssertNonzeroBitCount(twosComplementOf:[00, 00, 00, 00] as U64, 000)
        NBKAssertNonzeroBitCount(twosComplementOf:[01, 00, 00, 00] as U64, 256)
        NBKAssertNonzeroBitCount(twosComplementOf:[01, 03, 00, 00] as U64, 254)
        NBKAssertNonzeroBitCount(twosComplementOf:[01, 03, 07, 00] as U64, 251)
        NBKAssertNonzeroBitCount(twosComplementOf:[01, 03, 07, 15] as U64, 247)
        NBKAssertNonzeroBitCount(twosComplementOf:[00, 03, 07, 15] as U64, 184)
        NBKAssertNonzeroBitCount(twosComplementOf:[00, 00, 07, 15] as U64, 122)
        NBKAssertNonzeroBitCount(twosComplementOf:[00, 00, 00, 15] as U64, 061)
        NBKAssertNonzeroBitCount(twosComplementOf:[00, 00, 15, 07] as U64, 122)
        NBKAssertNonzeroBitCount(twosComplementOf:[15, 07, 03, 01] as U64, 247)
        NBKAssertNonzeroBitCount(twosComplementOf:[07, 03, 01, 00] as U64, 251)
        NBKAssertNonzeroBitCount(twosComplementOf:[03, 01, 00, 00] as U64, 254)
        NBKAssertNonzeroBitCount(twosComplementOf:[01, 00, 00, 00] as U64, 256)
        NBKAssertNonzeroBitCount(twosComplementOf:[00, 00, 00, 00] as U64, 000)
    }
}

//*============================================================================*
// MARK: * NBK x Limbs x Bits x Assertions
//*============================================================================*

private func NBKAssertLeadingZeroBitCount(
_ limbs: [UInt64], _ result: Int,
file: StaticString = #file, line: UInt = #line) {
    //=------------------------------------------=
    XCTAssertEqual(NBK.leadingZeroBitCount(of: limbs), result, file: file, line: line)
}

private func NBKAssertTrailingZeroBitCount(
_ limbs: [UInt64], _ result: Int,
file: StaticString = #file, line: UInt = #line) {
    //=------------------------------------------=
    XCTAssertEqual(NBK.trailingZeroBitCount(of: limbs), result, file: file, line: line)
}

private func NBKAssertMostSignificantBit(
twosComplementOf limbs: [UInt64], _ bit: Bool?,
file: StaticString = #file, line: UInt = #line) {
    //=------------------------------------------=
    XCTAssertEqual(NBK.mostSignificantBit(twosComplementOf: limbs), bit, file: file, line: line)
}

//=----------------------------------------------------------------------------=
// MARK: + Nonzero Bit Count
//=----------------------------------------------------------------------------=

private func NBKAssertNonzeroBitCount(
_ limbs: [UInt64], _ comparand: Int, _ success: Bool = true,
file: StaticString = #file, line: UInt = #line) {
    //=------------------------------------------=
    if  success {
        XCTAssertEqual(NBK.nonzeroBitCount(of: limbs),         comparand + 0,  file: file, line: line)
        XCTAssertFalse(NBK.nonzeroBitCount(of: limbs,  equals: comparand + 1), file: file, line: line)
        XCTAssertFalse(NBK.nonzeroBitCount(of: limbs,  equals: comparand - 1), file: file, line: line)
    }
    //=------------------------------------------=
    XCTAssertEqual(NBK.nonzeroBitCount(of: limbs, equals: comparand), success, file: file, line: line)
}

private func NBKAssertNonzeroBitCount(
twosComplementOf limbs: [UInt64], _ result: Int,
file: StaticString = #file, line: UInt = #line) {
    //=------------------------------------------=
    XCTAssertEqual(NBK.nonzeroBitCount(twosComplementOf: limbs), result, file: file, line: line)
}

#endif
