class day5_1: IDay {
    var label: String { "day5:1" }
    var path: String { "input5" }

    typealias Rule = (Int, Int)
    typealias Update = [Int]

    var rules: [Rule] = []
    var updates: [Update] = []
    
    func parseRule(_ line: String) {
        let (x, y) = line.splitOnce("|")
        rules.append((x.int, y.int))
    }

    func parseUpdate(_ line: String) {
        updates.append(line.split(",").map({$0.int}))
    }

    func parseLine(_ line: String) {
        line.contains("|") ? parseRule(line) : parseUpdate(line)
    }

    func parseLines() throws { try read().forEach(parseLine) }

    func isOrdered(_ update: Update) -> Bool {
        rules.allSatisfy(
          {(x, y) in
              if let i = update.firstIndex(of: x),
                 let j = update.firstIndex(of: y) {i < j}
              else {true}
          })
    }
    
    func pipeline() throws -> Int {
        try parseLines()
        return updates.filter(isOrdered).map({$0[$0.count/2]}).sum
    }
}
