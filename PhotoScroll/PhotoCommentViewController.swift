//
//  PhotoCommentViewController.swift
//  PhotoScroll
//
//  Created by 瞿炬星 on 2018/3/23.
//  Copyright © 2018年 raywenderlich. All rights reserved.
//

import UIKit

class PhotoCommentViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    
    var photoName : String?
    var photoIndex : Int!

    override func viewDidLoad() {
        super.viewDidLoad()
      if let photoName = photoName {
        self.imageView.image = UIImage(named: photoName)
      }
      //将控制器自身注册为观察者；选择器指定接收方应该发送的消息模式，应是keyboardWillHide(_:)方法；注册通知名称，只有此名称的通知才会传给观察者，此处为UIKeyboardWillShow；观察者希望接收其通知的对象; 也就是说，只有该发件人发送的通知才会发送给观察者，此处为nil，即不指定。
      NotificationCenter.default.addObserver(self, selector: #selector(PhotoCommentViewController.keyboardWillHide(_:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
    }
  
    //释放消息中的观察者
    deinit {
    NotificationCenter.default.removeObserver(self)
    }
  
  // MARK: 键盘关闭后，不能滚动视图，运行还有点小问题
  
  func adjustInsetForKeyboardShow(_ show: Bool, notification: Notification)  {
    //初始化通知
    let userInfo = notification.userInfo ?? [:]
    //通知获取键盘框架大小
    let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
    //当show的值为true取1，返回的adjustmentHeight为键盘高度+20的正值，show的值为false，返回的就为负值
    let adjustmentHeight = (keyboardFrame.height + 20) * (show ? 1 : -1)
    //添加填充值20到UIScrollView中，使其向上或向下滚动，以便UITextField始终在屏幕上可见
    scrollView.contentInset.bottom += adjustmentHeight
//    scrollView.scrollIndicatorInsets.bottom += adjustmentHeight
  }
  
  /*
   contentInset
   内容视图从安全区域或滚动视图边缘插入的自定义距离。
   使用此属性可以扩展内容和内容视图边缘之间的空间。 单位的大小是点。 默认值是UIEdgeInsetsZero。
   scrollIndicatorInsets
   滚动指示符与滚动视图边缘的距离。
  */
  
  @objc func keyboardWillShow(_ notification: Notification) {
    adjustInsetForKeyboardShow(true, notification: notification)
  }
  
  @objc func keyboardWillHide(_ notification: Notification) {
    adjustInsetForKeyboardShow(false, notification: notification)
  }

    @IBAction func hideKeyboard(_ sender: Any) {
        nameTextField.endEditing(true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    //MARK: - 加入zooming功能
  @IBAction func openZoomingController(_ sender: AnyObject) {
    self.performSegue(withIdentifier: "zooming", sender: nil)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let id = segue.identifier,
    let zoomedPhotoViewController = segue.destination as? ZoomedPhotoViewController,
    id == "zooming" {
      zoomedPhotoViewController.photoName = photoName
    }
  }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
