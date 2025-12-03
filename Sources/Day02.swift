import Algorithms

struct Day02: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: [ClosedRange<Int>] {
    let ranges = data.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: ",").filter { !$0.isEmpty }
    return ranges.compactMap { range in
      let bounds = range.components(separatedBy: "-").compactMap(Int.init)
      return bounds[0]...bounds[1]
    }
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    var counter  = 0
    for entity in entities {
      for value in entity {
        let stringRepresentation = String(describing: value)

        let chunks = stringRepresentation.evenlyChunked(in: 2)
        if chunks.first == chunks.last {
          counter += value
        }
      }
    }
    return counter
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    var counter  = 0
    for entity in entities {
      entity: for value in entity {
        let stringRepresentation = String(describing: value)
        var sequence = ""

        for char in stringRepresentation {
          sequence.append(char)
          if sequence == stringRepresentation {
            continue entity
          }

          if sequence.count > stringRepresentation.count / 2 {
            continue entity
          }

          if !stringRepresentation.count.isMultiple(of: sequence.count) {
            continue
          }

          let regex = try! Regex(sequence)
          let maximumMatches = stringRepresentation.count / sequence.count
          if stringRepresentation.matches(of: regex).count == maximumMatches {
            counter += value
            break
          }
        }
      }
    }
    return counter // 38.11417491700001
  }
}
