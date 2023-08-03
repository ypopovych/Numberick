//=----------------------------------------------------------------------------=
// This source file is part of the Numberick open source project.
//
// Copyright (c) 2023 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * NBK x Bits
//*============================================================================*

extension NBK {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    /// Returns the nonzero bit count of `limbs`.
    @inlinable public static func nonzeroBitCount(of limbs: some Collection<some NBKCoreInteger>) -> Int {
        limbs.reduce(Int.zero) { $0 + $1.nonzeroBitCount }
    }
    
    /// Returns whether the nonzero bit count of `limbs` equals `comparand`.
    @inlinable public static func nonzeroBitCount(of limbs: some Collection<some NBKCoreInteger>, equals comparand: Int) -> Bool {
        var count = Int()
        var index = limbs.startIndex
        
        accumulate: while index < limbs.endIndex, count <= comparand {
            count += limbs[index].nonzeroBitCount
            limbs.formIndex(after: &index)
        }
        
        return (count == comparand) as Bool
    }
    
    /// Returns the nonzero bit count for the two's complement of `limbs`.
    @inlinable public static func nonzeroBitCount(twosComplementOf limbs: some Collection<some NBKCoreInteger>) -> Int {
        guard let index = limbs.firstIndex(where:{ !$0.isZero }) else { return Int.zero }
        return limbs.indices[index...].reduce(1 - limbs[index].trailingZeroBitCount) { $0 + limbs[$1].onesComplement().nonzeroBitCount }
    }
}
