import Algorithms

struct Day03: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var banks: [String] {
    data
      .trimmingCharacters(in: .whitespacesAndNewlines)
      .components(separatedBy: .newlines)
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    let total = banks.reduce(0) { partialResult, bank in
      let joltages = bank.compactMap { Int(String($0)) }
      let largestIndex = joltages.firstIndex(of: joltages.max() ?? 0) ?? 0

      let largestJoltage = joltages[largestIndex]
      let secondLargest = joltages[largestIndex+1..<joltages.endIndex].max()

      let compound: String
      guard let secondLargest else {
        let secondLargest = joltages[0..<largestIndex].max() ?? 0
        compound = "\(secondLargest)\(largestJoltage)"
        return partialResult + (Int(compound) ?? 0)
      }

      compound = "\(largestJoltage)\(secondLargest)"
      return partialResult + (Int(compound) ?? 0)
    }

    return total
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    let total = banks.reduce(0) { partialResult, bank in
      let joltages = bank.compactMap { Int(String($0)) }
      let neededLength = 12
      var indexes = Set<Array<Int>.Index>()
      var mutable = joltages

      repeat {
        let remainingDigits = neededLength - indexes.count
        // find largest digit not in indexSet
        let maxValue = mutable.max()!
        // try to find all candidates using the digit elsewhere
        var candidates = [(String, Set<Array<Int>.Index>)]()
        var currentIndex = 0
        while let maxAltIndex = mutable[currentIndex...].firstIndex(of: maxValue) {
          var tempAltIndexes = indexes
          tempAltIndexes.insert(maxAltIndex)
          let numberTwo = tempAltIndexes.sorted().map { joltages[$0].description }.joined().description

          if let firstAlreadySelectedIndex = indexes.min(),
             maxAltIndex < firstAlreadySelectedIndex,
             mutable[maxAltIndex] < joltages[firstAlreadySelectedIndex] {
            if joltages[(firstAlreadySelectedIndex + 1)...].filter { $0 != 0 }.count >= remainingDigits {
              mutable[maxAltIndex] = 0
              currentIndex = maxAltIndex + 1
              continue
            }
          }
          // value is lower then first already selected value
          // we can complete by using indexes after maxAltIndex

          candidates.append((numberTwo, tempAltIndexes))
          currentIndex = maxAltIndex + 1
        }

        // compare all candidates and choose max
        let asd = candidates
        guard let biggest = asd.max(by: {
          (Int($0.0) ?? 0) < (Int($1.0) ?? 0)
        }) else { continue }

        let joltage = mutable.map(\.description).joined().description
        print(joltage)
        print(candidates.map(\.0))
        print(biggest.0)
        indexes = biggest.1

        // repeat until found 12 indexes
        indexes.forEach { i in
          mutable[i] = 0
        }
      } while indexes.count < neededLength

      let joltage = indexes.sorted().map { joltages[$0].description }.joined().description
      return partialResult + (Int(joltage) ?? 0)
    }

    return total
  }
}
