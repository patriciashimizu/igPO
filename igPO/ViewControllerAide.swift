//============================================================
import UIKit
import AVKit
import AVFoundation
//============================================================
class ViewControllerAide: UIViewController {
    //------------------------------
    var regle3: (Int, Int, Int) -> Int = {
        $1 * $2 / $0
    }
    //------------------------------
    // ***** Bouton bAide
    /*
     *  Appelle la fonction qui fait jouer la vidéo 
     *
     */
    @IBAction func bAide(_ sender: UIButton) {
        
        playVideo()
        
   }
    //------------------------------
    // ***** Fonction playVideo
    /*
     *  Fait jouer la vidéo en expliquant comment faire l’exportation des données
     *
     */
    private func playVideo() {
        guard let path = Bundle.main.path(forResource: "AideExport", ofType:"mp4") else {
            debugPrint("video not found")
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerController = AVPlayerViewController()
        playerController.player = player
        playerController.view.frame = CGRect(x: 0, y: 0, width: 320, height: regle3(640, 360, 320))
        present(playerController, animated: true) {
            player.play()
        }
    }
}
//============================================================
