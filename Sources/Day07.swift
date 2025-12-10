import Algorithms

struct Day07: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var input: [String] {
    data
      .trimmingCharacters(in: .whitespacesAndNewlines)
      .components(separatedBy: .newlines)
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    let characterGrid = input.characterGrid
    let firstBeamIndex = characterGrid.first!.firstIndex(of: "S")!

    var counter = 0

    var beamIndexes = Set([firstBeamIndex])

    for line in characterGrid.dropFirst() {
      for (index, character) in line.enumerated() where character == "^" {
        if beamIndexes.contains(index) {
          beamIndexes.insert(line.index(before: index))
          beamIndexes.insert(line.index(after: index))
          beamIndexes.remove(index)
          counter += 1
        }
      }
    }

    return counter
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    let characterGrid = input.map { $0.map(\.self) }
    let firstBeamIndex = characterGrid.first!.firstIndex(of: "S")!

    var beamIndexes = Set([firstBeamIndex])
    var splitters = Set<Point>()
    var cache = [Point: Int]()

    for (lineIndex, line) in characterGrid.enumerated() {
      for (index, character) in line.enumerated() where character == "^" {
        if beamIndexes.contains(index) {
          let splitter = Point(x: index, y: lineIndex)
          splitters.insert(splitter)
          if cache.isEmpty { cache[splitter] = 1 }

          beamIndexes.insert(line.index(before: index))
          beamIndexes.insert(line.index(after: index))
          beamIndexes.remove(index)
        }
      }
    }

    func getTotal(for splitter: Point) -> Int {
      if cache[splitter] != nil { return cache[splitter]!}

      let topY = splitters.filter { $0.x == splitter.x && $0.y < splitter.y }.map(\.y).max()
      let beamOrigins = splitters.filter { p in
        (p.x == splitter.x - 1 || p.x == splitter.x + 1) && p.y > topY ?? 0 && p.y < splitter.y
      }
      if beamOrigins.isEmpty { return 0 }

      let result = beamOrigins.reduce(0) { partialResult, p in
        partialResult + getTotal(for: p)
      }
      cache[splitter] = result
      return result
    }

    let lastLine = input.last!

    let total = lastLine.enumerated().reduce(0) { (partialResult, enumeration) in
      let point = Point(x: enumeration.offset, y: input.count)
      return getTotal(for: point) + partialResult
    }

    return total
    }
}
