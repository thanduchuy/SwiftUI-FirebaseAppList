//
//  ListView.swift
//  FirebasexCombine
//
//  Created by than.duc.huy on 20/07/2021.
//

import SwiftUI
import Combine

enum Constants {
    static let sizeIcon: CGFloat = 100
    static let sizeButton: CGFloat = 30
    static let sizeButtonCell: CGFloat = 20
    static let sizeButtonApprove: CGFloat = 15
    static let detailTextPlaceHolder = "Enter the contents of the note"
    static let red: Color = Color("redColor")
    static let titleColor: Color = Color("titleColor")
    static let subTitleColor: Color = Color("subTitleColor")
    static let borderColor: Color = Color("border")
    static let greenColor: Color = Color("greenColor")
}

struct ListView: View {
    var viewModel: ListViewModel
    var output: ListViewModel.Output
    @SubjectBinding private var detailTextView = ""
    @SubjectBinding private var dataRemove = Note(content: "", timeAdd: Date())
    @State private var list: [Note] = []
    private var addNotePulisher = PassthroughSubject<Void, Never>()
    private var loadView = CurrentValueSubject<Void, Never>(())

    init(viewModel: ListViewModel) {
        self.viewModel = viewModel
        let input = ListViewModel.Input(loadTrigger: loadView.eraseToAnyPublisher(),
                                        contentNoteTrigger: _detailTextView.anyPublisher(),
                                        addNoteTrigger: addNotePulisher.eraseToAnyPublisher(),
                                        removeNoteTrigger: _dataRemove.anyPublisher())
        self.output = viewModel.bind(input)
    }

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Image("firebase")
                    .resizable()
                    .frame(width: Constants.sizeIcon, height: Constants.sizeIcon, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(.top, geometry.safeAreaInsets.top + 40)

                Text("Firebase App List")
                    .foregroundColor(Constants.red)
                    .font(Font.system(size: 25, weight: .bold, design: .monospaced))

                HStack {
                    TextField(Constants.detailTextPlaceHolder, text: $detailTextView)
                        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        .background(Color.white)
                        .padding(.horizontal, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color.white)
                                .shadow(color: Constants.red, radius: 2, x: 0, y: 2)
                        )
                        .padding(.all, 8)

                    Button(action: {
                        addNotePulisher.send()
                    }, label: {
                        Image("add")
                            .resizable()
                            .frame(width: Constants.sizeButton, height: Constants.sizeButton, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    })
                }
                .padding(.all, 8)

                ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false) {
                    ForEach(list, id: \.self) { note in
                        ListCell(note: note, noteDelete: $dataRemove)
                    }
                }

                Spacer()
            }
            .frame(width: geometry.size.width)
        }
        .background(Color("background"))
        .edgesIgnoringSafeArea(.all)
        .onReceive(output.notes) { notes in
            list = notes
        }
        .onReceive(output.addValueSuccess) {
            loadView.send()
        }
        .onReceive(output.removeValueSuccess) {
            loadView.send()
        }
    }
}

struct ListScreen_Previews: PreviewProvider {
    static var previews: some View {
        ListView(viewModel: ListViewModel(usecase: ListUseCase()))
    }
}
