//
//  Challenge.swift
//  TestSprite
//
//  Created by Yuga Samuel on 03/05/23.
//

import Foundation

struct Challenge: Identifiable {
    let id = UUID()
    let challengePrompt: String
}

extension Challenge {
    static let allValues: [Challenge] = [
        .init(challengePrompt: "What is the one thing that you have always wanted to do but have been too afraid to try?"),
        .init(challengePrompt: "Have you ever had a paranormal experience? If so, what happened?"),
        .init(challengePrompt: "What is the most embarrassing thing that has ever happened to you on a date?"),
        .init(challengePrompt: "What is the most daring thing you have ever done?"),
        .init(challengePrompt: "Have you ever had a secret that you kept from everyone? What was it?"),
        .init(challengePrompt: "What is your biggest fear?"),
        .init(challengePrompt: "Have you ever had a crush on a teacher or boss?"),
        .init(challengePrompt: "What is the most romantic thing you have ever done for someone else?"),
        .init(challengePrompt: "What is the most embarrassing thing your parents have ever caught you doing?"),
        .init(challengePrompt: "Have you ever been in love with someone who didn't love you back?"),
        .init(challengePrompt: "Have you ever stolen something before?"),
        .init(challengePrompt: "What is the most trouble you have ever been in with the law?"),
        .init(challengePrompt: "Have you ever lied to get out of trouble? What was the lie?"),
        .init(challengePrompt: "What is the most spontaneous thing you have ever done?"),
        .init(challengePrompt: "Have you ever had a dream that came true? What was it?"),
    ]
}
