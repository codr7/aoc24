class day3_2: day3_1 {
    override var label: String { "day3:2" }
    var enabled = true
    
    override func parseLine(_ line: String) {
        var s = line

        while true {
            if let m = s.firstMatch(of: [mul, /do\(()()\)/, /don't\(()()\)/]) {
                switch m.0[2] {
                case "(":
                    enabled = true
                case "n":
                    enabled = false
                default:
                    if enabled { result.append(Int(m.1)!*Int(m.2)!) }
                }
                
                s = String(s[m.range.upperBound...])
            } else {
                break
            }
        }
    }
}
