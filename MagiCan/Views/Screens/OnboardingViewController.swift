//
//  OnboardingController.swift
//  MagiCan
//
//  Created by Christianto Vinsen on 13/06/22.
//

import UIKit

class OnboardingViewController: UIPageViewController {

    let logoImage = UIImageView()
    var sliderViews = [UIViewController]()
    let registerButton = PrimaryButton()
//    let skipButton = UIButton(type: .system)
    
    let pageControl = UIPageControl()
    let initialPage = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupStyle()
        setupLayout()
    }
}

extension OnboardingViewController {
    
    func setup() {
        dataSource = self
        delegate = self
        
        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)

        let sliderView1 = OnboardingView(
            image: OnboardingData.first.data.image,
            titleText: OnboardingData.first.data.title,
            subtitleText: OnboardingData.first.data.subtitle
        )
            
        let sliderView2 = OnboardingView(
            image: OnboardingData.second.data.image,
            titleText: OnboardingData.second.data.title,
            subtitleText: OnboardingData.second.data.subtitle
        
        )
        let sliderView3 = OnboardingView(
            image: OnboardingData.third.data.image,
            titleText: OnboardingData.third.data.title,
            subtitleText: OnboardingData.third.data.subtitle
        )
        
        sliderViews.append(sliderView1)
        sliderViews.append(sliderView2)
        sliderViews.append(sliderView3)
        
        setViewControllers([sliderViews[initialPage]], direction: .forward, animated: true, completion: nil)
    }

    
    func setupStyle() {
        // Page Controls
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .systemGray2
        pageControl.numberOfPages = sliderViews.count
        pageControl.currentPage = initialPage
        
        // Logo Image
        logoImage.image = UIImage(named: "LogoMagicanText.png")
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.contentMode = .scaleAspectFit
        
        // Register Button
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.setTitle("Daftar", for: .normal)
        registerButton.addTarget(self, action: #selector(registerButtonTapped(_ :)), for: .touchUpInside)
        registerButton.isEnabled = false
        
        // Skip Button
//        skipButton.setTitle("Lihat lihat dulu", for: .normal)
//        skipButton.tintColor = UIColor.Primary._30
//        skipButton.translatesAutoresizingMaskIntoConstraints = false
//        skipButton.addTarget(self, action: #selector(skipButtonTapped(_ :)), for: .touchUpInside)
    }
    
    func setupLayout() {
        view.backgroundColor = .white
        view.addSubview(logoImage)
        view.addSubview(pageControl)
        view.addSubview(registerButton)
//        view.addSubview(skipButton)
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            // Logo Image
            logoImage.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: -20),
            logoImage.heightAnchor.constraint(equalToConstant: 40),
            logoImage.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            
            // Page Controls
            pageControl.heightAnchor.constraint(equalToConstant: 20),
            pageControl.bottomAnchor.constraint(equalTo: registerButton.topAnchor, constant: -20),
            pageControl.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            pageControl.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            
            // Register Button
            registerButton.heightAnchor.constraint(equalToConstant: 48),
            registerButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            registerButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            registerButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            
            // Skip Button
//            skipButton.heightAnchor.constraint(equalToConstant: 48),
//            skipButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
//            skipButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
//            skipButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
        ])
    }
}

// MARK: - DataSource
extension OnboardingViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = sliderViews.firstIndex(of: viewController) else { return nil }
        
        if currentIndex == 0 {
            return sliderViews.last               // wrap last
        } else {
            return sliderViews[currentIndex - 1]  // go previous
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = sliderViews.firstIndex(of: viewController) else { return nil }

        if currentIndex < sliderViews.count - 1 {
            return sliderViews[currentIndex + 1]  // go next
        } else {
            return sliderViews.first              // wrap first
        }
    }
    
    
}

// MARK: - Delegates
extension OnboardingViewController: UIPageViewControllerDelegate {
    
    // How we keep our pageControl in sync with viewControllers
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = sliderViews.firstIndex(of: viewControllers[0]) else { return }
        
        if currentIndex == 2 {
            registerButton.isEnabled = true
        } else {
            registerButton.isEnabled = false
        }
        
        pageControl.currentPage = currentIndex
    }
}

// MARK: - Actions
extension OnboardingViewController {
    
    @objc func registerButtonTapped(_ sender: UIButton) {
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
    @objc func skipButtonTapped(_ sender: UIButton) {
        print("Skip Button Pressed")
    }

    @objc func pageControlTapped(_ sender: UIPageControl) {
        setViewControllers([sliderViews[sender.currentPage]], direction: .forward, animated: true, completion: nil)
    }

    @objc func skipTapped(_ sender: UIButton) {
        let lastPage = sliderViews.count - 1
        pageControl.currentPage = lastPage
        
        goToSpecificPage(index: lastPage, ofViewControllers: sliderViews)
    }
    
    @objc func nextTapped(_ sender: UIButton) {
        pageControl.currentPage += 1
        goToNextPage()
    }
    
    
}

// MARK: - Extensions
extension UIPageViewController {

    func goToNextPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let currentPage = viewControllers?[0] else { return }
        guard let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentPage) else { return }
        
        setViewControllers([nextPage], direction: .forward, animated: animated, completion: completion)
    }
    
    func goToPreviousPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let currentPage = viewControllers?[0] else { return }
        guard let prevPage = dataSource?.pageViewController(self, viewControllerBefore: currentPage) else { return }
        
        setViewControllers([prevPage], direction: .forward, animated: animated, completion: completion)
    }
    
    func goToSpecificPage(index: Int, ofViewControllers pages: [UIViewController]) {
        setViewControllers([pages[index]], direction: .forward, animated: true, completion: nil)
    }
}

