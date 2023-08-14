//
//  StoreMainPageViewController.swift
//  Swey
//
//  Created by Muhammad Hashir on 8/13/23.
//

import UIKit

class StoreMainPageViewController: UIPageViewController, UIPageViewControllerDataSource {

    private (set) lazy var viewControllersList: [UIViewController] = {
        return [storyboard?.instantiateViewController(withIdentifier: String(describing: ListingPageViewController.self)) as! UIViewController, storyboard?.instantiateViewController(withIdentifier: String(describing: UserChatViewController.self)) as! UIViewController]
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        dataSource = self
        
        setViewControllers([viewControllersList[0]], direction: .forward, animated: true)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let indexOfCurrentController = viewControllersList.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = indexOfCurrentController - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        return viewControllersList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let indexOfCurrentController = viewControllersList.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = indexOfCurrentController + 1
        
        guard nextIndex < viewControllersList.count else {
            return nil
        }
        
        return viewControllersList[nextIndex]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
