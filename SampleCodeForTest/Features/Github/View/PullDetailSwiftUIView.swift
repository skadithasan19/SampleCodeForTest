//
//  PullDetailSwiftUIView.swift
//  SampleCodeForTest
//
//  Created by Adit Hasan on 5/20/21.
//

import SwiftUI

struct PullDetailSwiftUIView: View {
    private var pull: Pull
    init(pull: Pull) {
        self.pull = pull
    }
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    if let nsURL = URL(string:pull.user?.avatar_url ?? "") {
                        AsyncImage(
                            url: nsURL,
                           placeholder: { Text("Loading ...") },
                           image: { Image(uiImage: $0).resizable() }
                        )
                        .frame(width: geo.size.width/2, height:geo.size.width/2)
                        .clipShape(Circle())
                    }
                    Spacer()
                }
                VStack(alignment: .leading, spacing: 5, content: {
                    Text(pull.title)
                        .font(.title)
                    Text(pull.user?.login ?? "")
                        .font(.subheadline)
                })
            }.padding()
        }
    }
}
