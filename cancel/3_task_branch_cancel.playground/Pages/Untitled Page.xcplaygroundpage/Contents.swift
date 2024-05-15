func loop1sUnitFunc() async -> String {
    for i in 1...10 {
        if Task.isCancelled {
            return "\(i) index unit 1sec loop canceled"
        }
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        print("\(i * 1).0s unit 1sec passed")
    }
    return "1.0sec x 10times loop finish"
}

func loop2sUnitFunc() async -> String {
    for i in 1...5 {
        if Task.isCancelled {
            return "\(i) index unit 2sec loop canceled"
        }
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        print("\(i * 2).0s unit 2sec passed")
    }
    return "2.0sec x 5times loop finish"
}

let task = Task {
    Task {
        // Taskの中のTaskはキャンセルされない
        let result = await loop2sUnitFunc()
        print(result)
    }
    // こっちはキャンセルされる
    let result = await loop1sUnitFunc()
    print(result)
}

Task {
    // 5秒後にキャンセルする
    try? await Task.sleep(nanoseconds: 5_000_000_000)
    task.cancel()
}

