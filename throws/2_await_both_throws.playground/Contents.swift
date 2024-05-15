enum CustomError: Error {
    case one
    case two
}

func firstFunc() async throws -> String {
    try? await Task.sleep(nanoseconds: 3_000_000_000)
    print("3s finished")
    throw CustomError.one
}

func secondFunc() async throws -> String {
    try? await Task.sleep(nanoseconds: 5_000_000_000)
    print(Task.isCancelled)
    print("5s finished")
    throw CustomError.two
}

Task {
    print("両方のタスクの完了を待って5s後にfinish")
    async let first = firstFunc()
    print("async first")
    async let second = secondFunc()
    print("async second")

    do {
        let (f, s) = try await(first, second)
        print("finish: \(f) - \(s)")
    } catch {
        // firstにより3秒経過した時点でタプルで指定したsecondもキャンセルされる
        // 最初にスローされるエラーによって他の結果がシャドウされる
        print(error)
    }
}
