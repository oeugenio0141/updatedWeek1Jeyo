//
//  ViewController.m
//  actWeek1
//
//  Created by OPSolutions on 25/10/2019.
//  Copyright © 2019 OPSolutions. All rights reserved.
//

#import "ViewController.h"
#import "Home.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self clearDefaults];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if(![defaults boolForKey:@"registered"]){
        NSLog(@"No user registered");
        _loginBtn.hidden = YES;
        
        
    }else{
        NSLog(@"User is registered");
        _reEnterPasswordField.hidden = YES;
        _registerBtn.hidden = YES;
        
        
    }
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    
}

- (IBAction)registerUser:(id)sender {
    
    if([_usernameField.text isEqualToString:@""] || [_passwordField.text isEqualToString:@""] || [_reEnterPasswordField.text isEqualToString:@""]){
        
        UIAlertController *error = [UIAlertController alertControllerWithTitle:@"Ooops" message:@"You must complete all fields" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okay = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){}];
        
        [error addAction:okay];
        [self presentViewController:error animated:YES completion:nil];
        
    }else{
        
        [self checkPasswordMatch];
        
    }
}

-(void)checkPasswordMatch{
    
    if([_passwordField.text isEqualToString:_reEnterPasswordField.text]){
     
        [self registerNewUser];
        
    }else{
        
        UIAlertController *error = [UIAlertController alertControllerWithTitle:@"Ooops" message:@"Password does not match!" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *reEnter = [UIAlertAction actionWithTitle:@"Re-enter" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){}];
        
        [error addAction:reEnter];
        [self presentViewController:error animated:YES completion:nil];
    }
}

-(void)registerNewUser{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:_usernameField.text forKey:@"username"];
    [defaults setObject:_passwordField.text forKey:@"password"];
    [defaults setBool:YES forKey:@"registered"];
    
    [defaults synchronize];
    
    UIAlertController *success = [UIAlertController alertControllerWithTitle:@"Success" message:@"Successfully Registered!" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okay = [UIAlertAction actionWithTitle:@"Login" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        [self performSegueWithIdentifier:@"login" sender:self];
        
    }];
    
    [success addAction:okay];
    [self presentViewController:success animated:YES completion:nil];
    
    
}



-(void)clearDefaults{
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:[[NSBundle mainBundle] bundleIdentifier]];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

- (IBAction)LoginUser:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([_usernameField.text isEqualToString:[defaults objectForKey:@"username"]] && [_passwordField.text isEqualToString:[defaults objectForKey:@"password"]]){
        _usernameField.text = nil;
        _passwordField.text = nil;
        
        
        
        NSLog(@"Credentials Accepted!");
        [self performSegueWithIdentifier:@"login" sender:self];

     
    }else{
        NSLog(@"Login Credentials Incorrect");
        
        UIAlertController *error = [UIAlertController alertControllerWithTitle:@"Ooops" message:@"Username and Password did not match." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *tryAgain = [UIAlertAction actionWithTitle:@"Try Again" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){}];
        
        [error addAction:tryAgain];
        [self presentViewController:error animated:YES completion:nil];
        
    
    }
}
@end
