//=----------------------------------------------------------------------------=
// This source file is part of the Numberick open source project.
//
// Copyright (c) 2023 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import NBKCoreKit

//*============================================================================*
// MARK: * NBK x Double Width x Multiplication
//*============================================================================*

extension NBKDoubleWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func multiplyReportingOverflow(by  amount: Self) -> Bool {
        let pvo: PVO<Self> = self.multipliedReportingOverflow(by: amount)
        self = pvo.partialValue
        return pvo.overflow as Bool
    }
    
    @inlinable public func multipliedReportingOverflow(by amount: Self) -> PVO<Self> {
        let minus: Bool = self.isLessThanZero != amount.isLessThanZero
        let unsigned: PVO<Magnitude> = self.magnitude.multipliedReportingOverflow(by: amount.magnitude)
        let product = Self(bitPattern: minus ? unsigned.partialValue.twosComplement() : unsigned.partialValue)
        return PVO(product, unsigned.overflow || (minus ? product.isMoreThanZero : product.isLessThanZero))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Full Width
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func multiplyFullWidth(by amount: Self) -> Self {
        let product: HL<Self, Magnitude> = self.multipliedFullWidth(by: amount)
        self = Self(bitPattern: product.low)
        return product.high as Self
    }
    
    @inlinable public func multipliedFullWidth(by amount: Self) -> HL<Self, Magnitude> {
        let minus = self.isLessThanZero != amount.isLessThanZero
        var product = DoubleWidth.Magnitude(descending: self.magnitude.multipliedFullWidth(by: amount.magnitude))
        if  minus { product.formTwosComplement() }
        return HL(Self(bitPattern: product.high), product.low)
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Unsigned
//=----------------------------------------------------------------------------=

extension NBKDoubleWidth where High == High.Magnitude {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable internal func multipliedReportingOverflow(by amount: Self) -> PVO<Self> {
        //=--------------------------------------=
        var ax = self.low .multipliedFullWidth(by: amount.low)
        let ay = self.low .multipliedReportingOverflow(by: amount.high )
        let bx = self.high.multipliedReportingOverflow(by: amount.low  )
        //=--------------------------------------=
        let o0 = ax.high.addReportingOverflow(ay.partialValue)
        let o1 = ax.high.addReportingOverflow(bx.partialValue)
        //=--------------------------------------=
        let complete = !self.high.isZero && !amount.high.isZero
        let overflow =  complete || ay.overflow || bx.overflow || o0 || o1
        return PVO(Self(descending: ax), overflow)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Full Width
    //=------------------------------------------------------------------------=
    
    @inlinable internal func multipliedFullWidth(by amount: Self) -> HL<Self, Magnitude> {
        //=--------------------------------------=
        let m0 = self.low .multipliedFullWidth(by: amount.low ) as HL<Low, Low>
        let m1 = self.low .multipliedFullWidth(by: amount.high) as HL<Low, Low>
        let m2 = self.high.multipliedFullWidth(by: amount.low ) as HL<Low, Low>
        let m3 = self.high.multipliedFullWidth(by: amount.high) as HL<Low, Low>
        //=--------------------------------------=
        let s0 = Low.sum(m0.high, m1.low,  m2.low) as HL<UInt, Low>
        let s1 = Low.sum(m1.high, m2.high, m3.low) as HL<UInt, Low>
        //=--------------------------------------=
        let p0 = Self(descending: HL(s0.low,  m0.low))
        var p1 = Self(descending: HL(m3.high, s1.low))
        let _  = p1.addReportingOverflow(s0.high)
        let _  = p1.high.addReportingOverflow(s1.high)
        //=--------------------------------------=
        return HL(high: p1, low: p0)
    }
}
