import Algorithms
import DequeModule

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
      partialResult + getMaximumJoltage(for: bank, withLength: 2)
    }

    return total
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    let total = banks.reduce(0) { partialResult, bank in
      partialResult + getMaximumJoltage(for: bank, withLength: 12)
    }

    return total
  }

  private func getMaximumJoltage(for bank: String, withLength neededLength: Int) -> Int {
      let joltages = bank.compactMap { Int(String($0)) }

      let array = Array(joltages)
      var lookupEndIndex = array.endIndex - neededLength
      var queue = Array<Int>()

      var lookupStartIndex = 0
      while queue.count < neededLength && lookupStartIndex < lookupEndIndex {
        let lookupArray = array[lookupStartIndex...lookupEndIndex]
        if let lastFoundDigitIndex = lookupArray.firstIndex(of: lookupArray.max()!) {
          queue.append(array[lastFoundDigitIndex])
          lookupStartIndex = lastFoundDigitIndex + 1
          lookupEndIndex += 1
        }
      }
      queue.append(contentsOf: array[lookupEndIndex...])

      let value = Int(queue.map(String.init).joined())!
      return value
  }
}
