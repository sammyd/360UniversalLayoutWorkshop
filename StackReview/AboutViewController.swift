/*
 * Copyright (c) 2015 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

class AboutViewController: UIViewController {

  @IBOutlet weak var contentStackView : UIStackView!
  @IBOutlet weak var showHideButton : UIButton!
  @IBOutlet weak var copyrightStackView: UIStackView!
  
  private var copyrightContentStackView : UIStackView?
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    contentStackView.layoutMarginsRelativeArrangement = true
    contentStackView.layoutMargins = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
  }
  
  
  @IBAction func handleShowHideTapped(sender: AnyObject) {
    if copyrightContentStackView == nil {
      copyrightContentStackView = createCopyrightInfo()
      copyrightContentStackView?.hidden = true
      copyrightStackView.addArrangedSubview(copyrightContentStackView!)
      UIView.animateWithDuration(1.0) {
        self.copyrightContentStackView?.hidden = false
      }
      
    } else {
      UIView.animateWithDuration(1.0, animations: {
          self.copyrightContentStackView?.hidden = true
        }, completion: { _ in
          self.copyrightContentStackView?.removeFromSuperview()
          self.copyrightContentStackView = nil
      })
    }
  }
  
  private func createCopyrightInfo() -> UIStackView {
    let logo = UIImage(named: "rw_logo")
    let logoImageView = UIImageView(image: logo)
    
    let copyrightLabel = UILabel(frame: CGRect.zeroRect)
    copyrightLabel.text = "© Razeware 2015"
    
    let axisButton = UIButton(type: .RoundedRect)
    axisButton.setTitle("Axis Switch", forState: .Normal)
    axisButton.addTarget(self, action: "switchCopyrightAxis", forControlEvents: .TouchUpInside)
    
    let textStackView = UIStackView(arrangedSubviews: [copyrightLabel, axisButton])
    textStackView.axis = .Vertical
    textStackView.spacing = 20.0
    textStackView.alignment = .Center
    
    let stackView = UIStackView(arrangedSubviews: [logoImageView, textStackView])
    stackView.axis = .Horizontal
    stackView.spacing = 20.0
    stackView.alignment = .Center
    stackView.distribution = .EqualSpacing
    
    return stackView
  }
  
  
  func switchCopyrightAxis() {
    guard let copyrightContentStackView = copyrightContentStackView else {
      return
    }
    
    let newAxis : UILayoutConstraintAxis
    switch copyrightContentStackView.axis {
    case .Horizontal:
      newAxis = .Vertical
    case .Vertical:
      newAxis = .Horizontal
    }
    
    UIView.animateWithDuration(0.7) {
      copyrightContentStackView.axis = newAxis
    }
  }
}
