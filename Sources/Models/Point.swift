//
//  Point.swift
//  AdventOfCode
//
//  Created by Martin Václavík on 10.12.2025.
//

import Foundation

struct Point: Hashable, CustomStringConvertible {
  let x: Int
  let y: Int

  var description: String { "(x: \(x), y: \(y))" }
}
