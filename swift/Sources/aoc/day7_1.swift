//inout values/ops

class day7_1: IDay {
    var label: String { "day7:1" }
    var path: String { "input7" }
    typealias Equation = (Int, [Int])

    protocol Op {
        func eval(_ n: Int, _ r: Int) -> Int?
    }

    struct Add: Op {
        func eval(_ n: Int, _ r: Int) -> Int? { (r < n) ? nil : r - n }
    }

    struct Mul: Op {
        func eval(_ n: Int, _ r: Int) -> Int? { (n == 0 || r % n != 0) ? nil : r / n }
    }

    func parseLine(_ line: String) -> Equation {
        let (r, ns) = line.splitOnce(":")
        return (r.int, ns.split(" ").map({$0.int}))
    }

    func eval(_ e: Equation, _ ops: [Op]) -> Bool {
        var oi = ops.count-1
        var r = e.0
        
        for ni in stride(from: e.1.count-1, to: 0, by: -1) {
            let n = e.1[ni]
            if let v = ops[oi].eval(n, r) { r = v }
            else { return false }
            oi -= 1
        }

        return r == e.1[0]
    }

    func isPossible(_ e: Equation, _ ops: [Op]) -> Bool {
        permutations(ops, e.1.count-1, {eval(e, $0)})
    }

    func pipeline() throws -> Int { try run([Add(), Mul()]) }

    func run(_ ops: [Op]) throws -> Int {
        let es = try read().map(parseLine)
        return es.filter({isPossible($0, ops)}).map({$0.0}).sum
    }
}
