class day10_2: day10_1 {
    override var label: String { "day10:2" }

    func traceRoute(_ start: XY,
                    _ step: XY,
                    _ route: Route,
                    _ routes: inout Set<Route>,
                    _ pv: Int) {
        let xy = start + step

        if isValid(xy) && !route.contains(xy) {
            let v = getTopo(xy)

            if v == pv + 1 {
                var r = route
                r.insert(xy)
                
                if v == 9 { routes.insert(r) }
                else { traceRoutes(xy, r, &routes, v) }
            }
        }
    }
    
    func traceRoutes(_ start: XY,
                     _ route: Route,
                     _ routes: inout Set<Route>,
                     _ pv: Int) {
        steps.forEach({traceRoute(start, $0, route, &routes, pv)})
    }

    func traceRoutes(_ start: XY,
                     _ routes: inout Set<Route>,
                     _ pv: Int) {
        traceRoutes(start, [start], &routes, pv)
    }

    override func traceRoutes() -> Int {
        var routes: Set<Route> = []
        
        for y in 0..<topo.count {
            let row = topo[y]
            
            for x in 0..<row.count {
                if row[x] == 0 { traceRoutes(XY(x, y), &routes, 0) }
            }
        }

        return routes.count
    }
}
