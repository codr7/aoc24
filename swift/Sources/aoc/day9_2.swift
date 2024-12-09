class day9_2: day9_1 {
    override var label: String { "day9:2" }

    func moveFile(_ fileId: Int, _ start: Int, _ n: Int) {
        var i = freeBlocks.count-1
        
        while i >= 0 {
            let fb = freeBlocks[i]
            if fb.0 > start { break }
            
            if fb.1 >= n {
                if fb.1 > n {
                    freeBlocks[i] = (fb.0+n, fb.1-n)
                } else {
                    freeBlocks.remove(at: i)
                }

                files[fileId] = (fb.0, n)
                fileBlocks[fb.0] = (fileId, n)
                fileBlocks[start] = nil
                break
            }

            i -= 1
        }
    }

    override func moveFiles() {
        for (id, f) in files.sorted(by: {(l, r) in l.0 > r.0}) {
            moveFile(id, f.0, f.1)
        }
    }
}
