//
//  StoreMainPageViewController.swift
//  Swey
//
//  Created by Muhammad Hashir on 8/13/23.
//

import UIKit

class StoreMainPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    
    required init?(coder: NSCoder) {
        fatalError("Storyboard Init not allowed")
    }
    
    required init?(coder: NSCoder, scrollDelegate: ScrollDirectionDelegate, pagerDelegate: PageChangeDelegate) {
        scrollDirectionDelegate = scrollDelegate
        pageChangeDelegate = pagerDelegate
        super.init(coder: coder)
    }
    
    private var pageChangeDelegate: PageChangeDelegate?
    private var scrollDirectionDelegate: ScrollDirectionDelegate?
    private (set) lazy var viewControllersList: [UIViewController] = {
        getViewControllers()
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        dataSource = self
        delegate = self
        
        setViewControllers([viewControllersList[0]], direction: .forward, animated: true)
    }
    
    func getViewControllers() -> [UIViewController] {
        let listingViewController = storyboard?.instantiateViewController(identifier: String(describing: ListingPageViewController.self)) { coder in
            ListingPageViewController.init(coder: coder, scrollDelegate: self.scrollDirectionDelegate!)
        } as! UIViewController
        
        let chatViewController = storyboard?.instantiateViewController(withIdentifier: String(describing: UserChatViewController.self)) as! UIViewController
        
        return [listingViewController, chatViewController]
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
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let vc = pageViewController.viewControllers?.first {
                if let indexOfCurrentController = viewControllersList.firstIndex(of: vc) {
                    self.pageChangeDelegate?.onPageChanged(selectedPage: indexOfCurrentController)
                }
            }
        }
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
