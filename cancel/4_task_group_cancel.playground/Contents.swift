func loopFuncWith1Sec() async -> String {
    for i in 1...10 {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        print("\(i * 1).0s unit 1.0s passed")
        if Task.isCancelled { return "1.0sec x \(i)times loop finish" }
    }
    return "1.0sec x 10times loop finish"
}

func loopFuncWith2Sec() async -> String {
    for i in 1...5 {
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        print("\(i * 1 * 2).0s unit 2.0s passed")
        if Task.isCancelled { return "2.0sec x \(i)times loop finish"}
    }
    return "2.0sec x 5times loop finish"
}

let task = Task {
    Task {
        let resultUnit1 = await loopFuncWith1Sec()
        // このタスクはキャンセルされない
        print(resultUnit1)
    }
    
    let resultUnit2 = await loopFuncWith2Sec()
    print(resultUnit2)
}
Task {
    try? await Task.sleep(nanoseconds: 5_000_000_000)
    task.cancel()
    print("5秒後にタスクをキャンセルする")
}
