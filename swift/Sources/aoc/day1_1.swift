class day1_1: IDay {
    var label: String { "day1:1" }
    var path: String { "input1" }
    var ll: [Int] = []
    var rl: [Int] = []
    
    func parseLine(_ line: String) {
        let (l, r) = line.splitOnce(" ")
        ll.append(l.int)
        rl.append(r.int)
    }
    
    func pipeline() throws -> Int {
        try read().forEach({parseLine($0)})
        ll.sort()
        rl.sort()
        return zip(ll, rl).map({(l, r) in abs(l - r)}).sum
    }
}
