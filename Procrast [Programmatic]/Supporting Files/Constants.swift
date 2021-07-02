//
//  Constants.swift
//  Procrast [Programmatic]
//
//  Created by Ekaitz on 5/19/21.
//

import UIKit

let symbolConfig        = UIImage.SymbolConfiguration(pointSize: 35.0)

let smallSymbolConfig   = UIImage.SymbolConfiguration(pointSize: 25.0)

struct Icons {
    
//  plusIcon & gearIcon are for the MainViewController  -   Also, colors don't have to change
    static let plusIcon         =   UIImage(systemName: "plus.circle", withConfiguration: symbolConfig)!
                                    .withTintColor(UIColor.lightGray, renderingMode: .alwaysOriginal)
    
    static let gearIcon         =   UIImage(systemName: "gear", withConfiguration: symbolConfig)!
                                    .withTintColor(UIColor.lightGray, renderingMode: .alwaysOriginal)
    
//  smallPlusIcon & chevronIcon are for the MainViewController  -   Also, colors don't have to change
    static let smallPlusIcon    =   UIImage(systemName: "plus.circle", withConfiguration: smallSymbolConfig)!
                                    .withTintColor(UIColor.systemGray4, renderingMode: .alwaysOriginal)
    
    static let chevronIcon      =   UIImage(systemName: "chevron.compact.down", withConfiguration: smallSymbolConfig)!
                                    .withTintColor(UIColor.systemGray4, renderingMode: .alwaysOriginal)
    
//  The user will define the color of the icons below
    static let pieChartIcon     =   UIImage(systemName: "chart.pie", withConfiguration: symbolConfig)!
                                    
    static let lightBulbIcon    =   UIImage(systemName: "lightbulb", withConfiguration: symbolConfig)!
    
    static let textbookIcon     =   UIImage(systemName: "text.book.closed", withConfiguration: symbolConfig)!
                                    
    static let paintbrushIcon   =   UIImage(systemName: "paintbrush.pointed", withConfiguration: symbolConfig)!
    
    static let stopwatchIcon    =   UIImage(systemName: "stopwatch", withConfiguration: symbolConfig)!
    
    static let heartbIcon       =   UIImage(systemName: "heart", withConfiguration: symbolConfig)!
}
