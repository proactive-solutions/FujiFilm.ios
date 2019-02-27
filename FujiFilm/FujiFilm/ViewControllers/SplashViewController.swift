//
//  SplashVC.swift
//  FujiFilm
//
//  Created by Pawan Sharma on 27/02/19.
//  Copyright © 2019 Pawan Sharma. All rights reserved.
//

import UIKit

class SplashViewController: FujiFilmViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Born")

        navigationController?.isNavigationBarHidden = true

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) { [weak self] in
            guard let self = self else { return }

            if let _ = UserDefaults.standard.userDetails {
                let controller = StoryBoardNames.dashboard.initialController()
                self.navigationController?.setViewControllers([controller], animated: false)
            } else {
                if let controller = StoryBoardNames.login.instatiateController() as? LoginViewController {
                    self.navigationController?.setViewControllers([controller], animated: false)
                }
            }
        }
    }

    deinit {
        print("Died")
    }
}
