import Testing

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
struct Day03Tests {
  // Smoke test data provided in the challenge question
  let testData = """
    987654321111111
    811111111111119
    234234234234278
    818181911112111
    """

  @Test func testPart1() async throws {
    let challenge = Day03(data: testData)
    #expect(String(describing: challenge.part1()) == "357")
  }

  @Test func testPart2() async throws {
    let challenge = Day03(data: testData)
    #expect(String(describing: challenge.part2()) == "3121910778619")
  }

  @Test func testPart2a() async throws {
    let challenge = Day03(data: "4186216451718762816417959278169451")
    #expect(String(describing: challenge.part2()) == "959278169451")
  }

  @Test func testPart2b() async throws {
    let challenge = Day03(data: "27586298372587263982569236922936256923")
    #expect(String(describing: challenge.part2()) == "999996256923")
  }
}
