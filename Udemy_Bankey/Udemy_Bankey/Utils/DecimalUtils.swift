//
//  DecimalUtils.swift
//  Udemy_Bankey
//
//  Created by 순진이 on 2022/11/14.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal:self).doubleValue
    }
}
