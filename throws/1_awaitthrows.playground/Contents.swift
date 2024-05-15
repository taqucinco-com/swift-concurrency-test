enum CustomError: Error {
    case unknown
}

func firstFunc() async throws -> String {
    try? await Task.sleep(nanoseconds: 3_000_000_000)
    throw CustomError.unknown
}

Task {
    do {
        let first = try await firstFunc()
    } catch {
        print(error)
    }
}
