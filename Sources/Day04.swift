import Algorithms
import DequeModule

struct Day04: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var lines: [String] {
    data
      .trimmingCharacters(in: .whitespacesAndNewlines)
      .components(separatedBy: .newlines)
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    var temp = lines.map { $0.map { $0 } }

    let lines = lines.map { $0.map { $0 == "@" } }
    let rows = lines.count
    let colls = lines.first!.count

    var counter = 0
    for row in 0..<rows {
      for coll in 0..<colls {
        guard lines[row][coll] else { continue }

        let topLeft = row > 0 && coll > 0 ? lines[row-1][coll-1] : false
        let top = row > 0 ? lines[row-1][coll] : false
        let topRight = row > 0 && coll < colls-1 ? lines[row-1][coll+1] : false

        let rowLeft = coll > 0 ? lines[row][coll-1] : false
        let rowRight = coll < colls-1 ? lines[row][coll+1] : false

        let botLeft = row < rows-1 && coll > 0 ? lines[row+1][coll-1] : false
        let bot = row < rows-1 ? lines[row+1][coll] : false
        let botRight = row < rows-1 && coll < colls-1 ? lines[row+1][coll+1] : false

        let validCount = [topLeft, top, topRight, rowLeft, rowRight, botLeft, bot, botRight].filter(\.self).count
        if validCount < 4 {
          counter += 1
//          temp[row][coll] = "x"
        }
      }
    }

//    temp.forEach { row in
//      print(row.map(String.init).joined())
//    }

    return counter
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    var lines = lines.map { $0.map { $0 == "@" } }
    let rows = lines.count
    let colls = lines.first!.count

    var counter = 0

    var didRemove = false
    repeat {
      didRemove = false
      for row in 0..<rows {
        for coll in 0..<colls {
          guard lines[row][coll] else { continue }

          let topLeft = row > 0 && coll > 0 ? lines[row-1][coll-1] : false
          let top = row > 0 ? lines[row-1][coll] : false
          let topRight = row > 0 && coll < colls-1 ? lines[row-1][coll+1] : false

          let rowLeft = coll > 0 ? lines[row][coll-1] : false
          let rowRight = coll < colls-1 ? lines[row][coll+1] : false

          let botLeft = row < rows-1 && coll > 0 ? lines[row+1][coll-1] : false
          let bot = row < rows-1 ? lines[row+1][coll] : false
          let botRight = row < rows-1 && coll < colls-1 ? lines[row+1][coll+1] : false

          let validCount = [topLeft, top, topRight, rowLeft, rowRight, botLeft, bot, botRight].filter(\.self).count
          if validCount < 4 {
            counter += 1
            lines[row][coll] = false
            didRemove = true
          }
        }
      }
    } while didRemove

    return counter
  }
}
