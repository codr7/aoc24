class day3_1: IDay {
    var label: String { "day3:1" }
    var path: String { "test" }

    func parseLine(_ line: String) -> Int {
        42
    }

    func pipeline() throws -> Int {
        try read().map({parseLine($0)}).sum
    }
}