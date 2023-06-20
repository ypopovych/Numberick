//=----------------------------------------------------------------------------=
// This source file is part of the Numberick open source project.
//
// Copyright (c) 2023 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if !DEBUG

import NBKCoreKit
import NBKDoubleWidthKit
import XCTest

private typealias X = NBK.U256X64
private typealias Y = NBK.U256X32

//*============================================================================*
// MARK: * NBK x Int256 x Text
//*============================================================================*

final class Int256BenchmarksOnText: XCTestCase {
    
    typealias T = Int256
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    static var decoded = NBK.blackHoleIdentity(T(encoded, radix: 16)!)
    static var encoded = NBK.blackHoleIdentity(String(repeating: "1", count: 64))
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testDecodingRadix10() {
        var radix   = NBK.blackHoleIdentity(10)
        var encoded = NBK.blackHoleIdentity(Self.encoded)
        
        for _ in 0 ..< 250_000 {
            NBK.blackHole(T(encoded, radix: radix)!)
            NBK.blackHoleInoutIdentity(&radix)
            NBK.blackHoleInoutIdentity(&encoded)
        }
    }
    
    func testDecodingRadix16() {
        var radix   = NBK.blackHoleIdentity(16)
        var encoded = NBK.blackHoleIdentity(Self.encoded)
        
        for _ in 0 ..< 250_000 {
            NBK.blackHole(T(encoded, radix: radix)!)
            NBK.blackHoleInoutIdentity(&radix)
            NBK.blackHoleInoutIdentity(&encoded)
        }
    }
    
    func testEncodingRadix10() {
        var radix   = NBK.blackHoleIdentity(10)
        var decoded = NBK.blackHoleIdentity(Self.decoded)
        
        for _ in 0 ..< 250_000 {
            NBK.blackHole(String(decoded, radix: radix))
            NBK.blackHoleInoutIdentity(&radix)
            NBK.blackHoleInoutIdentity(&decoded)
        }
    }
    
    func testEncodingRadix16() {
        var radix   = NBK.blackHoleIdentity(16)
        var decoded = NBK.blackHoleIdentity(Self.decoded)
        
        for _ in 0 ..< 250_000 {
            NBK.blackHole(String(decoded, radix: radix))
            NBK.blackHoleInoutIdentity(&radix)
            NBK.blackHoleInoutIdentity(&decoded)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Swift Standard Library Methods
    //=------------------------------------------------------------------------=
    
    func testDecodingUsingSwiftStdlibRadix10() {
        var radix   = NBK.blackHoleIdentity(10)
        var encoded = NBK.blackHoleIdentity(Self.encoded)
        
        for _ in 0 ..< 50_000 {
            NBK.blackHole(T.stdlib(encoded, radix: radix)!)
            NBK.blackHoleInoutIdentity(&radix)
            NBK.blackHoleInoutIdentity(&encoded)
        }
    }
    
    func testDecodingUsingSwiftStdlibRadix16() {
        var radix   = NBK.blackHoleIdentity(16)
        var encoded = NBK.blackHoleIdentity(Self.encoded)
        
        for _ in 0 ..< 50_000 {
            NBK.blackHole(T.stdlib(encoded, radix: radix)!)
            NBK.blackHoleInoutIdentity(&radix)
            NBK.blackHoleInoutIdentity(&encoded)
        }
    }
    
    func testEncodingUsingSwiftStdlibRadix10() {
        var radix   = NBK.blackHoleIdentity(10)
        var decoded = NBK.blackHoleIdentity(Self.decoded)
        
        for _ in 0 ..< 1_000 {
            NBK.blackHole(String.stdlib(decoded, radix: radix))
            NBK.blackHoleInoutIdentity(&radix)
            NBK.blackHoleInoutIdentity(&decoded)
        }
    }
    
    func testEncodingUsingSwiftStdlibRadix16() {
        var radix   = NBK.blackHoleIdentity(16)
        var decoded = NBK.blackHoleIdentity(Self.decoded)
        
        for _ in 0 ..< 1_000 {
            NBK.blackHole(String.stdlib(decoded, radix: radix))
            NBK.blackHoleInoutIdentity(&radix)
            NBK.blackHoleInoutIdentity(&decoded)
        }
    }
}

//*============================================================================*
// MARK: * NBK x UInt256 x Text
//*============================================================================*

final class UInt256BenchmarksOnText: XCTestCase {
    
    typealias T = UInt256
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    static var decoded = NBK.blackHoleIdentity(T(encoded, radix: 16)!)
    static var encoded = NBK.blackHoleIdentity(String(repeating: "1", count: 64))
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testDecodingRadix10() {
        var radix   = NBK.blackHoleIdentity(10)
        var encoded = NBK.blackHoleIdentity(Self.encoded)
        
        for _ in 0 ..< 250_000 {
            NBK.blackHole(T(encoded, radix: radix)!)
            NBK.blackHoleInoutIdentity(&radix)
            NBK.blackHoleInoutIdentity(&encoded)
        }
    }
    
    func testDecodingRadix16() {
        var radix   = NBK.blackHoleIdentity(16)
        var encoded = NBK.blackHoleIdentity(Self.encoded)
        
        for _ in 0 ..< 250_000 {
            NBK.blackHole(T(encoded, radix: radix)!)
            NBK.blackHoleInoutIdentity(&radix)
            NBK.blackHoleInoutIdentity(&encoded)
        }
    }
    
    func testEncodingRadix10() {
        var radix   = NBK.blackHoleIdentity(10)
        var decoded = NBK.blackHoleIdentity(Self.decoded)
        
        for _ in 0 ..< 250_000 {
            NBK.blackHole(String(decoded, radix: radix))
            NBK.blackHoleInoutIdentity(&radix)
            NBK.blackHoleInoutIdentity(&decoded)
        }
    }
    
    func testEncodingRadix16() {
        var radix   = NBK.blackHoleIdentity(16)
        var decoded = NBK.blackHoleIdentity(Self.decoded)
        
        for _ in 0 ..< 250_000 {
            NBK.blackHole(String(decoded, radix: radix))
            NBK.blackHoleInoutIdentity(&radix)
            NBK.blackHoleInoutIdentity(&decoded)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Swift Standard Library Methods
    //=------------------------------------------------------------------------=
    
    func testDecodingUsingSwiftStdlibRadix10() {
        var radix   = NBK.blackHoleIdentity(10)
        var encoded = NBK.blackHoleIdentity(Self.encoded)
        
        for _ in 0 ..< 50_000 {
            NBK.blackHole(T.stdlib(encoded, radix: radix)!)
            NBK.blackHoleInoutIdentity(&radix)
            NBK.blackHoleInoutIdentity(&encoded)
        }
    }
    
    func testDecodingUsingSwiftStdlibRadix16() {
        var radix   = NBK.blackHoleIdentity(16)
        var encoded = NBK.blackHoleIdentity(Self.encoded)
        
        for _ in 0 ..< 50_000 {
            NBK.blackHole(T.stdlib(encoded, radix: radix)!)
            NBK.blackHoleInoutIdentity(&radix)
            NBK.blackHoleInoutIdentity(&encoded)
        }
    }
    
    func testEncodingUsingSwiftStdlibRadix10() {
        var radix   = NBK.blackHoleIdentity(10)
        var decoded = NBK.blackHoleIdentity(Self.decoded)
        
        for _ in 0 ..< 1_000 {
            NBK.blackHole(String.stdlib(decoded, radix: radix))
            NBK.blackHoleInoutIdentity(&radix)
            NBK.blackHoleInoutIdentity(&decoded)
        }
    }
    
    func testEncodingUsingSwiftStdlibRadix16() {
        var radix   = NBK.blackHoleIdentity(16)
        var decoded = NBK.blackHoleIdentity(Self.decoded)
        
        for _ in 0 ..< 1_000 {
            NBK.blackHole(String.stdlib(decoded, radix: radix))
            NBK.blackHoleInoutIdentity(&radix)
            NBK.blackHoleInoutIdentity(&decoded)
        }
    }
}

#endif
