//
//  String+Extensions.swift
//  RemindersSwiftUICoreData
//
//  Created by Cause I'm Electric on 3/7/24.
//

import Foundation

extension String {
    var isEmptyOrWhitespace: Bool { return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
}
