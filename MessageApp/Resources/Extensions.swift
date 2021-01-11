//
//  Extensions.swift
//  MessageApp
//
//  Created by Ibragim Akaev on 11/01/2021.
//

import UIKit

extension UIView {
    
    public var width: CGFloat {
        return self.frame.size.width
    }
    
    public var height: CGFloat {
        return self.frame.size.height
    }
    
    public var top: CGFloat {
        return self.frame.origin.y
    }

    public var buttom: CGFloat {
        return self.frame.size.height + self.frame.origin.y
    }
    
    public var left: CGFloat {
        return self.frame.origin.x
    }

    public var right: CGFloat {
        return self.frame.size.width + self.frame.origin.x
    }

}

extension UITextField {
    public var customTextField: UITextField {
        self.autocapitalizationType = .none
        self.autocorrectionType = .no
        self.layer.cornerRadius = 12
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        self.leftViewMode = .always
        self.backgroundColor = .white
        return self
    }
}
