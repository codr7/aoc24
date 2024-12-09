class day9_2: day9_1 {
    override var label: String { "day9:2" }

    func moveFile(_ fileId: Int, _ start: Int, _ n: Int) {
        for i in 0..<start {
            if let fb = freeBlocks[i], fb >= n {
                freeBlocks[start] = n
                freeBlocks[i] = nil
                if fb > n { freeBlocks[i+n] = fb - n }
                files[fileId] = (i, n)
                fileBlocks[start] = nil
                fileBlocks[i] = (fileId, n)
                break
            }
        }
    }

    override func moveFiles() {
        for (id, f) in files.sorted(by: {(l, r) in l.0 > r.0}) {
            moveFile(id, f.0, f.1)
        }
    }
}
