import SideMenu
import UIKit

class HomeViewController: UIViewController, MenuControllerDelegate
{
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    var reqResponse: GenericResponse?
    private var menu:  SideMenuNavigationController?
    var rootController = MenuController(with: [""])
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if(RequestHandler.checkLogin() == false)
        {
            playBtn.isHidden = true
            logoutBtn.isHidden = true
            loginBtn.isHidden = false
            rootController = MenuController(with: ["Leaderboard"])
        }
        else
        {
            playBtn.isHidden = false
            logoutBtn.isHidden = false
            loginBtn.isHidden = true
            rootController = MenuController(with: ["Leaderboard", "Match History"])
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
    
    @IBAction func loginBtnPressed(_ sender: Any)
    {
        self.performSegue(withIdentifier: "Home2Login", sender: Any?.self)
    }
    func didSelectMenuItem(named: String)
    {
        menu?.dismiss(animated: true, completion:
        {
            if(named == "Leaderboard")
            {
                self.performSegue(withIdentifier: "Home2Leader", sender: Any?.self)
            }
            else if(named == "Match History")
            {
                self.performSegue(withIdentifier: "Home2History", sender: Any?.self)
            }
        })
    }
    
    @IBAction func logoutBtnPressed(_ sender: Any)
    {
        reqResponse = RequestHandler.logout()
    }
}
