class day2_2: day2_1 {
    override var label: String { "day2:2" }

    override func isSafe(_ report: Report) -> Bool {
        (0..<report.count).contains(where: 
          {i in
              var r = report
              r.remove(at: i)
              return super.isSafe(r)
          })
    }
}
