class day1_2: day1_1 {
    override var label: String { "day1:2" }
    override var path: String { "test" }
    
    override func parseLine(_ line: String) -> Int {
        42
    }
    
    override func pipeline() throws -> Int {
        try read().map({parseLine($0)}).sum
    }
}
