//
//  CustomOperators.swift
//  RemindersSwiftUICoreData
//
//  Created by Cause I'm Electric on 3/12/24.
//

import Foundation
import SwiftUI

public func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}
