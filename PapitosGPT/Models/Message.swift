//
//  Message.swift
//  PapitosGPT
//
//  Created by Octo Siswardhono on 26/12/24.
//


import Foundation

struct Message: Identifiable, Equatable {
    let id = UUID()
    let content: String
    let isUser: Bool
}
