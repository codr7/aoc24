class day3_2: day3_1 {
    override var label: String { "day3:2" }

    let ops: [Regex] = [
      /mul\((\d{1,3}),(\d{1,3})\)/,
      /do\(()()\)/,
      /don't\(()()\)/
    ]
 
    var enabled = true
    
    override func parseLine(_ line: String) {
        var s = line

        while true {
            var ms = ops
              .map({s.firstMatch(of: $0)})
              .filter({$0 != nil })
              .map({$0!})

            ms.sort(by: {(x, y) in x.range.lowerBound < y.range.lowerBound})
            if ms.isEmpty { break }
            let m = ms[0]
            
            switch String(m.0).slice(0, 3) {
            case "mul":
                if enabled { result.append(Int(m.1)!*Int(m.2)!) }
            case "do(":
                enabled = true
            case "don":
                enabled = false
            default:
                break
            }

            s = String(s[m.range.upperBound...])
        }
    }
}
