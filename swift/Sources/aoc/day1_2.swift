class day1_2: day1_1 {
    override var label: String { "day1:2" }
    
    override func pipeline() throws -> Int {
        try read().forEach(parseLine)
        return ll.map({l in l*rl.filter({r in l == r}).count}).sum
    }
}
