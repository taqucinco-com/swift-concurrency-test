func loopFunc() async -> String {
    try? await Task.sleep(nanoseconds: 1_000_000_000)
    print("1s passed")
    try? await Task.sleep(nanoseconds: 1_000_000_000)
    print("2s passed")
    try? await Task.sleep(nanoseconds: 1_000_000_000)
    print("3s passed")
    try? await Task.sleep(nanoseconds: 1_000_000_000)
    print("4s passed")
    try? await Task.sleep(nanoseconds: 1_000_000_000)
    print("5s passed")
    return "1.0sec x 5times loop finish"
}

let task = Task {
    let result = await loopFunc()
    // 全て実行されているように見える
    print(result)
    print("finish")
}
Task {
    try? await Task.sleep(nanoseconds: 2_000_000_000)
    print("2秒後にキャンセル")
    task.cancel()
}
