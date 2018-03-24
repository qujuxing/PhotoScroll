//
//  ManagePageViewController.swift
//  PhotoScroll
//
//  Created by 瞿炬星 on 2018/3/23.
//  Copyright © 2018年 raywenderlich. All rights reserved.
//

import UIKit

class ManagePageViewController: UIPageViewController {
  
    var photos = ["photo1","photo2","photo3","photo4","photo5"]
    var currentIndex : Int!

    override func viewDidLoad() {
        super.viewDidLoad()

      if let viewController = viewPhotoCommentController(currentIndex ?? 0) {
        let viewControllers = [viewController]
        
        //通过传递一个刚刚创建的包含单个viewController的数组来设置uipageViewController
        setViewControllers(viewControllers, direction: .forward, animated: false, completion: nil)
      }
      //设置dataSource
      dataSource = self
    }

  //通过storyboard创建PhotoCommentViewController的一个实例，将图像的名称作为参数传递
  func viewPhotoCommentController(_ index: Int) -> PhotoCommentViewController? {
    guard let storyboard = storyboard,
    let page = storyboard.instantiateViewController(withIdentifier: "PhotoCommentViewController") as? PhotoCommentViewController
    else {
      return nil
    }
    page.photoName = photos[index]
    page.photoIndex = index
    return page
  }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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


extension ManagePageViewController: UIPageViewControllerDataSource
{
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    if let viewController = viewController as? PhotoCommentViewController,
      let index = viewController.photoIndex,
      index > 0 {
      return viewPhotoCommentController(index - 1)
    }
    
    return nil
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    if let viewController = viewController as? PhotoCommentViewController,
      let index = viewController.photoIndex,
      (index + 1) < photos.count {
      return viewPhotoCommentController(index + 1)
    }
    
    return nil
  }
  
  func presentationCount(for pageViewController: UIPageViewController) -> Int {
    return photos.count
  }
  
  //如果currentIndex为nil，返回0，否则返回currentIndex
  func presentationIndex(for pageViewController: UIPageViewController) -> Int {
    return currentIndex ?? 0
  }
}
