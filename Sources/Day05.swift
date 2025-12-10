import Algorithms

struct Day05: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var input: (freshIds: [ClosedRange<Int>], ingredients: [Int]) {
    let ranges = data
      .components(separatedBy: .newlines)
      .filter { $0.contains("-") }
      .map { line in
        let bounds = line.split(separator: "-").compactMap { Int(String($0)) }
        let lowerBound = bounds.min()!
        let upperBound = bounds.max()!
        return lowerBound...upperBound
      }

    let idS = data
      .components(separatedBy: .newlines)
      .filter { !$0.contains("-") && !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }.compactMap { Int(String($0)) }

    return (ranges, idS)
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    return input.ingredients.reduce(0) { partialResult, id in
      if input.freshIds.contains { $0.contains(id) } {
        return partialResult + 1
      }

      return partialResult
    }
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    var currentRanges = Set<ClosedRange<Int>>()

    input.freshIds.forEach { range in
      let overlappingRange = currentRanges.first(where: { $0.overlaps(range) })

      if let overlappingRange {
        currentRanges.remove(overlappingRange)
        currentRanges.insert(min(overlappingRange.lowerBound, range.lowerBound)...max(overlappingRange.upperBound, range.upperBound))
      } else {
        currentRanges.insert(range)
      }
    }

    var didMerge = false
    repeat {
      didMerge = false
      currentRanges.forEach { range in
        let overlappingRange = currentRanges.first(where: { $0 != range && $0.overlaps(range) })

        if let overlappingRange {
          currentRanges.remove(overlappingRange)
          currentRanges.insert(min(overlappingRange.lowerBound, range.lowerBound)...max(overlappingRange.upperBound, range.upperBound))
          didMerge = true
        }
      }
    } while didMerge

    return currentRanges.reduce(0) { partialResult, range in
      range.count + partialResult
    }
  }
}
