//
//  ViewController.h
//  Pay Demo
//
//  Created by Arash Z. Jahangiri on 06/03/17.
//  Copyright (c) 2017 Arash Z. Jahangiri. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <PassKit/PassKit.h>

@interface ViewController : UIViewController
<PKPaymentAuthorizationViewControllerDelegate>

- (IBAction)checkOut:(id)sender;

@end

