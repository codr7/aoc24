class day11: IDay {
    var label: String { "day11:1&2" }
    var path: String { "input11" }

    var stones: [Int:Int] = [:]
    
    func addStones(_ s: Int, _ dn: Int) {
        if let n = stones[s] { stones[s] = n + dn }
        else { stones[s] = dn }
    }

    func blinkStones(_ s1: Int, _ s2: Int, _ dn: Int) {
        let n1 = stones[s1]!
        stones[s1] = (n1 == dn) ? nil : n1-dn
        addStones(s2, dn)
    }
    
    func blink(_ s: Int, _ dn: Int) {
        if s == 0 { blinkStones(0, 1, dn) }
        else {
            let ss = "\(s)"
            
            if ss.count % 2 == 0 {
                let i = ss.count / 2
                blinkStones(s, Int(ss.prefix(i))!, dn)
                addStones(Int(ss.suffix(i))!, dn)
            } else {
                blinkStones(s, s * 2024, dn)
            }
        }
    }
    
    func blink() {
        for (s, n) in Array(stones) { blink(s, n) }
    }
    
    func pipeline() throws -> Int {
        try read()[0]
          .split(separator: " ")
          .map({Int($0)!})
          .forEach({stones[$0] = 1})

        for _ in 0..<75 { blink() }
        return stones.values.reduce(0, +)
    }
}
