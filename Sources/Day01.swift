import Algorithms

struct Day01: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: [String] {
    data.components(separatedBy: .newlines)
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    // Calculate the sum of the first set of input data
    var position = 50

    var counter = 0
    for entity in entities {
      let isLeft = entity.starts(with: "L")
      let rotation = (Int(String(entity.dropFirst())) ?? 0) % 100
      if isLeft {
        position -= rotation
        if position < 0 { position += 100 }
      } else {
        position += rotation
        if position > 99 { position -= 100 }
      }
      counter += position == 0 ? 1 : 0
    }
    return counter
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    // Calculate the sum of the first set of input data
    var dialPosition = 50
    let range = 0...99
    var counter = 0

    for entity in entities {
      let isLeft = entity.starts(with: "L")
      guard var rotation = Int(String(entity.dropFirst())) else { continue }

      while rotation > 0 {
        if isLeft { dialPosition -= 1 } else { dialPosition += 1 }
        rotation -= 1

        if dialPosition > range.upperBound { dialPosition = 0 }
        if dialPosition < range.lowerBound { dialPosition = 99 }

        if dialPosition == 0 { counter += 1 }
      }
    }
    
    return counter // 6911
  }
}
