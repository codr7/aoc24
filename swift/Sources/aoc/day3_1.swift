class day3_1: IDay {
    var label: String { "day3:1" }
    var path: String { "input3" }

    let mul = /mul\((\d{1,3}),(\d{1,3})\)/
    var result: [Int] = []
    
    func parseLine(_ line: String) {
        var s = line
        
        while let m = s.firstMatch(of: mul) {
            result.append(Int(m.1)!*Int(m.2)!)
            s = String(s[m.range.upperBound...])
        }        
    }

    func pipeline() throws -> Int {
        try read().forEach(parseLine)
        return result.sum
    }
}
