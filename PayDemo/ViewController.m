//
//  ViewController.m
//  Pay Demo
//
//  Created by Arash Z. Jahangiri on 06/03/17.
//  Copyright (c) 2017 Arash Z. Jahangiri. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Apple pay delegates
- (void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller
                       didAuthorizePayment:(PKPayment *)payment
                                completion:(void (^)(PKPaymentAuthorizationStatus status))completion
{
    NSLog(@"Payment was authorized: %@", payment);
    
    // do an async call to the server to complete the payment.
    // See PKPayment class reference for object parameters that can be passed
    BOOL asyncSuccessful = FALSE;
    
    // When the async call is done, send the callback.
    // Available cases are:
//    PKPaymentAuthorizationStatusSuccess, // Merchant auth'd (or expects to auth) the transaction successfully.
//    PKPaymentAuthorizationStatusFailure, // Merchant failed to auth the transaction.
//    
//    PKPaymentAuthorizationStatusInvalidBillingPostalAddress,  // Merchant refuses service to this billing address.
//    PKPaymentAuthorizationStatusInvalidShippingPostalAddress, // Merchant refuses service to this shipping address.
//    PKPaymentAuthorizationStatusInvalidShippingContact        // Supplied contact information is insufficient.

    if(asyncSuccessful) {
        completion(PKPaymentAuthorizationStatusSuccess);
        NSLog(@"Payment was successful");
    } else {
        completion(PKPaymentAuthorizationStatusFailure);
        NSLog(@"Payment was unsuccessful");
    }
}

- (void)paymentAuthorizationViewControllerDidFinish:(PKPaymentAuthorizationViewController *)controller
{
    NSLog(@"Finishing payment view controller");
    
    // dismiss the payment window
    [controller dismissViewControllerAnimated:TRUE completion:nil];
}

#pragma mark - custom methods
- (IBAction)checkOut:(id)sender
{
    if([PKPaymentAuthorizationViewController canMakePayments]) {
        NSLog(@"Can make payments");
        PKPaymentRequest *request = [[PKPaymentRequest alloc] init];
        PKPaymentSummaryItem *shoe = [PKPaymentSummaryItem summaryItemWithLabel:@"Shoe"
                                                                          amount:[NSDecimalNumber decimalNumberWithString:@"50.99"]];
        PKPaymentSummaryItem *tax = [PKPaymentSummaryItem summaryItemWithLabel:@"tax"
                                                                          amount:[NSDecimalNumber decimalNumberWithString:@"5.50"]];
        PKPaymentSummaryItem *total = [PKPaymentSummaryItem summaryItemWithLabel:@"Total"
                                                                          amount:[NSDecimalNumber decimalNumberWithString:@"56.49"]];
        request.paymentSummaryItems = @[shoe, tax, total];
        request.countryCode = @"US";
        request.currencyCode = @"USD";
        request.supportedNetworks = @[PKPaymentNetworkAmex, PKPaymentNetworkMasterCard, PKPaymentNetworkVisa];
        request.merchantIdentifier = @"merchant.com.demo.applepay";
        request.merchantCapabilities = PKMerchantCapabilityEMV;

        PKPaymentAuthorizationViewController *paymentPane = [[PKPaymentAuthorizationViewController alloc] initWithPaymentRequest:request];
        paymentPane.delegate = self;
        [self presentViewController:paymentPane animated:TRUE completion:nil];
        
    } else {
        NSLog(@"This device doesn't support Pay");
    }
}

@end
