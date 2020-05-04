//
//  VoiceRecognitionTestPageViewController.swift
//  KeepMeSafe
//
//  Created by Diya Hituvalli on 4/8/20.
//  Copyright © 2020 Diya Hituvalli. All rights reserved.
//

import UIKit
import GLKit
import AVFoundation
import Speech
import MapKit
import MessageUI

class VoiceRecognitionTestPageViewController: UIViewController, CLLocationManagerDelegate, MFMessageComposeViewControllerDelegate {

    @IBOutlet weak var map: MKMapView!
    let audioEngine = AVAudioEngine()
    let speechRecognizer = SFSpeechRecognizer()
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
    var audioPlayer = AVAudioPlayer()
    var volume: Float { 1.0 }
    var locationManager = CLLocationManager()
    private var lastLocation: CLLocationCoordinate2D?

    @IBAction func handleStopRecordingTapped(_ sender: UIButton) {
        stopRecording()
        dismiss(animated: true, completion: .none)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SFSpeechRecognizer.requestAuthorization {
            [weak self] (authStatus) in
            switch authStatus {
            case .authorized:
                do {
                    try self?.startRecording()
                }  catch let error {
                    print("There was a problem starting recording: \(error.localizedDescription)")
                }
          case .denied:
            print("Speech recognition authorization denied")
          case .restricted:
            print("Not available on this device")
          case .notDetermined:
            print("Not determined")
            default:
                print ("Default Case Not Handled")
          }
        }
        let sound = Bundle.main.path(forResource: "zapsplat_e", ofType: "mp3")

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        }
        catch{
            print(error)
        }
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
      }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = manager.location?.coordinate else { return }
        let lat = coordinate.latitude
        let lon = coordinate.longitude
        self.lastLocation = CLLocationCoordinate2D(latitude: lat, longitude: lon)
//        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(lat)\(lon)")
        //let userLocation = locations.last
        let viewRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 600, longitudinalMeters: 600)
        self.map.setRegion(viewRegion, animated: true)
    }

    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension VoiceRecognitionTestPageViewController {
    fileprivate func stopRecording() {
      audioEngine.stop()
      request.endAudio()
      recognitionTask?.cancel()
    }
    fileprivate func startRecording() throws {
    // 1
    let node = audioEngine.inputNode
    let recordingFormat = node.outputFormat(forBus: 0)

    // 2
    node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { [weak self] (buffer, _) in
      self?.request.append(buffer)
    }

    // 3
    audioEngine.prepare()
    try audioEngine.start()
    recognitionTask = speechRecognizer?.recognitionTask(with: request) {[weak self] (result, _) in
      if let transcription = result?.bestTranscription {
        print(transcription.formattedString)
        let formattedString = transcription.formattedString
        if formattedString.contains("Help") {
            self?.audioPlayer.play()
            if MFMessageComposeViewController.canSendText(){
                var locationString: String {
                    if let location = self?.lastLocation {
                        return "https://www.google.com/maps/@\(location.latitude),\(location.longitude)"
                    } else{
                        return "No location available"
                    }
                }
                let controller = MFMessageComposeViewController()
                controller.body = "SOS Alert from KeepMeSafe user: " + locationString
                controller.recipients = ["911"]
                controller.messageComposeDelegate = self
                self?.present(controller, animated: true, completion: nil)
            }
            else{
                print("Error")
            }
        }
      }
    }
}
}


