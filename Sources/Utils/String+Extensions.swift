//
//  String+Extensions.swift
//  AdventOfCode
//
//  Created by Martin Václavík on 10.12.2025.
//

import Foundation

extension String {
  var characterGrid: [[Character]] {
    self.components(separatedBy: .newlines).characterGrid
  }
}
