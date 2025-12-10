//
//  Array+Extensions.swift
//  AdventOfCode
//
//  Created by Martin Václavík on 10.12.2025.
//

import Foundation

extension Array where Element == String {
  var characterGrid: [[Character]] { self.map { $0.map(\.self) } }
}
