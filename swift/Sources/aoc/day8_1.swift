class day8_1: IDay {
    var label: String { "day8:1" }
    var path: String { "input8" }

    var width = 0
    var height = 0

    var antennas: [Character:[XY]] = [:]
    var positions: [XY:Character] = [:]

    func isValid(_ p: XY) -> Bool {
        p.x >= 0 && p.x < width && p.y >= 0 && p.y < height
    }
    
    func startingPoint(_ point: XY, _ slope: XY) -> XY {
        var sp = point
        while isValid(sp - slope) { sp -= slope }
        return sp
    }

    func isDouble(_ l: Int, _ r: Int) -> Bool {
        (r != 0 && l / r == 2 && l % r == 0) || (l != 0 && r / l == 2 && r % l == 0)
    }

    func checkAntinode(_ p: XY, _ a1: XY, _ a2: XY) -> Bool {
        isDouble(abs(mdist(p, a1)), abs(mdist(p, a2)))
    }
    
    func antinodes(_ start: XY, _ slope: XY,
                   _ a1: XY, _ a2: XY,
                   _ result: Set<XY>) -> Set<XY> {
        var p = start
        var r = result
        
        while isValid(p) {
            if checkAntinode(p, a1, a2) { r.insert(p) }
            p += slope
        }

        return r
    }
    
    func antinodes(_ p: (XY, XY), _ result: Set<XY>) -> Set<XY> {
        let s = slope(p.0, p.1)
        return antinodes(startingPoint(p.0, s), s, p.0, p.1, result)
    }

    func antinodes(_ ps: [(XY, XY)], _ result: Set<XY>) -> Set<XY> {
        ps.reduce(result,
                  {(_ acc: Set<XY>, _ pair: (XY, XY)) in antinodes(pair, acc) })
    }

    func parseLine(_ line: (Int, String)) {
        let (y, data) = line
        width = max(width, data.count)

        for x in 0..<data.count {
            let c = data[x]
            
            if c != "." {
                let xy = XY(x, y)
                positions[xy] = c                

                if antennas[c] != nil { antennas[c]!.append(xy) }
                else { antennas[c] = [xy] }
            }
        }
            
        height += 1
    }
    
    func draw() {
        for r in 0..<height {
            var line = ""
            
            for c in 0..<width {
                if let c = positions[XY(c, r)] {line += String(c)}
                else {line += "."}
            }
            
            print(line)
        }
    }

    func pipeline() throws -> Int {
        try read().enumerated().forEach(parseLine)
        let aps = antennas.map({(id, points) in pairs(points)})

        let ans = aps.reduce(
          [],
          {(_ acc: Set<XY>, _ pairs: [(XY, XY)]) in antinodes(pairs, acc)})

        for p in ans { positions[p] = "#" }
        draw()
        
        return ans.count
    }
}
