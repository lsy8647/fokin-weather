//
//  Extentions.swift
//  project
//
//  Created by inlab on 2020/08/27.
//  Copyright © 2020 inlab. All rights reserved.
//

import UIKit

extension UITextView{
    func alignTextVerticalInContainer(){
        var topCorrect = (self.bounds.size.height - self.contentSize.height * self.zoomScale) / 2
        topCorrect = topCorrect < 0.0 ? 0.0 : topCorrect;
        self.contentInset.top = topCorrect
    }
}
