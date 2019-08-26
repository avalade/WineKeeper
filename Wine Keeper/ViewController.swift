//
//  ViewController.swift
//  Wine Keeper
//
//  Created by Aaron Valade on 8/25/19.
//  Copyright © 2019 Phunky Code. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(
                deviceTypes: [.builtInDualCamera],
                mediaType: AVMediaType.video,
                position: .back
        )
        guard let captureDevice = deviceDiscoverySession.devices.first else {
            print("Failed to get the camera device")
            return
        }

        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)

            // Set the input device on the capture session
            captureSession!.addInput(input)

            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession!.addOutput(captureMetadataOutput)

            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.ean13]
        } catch {
            print(error)
            return
        }

        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer!)

        captureSession!.startRunning()
    }



}
