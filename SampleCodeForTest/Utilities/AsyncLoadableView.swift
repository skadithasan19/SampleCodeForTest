import SwiftUI

struct AsyncLoadableView<Source: Loadable, Content: View>: View {

    @ObservedObject var source: Source
    var content: (Source.Output) -> Content

    init(source: Source, @ViewBuilder content: @escaping (Source.Output) -> Content) {
        self.source = source
        self.content = content
    }

    var body: some View {
        switch source.state {
        case .failed(let error):
            ErrorView(error: error, retryHandler: nil).padding(.top)
        case .idle:
            Text("Empty").foregroundColor(.gray).padding(.top)
        case .loading:
            ProgressView().padding(.top)
        case .loaded(let output):
            content(output)
        }
    }
}

struct ErrorView: View {
    let error: APIError
    var retryHandler: (() -> Void)?

    var body: some View {
        Text(error.errorDescription ?? "").foregroundColor(.gray)
    }
}
