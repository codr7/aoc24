class day6_1: IDay {
    var label: String { "day6:1" }
    var path: String { "input6" }

    let dirs = [(0, -1), (1, 0), (0, 1), (-1, 0)]
    var di = 0
    var pos = (0, 0)
    var visited: Set<XY> = []
    
    typealias Map = [[Character]]
    var map: Map = []

    func parseLine(_ line: String) {
        var ml = Array(line)

        if let i = ml.firstIndex(of: "^") {
            pos = (i, map.count)
            ml[i] = "."
        }
        
        map.append(ml)
    }

    func parseLines() throws { try read().forEach(parseLine) }

    func walk() -> Bool {
        visited.insert(XY(pos.0, pos.1))
        let d = dirs[di]
        let np = (pos.0 + d.0, pos.1 + d.1)
        
        if  np.1 < 0 || np.1 >= map.count || np.0 < 0 || np.0 >= map[np.1].count {
            return false
        }

        if map[np.1][np.0] != "." {
            di = (di + 1) % dirs.count
            return true
        }

        pos = np
        return true
    }
    
    func pipeline() throws -> Int {
        try parseLines()
        while walk() {}
        return visited.count
    }
}
