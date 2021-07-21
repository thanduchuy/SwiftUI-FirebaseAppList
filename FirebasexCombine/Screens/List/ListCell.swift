//
//  ListCell.swift
//  FirebasexCombine
//
//  Created by than.duc.huy on 20/07/2021.
//

import SwiftUI

struct ListCell: View {
    var note: Note
    @State private var willDelete = false
    @Binding var noteDelete: Note

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image("edit")
                        .resizable()
                        .frame(width: Constants.sizeButtonCell, height: Constants.sizeButtonCell, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                })

                Spacer()

                Button(action: {
                    willDelete.toggle()
                }, label: {
                    Image("trash")
                        .resizable()
                        .frame(width: Constants.sizeButtonCell, height: Constants.sizeButtonCell, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                })
            }

            Text(note.content)
                .font(.headline)
                .foregroundColor(Constants.titleColor)
                .padding(.vertical, 4)
            Text(note.formatDate)
                .font(.subheadline)
                .foregroundColor(Constants.subTitleColor)
                .padding(.vertical, 4)


            if willDelete {
                GeometryReader { geometry in
                    Rectangle()
                        .fill(Constants.borderColor)
                        .frame(width: geometry.size.width, height: 1, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

                    HStack(spacing: 0) {
                        HStack {
                            Spacer()
                            Image("delete")
                                .resizable()
                                .frame(width: Constants.sizeButtonApprove, height: Constants.sizeButtonApprove, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            Text("Deny")
                                .font(.caption)
                                .foregroundColor(Constants.titleColor)
                            Spacer()
                        }
                        .onTapGesture {
                            willDelete.toggle()
                        }

                        Rectangle()
                            .fill(Constants.borderColor)
                            .frame(width: 1, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

                        HStack {
                            Spacer()
                            Image("check")
                                .resizable()
                                .frame(width: Constants.sizeButtonApprove, height: Constants.sizeButtonApprove, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            Text("Approve")
                                .font(.caption)
                                .foregroundColor(Constants.greenColor)
                            Spacer()
                        }
                        .onTapGesture {
                            noteDelete = note
                        }
                    }
                }
                .frame(height: 30)
            }
        }
        .padding([.top, .horizontal])
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.6), radius: 4, x: 0, y: 5)
        )
        .padding(.all, 8)
        .animation(.easeInOut)
    }
}
