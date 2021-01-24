import Foundation
import UIKit
import SideMenu

var alertDone: Bool = false

class PlayViewController: UIViewController, MenuControllerDelegate
{
    
    var genericResponse: GenericResponse?
    private var menu:  SideMenuNavigationController?
    var rootController = MenuController(with: ["Home", "Leaderboard", "Match History", "Logout"])
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        if(RequestHandler.isRoundStarted() == true)
        {
            performSegue(withIdentifier: "Play2Game", sender: self)
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if(!alertDone)
        {
            present(RequestHandler.alert(title:"Timer", message:"Answer the question within 10 seconds for bonus points!"), animated: true)
            alertDone = true
        }
        
        menu = SideMenuNavigationController(rootViewController: rootController)
        
        rootController.delegate = self
        menu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
    }
    
    @IBAction func menuBtnPressed(_ sender: Any)
    {
        present(menu!, animated:true)
    }
    func didSelectMenuItem(named: String)
    {
        menu?.dismiss(animated: true, completion:
        {
            if(named == "Home")
            {
                self.performSegue(withIdentifier: "Play2Home", sender: Any?.self)
            }
            else if(named == "Leaderboard")
            {
                self.performSegue(withIdentifier: "Play2Leader", sender: Any?.self)
            }
            else if(named == "Logout")
            {
                self.genericResponse =  RequestHandler.logout()
                
                self.performSegue(withIdentifier: "Play2Home", sender: Any?.self)
            }
            else if(named == "Match History")
            {
                self.performSegue(withIdentifier: "Play2History", sender: Any?.self)
            }
        })
    }
    
    @IBAction func easyBtnPressed(_ sender: Any)
    {
        genericResponse = RequestHandler.startGame(difficulty: "easy")
        performSegue(withIdentifier:"Play2Game", sender: self)
    }
    @IBAction func medBtnPressed(_ sender: Any)
    {
        genericResponse = RequestHandler.startGame(difficulty: "medium")
        performSegue(withIdentifier:"Play2Game", sender: self)
    }
    @IBAction func hardBtnPressed(_ sender: Any)
    {
        genericResponse = RequestHandler.startGame(difficulty: "hard")
        performSegue(withIdentifier:"Play2Game", sender: self)
    }
}
