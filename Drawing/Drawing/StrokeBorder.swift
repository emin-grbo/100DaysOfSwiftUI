//
//  StrokeBorder.swift
//  Drawing
//
//  Created by Emin Grbo on 05/11/2019.
//  Copyright © 2019 UndeadPixel. All rights reserved.
//

import SwiftUI

struct StrokeBorder: View {
    var body: some View {
        Circle()
            .strokeBorder(Color.blue, lineWidth: 10)
    }
}

struct StrokeBorder_Previews: PreviewProvider {
    static var previews: some View {
        StrokeBorder()
    }
}
