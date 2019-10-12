//
//  RBPicker.swift
//  UnitCoverter
//
//  Created by roblack on 10/12/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import Foundation
import SwiftUI

struct CustomPicker<Data>: UIViewRepresentable where Data: Equatable {

    @State var data: [[Data]]
    @State var selection: [Data]

    class Coordinator: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {

        @State var data: [[Data]]
        @State var selection: [Data]

        init(data: State<[[Data]]>, selection: State<[Data]>) {
            $data = data
            $selection = selection
        }

        func pickerView(_ pickerView: UIPickerView,
                        numberOfRowsInComponent component: Int) -> Int {
            data[component].count
        }

        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            data.count
        }

        func pickerView(_ pickerView: UIPickerView,
                        widthForComponent component: Int) -> CGFloat {
            return (pickerView.superview?.bounds.width ?? 0) * 0.33
        }

        func pickerView(_ pickerView: UIPickerView,
                        rowHeightForComponent component: Int) -> CGFloat {
            return 30
        }

        func pickerView(_ pickerView: UIPickerView,
                        viewForRow row: Int,
                        forComponent component: Int,
                        reusing view: UIView?) -> UIView {
            guard let reusableView = view as? UILabel else {
                let label = UILabel(frame: .zero)
                label.backgroundColor = UIColor.red.withAlphaComponent(0.15)
                label.text = "\(data[component][row])"
                return label
            }
            reusableView.text = "\(data[component][row])"
            return reusableView
        }

        func pickerView(_ pickerView: UIPickerView,
                        didSelectRow row: Int,
                        inComponent component: Int) {
            let value = data[component][row]
            selection[component] = value
        }
    }

    func makeCoordinator() -> CustomPicker.Coordinator {
        return Coordinator(data: $data,
                           selection: $selection)
    }

    func makeUIView(context: UIViewRepresentableContext<CustomPicker>) -> UIPickerView {
        let picker = UIPickerView()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIView(_ uiView: UIPickerView,
                      context: UIViewRepresentableContext<CustomPicker>) {

        uiView.reloadAllComponents()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.selection.enumerated().forEach { tuple in
                let (offset, value) = tuple
                let row = self.data[offset].firstIndex { $0 == value } ?? 0
                uiView.selectRow(row, inComponent: offset, animated: false)
            }
        }

    }

}
