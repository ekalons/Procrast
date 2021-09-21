//The MIT License (MIT)
//
//Copyright (c) 2021 Ekaitz Alonso Larrea
//
//Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

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

struct Colors {
    static let defaultBackgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.12, alpha: 1.00)
    static let cardColor = UIColor(red: 0.17, green: 0.17, blue: 0.18, alpha: 1.00)
}
