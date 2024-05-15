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
        print("両方のタスクの完了を待って5s後にfinish")
        async let first = firstFunc()
        print("async first")
        async let second = secondFunc()
        print("async second")

        let (f, s) = await(first, second)
        print("finish: \(f) - \(s)")
    }.value
    
    await Task {
        print("firstとsecondのタスクが並行して走る")
        async let first = firstFunc()
        print("async first")
        async let second = secondFunc()
        print("async second")

        print(await first)
        print(await second)
        print("finish")
    }.value
}
