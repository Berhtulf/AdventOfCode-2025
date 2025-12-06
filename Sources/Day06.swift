import Algorithms

struct Day06: AdventDay {
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
    let lastIndex = input.index(before: input.endIndex)
    let operations = input[lastIndex].components(separatedBy: .whitespaces).filter { !$0.isEmpty }

    let numbers = input[..<lastIndex].map { $0.components(separatedBy: .whitespaces).filter { !$0.isEmpty } }

    var results = numbers[0].compactMap(Int.init)

    for row in 1..<numbers.count {
      for operation in 0..<operations.count {
        if operations[operation] == "*" {
          results[operation] *= Int(numbers[row][operation]) ?? 1
        } else if operations[operation] == "+" {
          results[operation] += Int(numbers[row][operation]) ?? 0
        }
      }
    }

    return results.reduce(0, +)
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    let lastIndex = input.index(before: input.endIndex)
    let operations = input[lastIndex].components(separatedBy: .whitespaces).filter { !$0.isEmpty }

    let lines = input[..<lastIndex].map { Array($0) }

    var transposed = [String]()
    for column in 0..<lines.first!.count {
      var transposedRow = [Character]()
      for row in 0..<lines.count {
        transposedRow.append(lines[row][column])
      }
      let rowString = String(transposedRow)
      transposed.append(rowString)
    }

    let groups = transposed
      .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
      .split(separator: "")
      .map { slice in
        slice.compactMap(Int.init)
      }

    var total = 0
    for index in operations.indices {
      let op = operations[index]
      let group = groups[index]
      
      if op == "*" {
        total += group.reduce(1, *)
      } else if op == "+" {
        total += group.reduce(0, +)
      }
    }

    return total
    }
}
