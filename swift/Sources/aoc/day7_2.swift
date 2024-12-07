class day7_2: day7_1 {
    override var label: String { "day7:2" }

    struct Con: Op {
        func eval(_ n: Int, _ r: Int) -> Int? {
            let ns = "\(n)"
            let rs = "\(r)"
            
            return (n == r || !rs.hasSuffix(ns))
              ? nil
              : Int(rs.prefix(rs.count - ns.count))!
        }
    }

    override func pipeline() throws -> Int { try run([Add(), Mul(), Con()]) }
}
