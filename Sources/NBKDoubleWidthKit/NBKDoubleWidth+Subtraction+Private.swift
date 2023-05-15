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
// MARK: * NBK x Double Width x Subtraction x Private
//*============================================================================*
//=----------------------------------------------------------------------------=
// MARK: + Unsigned
//=----------------------------------------------------------------------------=

extension NBKDoubleWidth where High == High.Magnitude {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable internal mutating func subtractReportingOverflowByHalf(_ amount: Low) -> Bool {
        let o = self.low .subtractReportingOverflow(amount)
        if !o { return false }
        return  self.high.subtractReportingOverflow(1 as UInt)
    }
    
    @inlinable internal func subtractingReportingOverflowByHalf(_ amount: Low) -> PVO<Self> {
        var partialValue = self
        let overflow: Bool = partialValue.subtractReportingOverflowByHalf(amount)
        return PVO(partialValue, overflow)
    }
}
