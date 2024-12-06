class day6_2: day6_1 {
    override var label: String { "day6:2" }
    
    override func pipeline() throws -> Int {
        try parseLines()
        let start = pos
        while walk() {}
        var loops: Set<XY> = []
          
        for v in visited {
            map[v.y][v.x] = "$"
            pos = start
            di = 0

            var loopCheck: Set<XYZ> = [XYZ(start.0, start.1, di)]

            while walk() {
                let xyz = XYZ(pos.0, pos.1, di)

                if loopCheck.contains(xyz) {
                    loops.insert(v)
                    break
                }

                loopCheck.insert(xyz)
            }
            
            map[v.y][v.x] = "."
        }
        
        
        return loops.count
    }
}
