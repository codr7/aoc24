class day3_2: day3_1 {
    override var label: String { "day3:2" }
    var enabled = true
    
    override func parseLine(_ line: String) {
        var s = line

        while true {
            var ms = [mul, /do\(()()\)/, /don't\(()()\)/]
              .map({s.firstMatch(of: $0)})
              .filter({$0 != nil })
              .map({$0!})

            if ms.isEmpty { break }
            ms.sort(by: {(x, y) in x.range.lowerBound < y.range.lowerBound})
            let m = ms[0]
            
            switch m.0[m.0.index(m.0.startIndex, offsetBy: 2)] {
            case "l":
                if enabled { result.append(Int(m.1)!*Int(m.2)!) }
            case "(":
                enabled = true
            case "n":
                enabled = false
            default:
                break
            }

            s = String(s[m.range.upperBound...])
        }
    }
}
