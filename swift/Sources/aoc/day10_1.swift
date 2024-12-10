class day10_1: IDay {
    var label: String { "day10:1" }
    var path: String { "input10" }

    typealias Route = Set<XY>

    var topo: [[Int]] = []
    var width: Int = 0
    var height: Int = 0
    var steps = [XY(1, 0), XY(-1, 0), XY(0, 1), XY(0, -1)]
    
    func parseLine(_ line: String) {
        topo.append(Array(line.map({$0.wholeNumberValue!})))
    }

    func getTopo(_ xy: XY) -> Int {
        topo[xy.y][xy.x]
    }

    func isValid(_ xy: XY) -> Bool {
        xy.x >= 0 && xy.x < width && xy.y >= 0 && xy.y < height 
    }

    func traceRoute(_ start: XY,
                    _ step: XY,
                    _ route: inout Route,
                    _ pv: Int) -> Int {
        let xy = start + step
        if !isValid(xy) || route.contains(xy) { return 0 }
        let v = getTopo(xy)
        if v != pv + 1 { return 0 }
        route.insert(xy)
        if v == 9 { return 1}
        return traceRoutes(xy, &route, v)
    }
    
    func traceRoutes(_ start: XY, _ route: inout Route, _ pv: Int) -> Int {
        let ss = steps.map({traceRoute(start, $0, &route, pv)})
        return ss.sum
    }

    func traceRoutes() -> Int {
        var result = 0
        
        for y in 0..<topo.count {
            let row = topo[y]
            
            for x in 0..<row.count {
                if row[x] == 0 {
                    var route: Route = []
                    result += traceRoutes(XY(x, y), &route, 0)
                }
            }
        }

        return result
    }
    
    func pipeline() throws -> Int {
        try read().forEach(parseLine)
        //draw()
        height = topo.count
        width = topo[0].count
        return traceRoutes()
    }

    func draw() {
        for row in topo {
            var result = ""
            for col in row { result += String(col) }
            print(result)
        }
    }
}
