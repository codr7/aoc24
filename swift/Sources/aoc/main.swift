try [
  day1_1(),
  day1_2(),
  day2_1(),
  day2_2(),
  day3_1(),
  day3_2(),
  day4_1(),
  day4_2()
].forEach({(d: IDay) in try d.run()})
