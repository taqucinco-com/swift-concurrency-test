func firstFunc() async -> String {
    try? await Task.sleep(nanoseconds: 3_000_000_000)
    return "first - 3s"
}

func secondFunc() async -> String {
    try? await Task.sleep(nanoseconds: 5_000_000_000)
    return "second - 5s"
}


Task {
    await Task {
        print("2つのTaskが同時に走る")
        Task {
            print("first call")
            let first = await firstFunc()
            print(first)
        }
        Task {
            print("second call")
            let second = await secondFunc()
            print(second)
        }
    }.value
    print("reach before task finish")
}
