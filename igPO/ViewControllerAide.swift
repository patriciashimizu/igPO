import UIKit
import AVKit
import AVFoundation

class ViewControllerAide: UIViewController {
    
    var regle3: (Int, Int, Int) -> Int = {
        $1 * $2 / $0
    }

    @IBAction func bAide(_ sender: UIButton) {
        
        playVideo()
        
        /*theView.frame.size.width = 320
        theView.frame.size.height = CGFloat(regle3(640, 360, 320))
        
        videoObj = VideoPlayer(theUrl: "https://drive.google.com/open?id=0B6JL1meayMaFUXA3azVWQ3pQLUU",
                               theWidth: 320,
                               theHeight: regle3(640, 360, 320))
        
        videoObj.displayVideo(theView: theView)*/
    }
    
    private func playVideo() {
        guard let path = Bundle.main.path(forResource: "AideExport", ofType:"mp4") else {
            debugPrint("video not found")
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerController = AVPlayerViewController()
        playerController.player = player
        playerController.view.frame = CGRect(x: 0, y: 0, width: 320, height: regle3(640, 360, 320))
//        theView.addSubview(playerController.view)
//        player.play()
        present(playerController, animated: true) {
            player.play()
        }
    }
}
