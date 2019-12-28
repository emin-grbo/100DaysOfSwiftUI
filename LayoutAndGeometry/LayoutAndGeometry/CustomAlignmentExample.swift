//
//  CustomAlignmentExample.swift
//  LayoutAndGeometry
//
//  Created by roblack on 12/28/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct CustomAlignmentExample: View {
    var body: some View {
        HStack(alignment: .midAccountAndName) {
            VStack {
                Text("@twostraws")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                Image("paul-hudson")
                    .resizable()
                    .frame(width: 64, height: 64)
            }

            VStack {
                Text("Full name:")
                Text("PAUL HUDSON")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                    .font(.largeTitle)
            }
        }
    }}

struct CustomAlignmentExample_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlignmentExample()
    }
}


extension VerticalAlignment {
    struct MidAccountAndName: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[.top]
        }
    }

    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}
