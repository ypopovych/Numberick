//=----------------------------------------------------------------------------=
// This source file is part of the Numberick open source project.
//
// Copyright (c) 2023 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * NBK x Limbs x Division x Digit x Unsigned
//*============================================================================*

extension NBK {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    /// Returns the `remainder` of dividing the `dividend` by the `divisor`,
    /// along with an `overflow` indicator.
    ///
    /// - Note: This operation interprets empty collections as zero.
    ///
    /// - Note: In the case of `overflow`, the result is `dividend.first`.
    ///
    @inlinable public static func remainderReportingOverflowAsLenientUnsignedInteger<T>(
    of dividend: T, dividingBy divisor: T.Element) -> PVO<T.Element>
    where T: BidirectionalCollection, T.Element: NBKFixedWidthInteger & NBKUnsignedInteger {
        //=--------------------------------------=
        if  divisor.isZero {
            return PVO(dividend.first ?? T.Element.zero, true)
        }
        //=--------------------------------------=
        var remainder = T.Element.zero
        
        for index in dividend.indices.reversed() {
            remainder = divisor.dividingFullWidth(HL(remainder, dividend[index])).remainder
        }
        
        return PVO(remainder, false)
    }
    
    /// Forms the `quotient` of dividing the `dividend` by the `divisor`,
    /// and returns the `remainder` along with an `overflow` indicator.
    ///
    /// - Note: This operation interprets empty collections as zero.
    ///
    /// - Note: In the case of `overflow`, the result is `dividend` and `dividend.first`.
    ///
    @inlinable public static func formQuotientWithRemainderReportingOverflowAsLenientUnsignedInteger<T>(
    of dividend: inout T, dividingBy divisor: T.Element) -> PVO<T.Element>
    where T: BidirectionalCollection & MutableCollection, T.Element: NBKFixedWidthInteger & NBKUnsignedInteger {
        //=--------------------------------------=
        if  divisor.isZero {
            return PVO(dividend.first ?? T.Element.zero, true)
        }
        //=--------------------------------------=
        var remainder = T.Element.zero
        
        for index in dividend.indices.reversed() {
            (dividend[index], remainder) = divisor.dividingFullWidth(HL(remainder, dividend[index]))
        }
        
        return PVO(remainder, false)
    }
}
