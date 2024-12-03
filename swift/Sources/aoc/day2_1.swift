class day2_1: IDay {
    var label: String { "day2:1" }
    var path: String { "input2" }

    typealias Report = [Int]
    
    func parseLine(_ line: String) -> Report {
        line.split(separator: " ").map({Int($0)!})
    }

    func isSafe(_ report: Report) -> Bool {
        var pn = report[0]
        let s = (report[1] - pn).sign
        
        for n in report[1...] {
            let d = n - pn
            let ad = abs(d)
            if ad < 1 || ad > 3 || d.sign != s { return false }
            pn = n
        }

        return true
    }
    
    func pipeline() throws -> Int {
        try read().map(parseLine).filter(isSafe).count
    }
}
