//
//  history_LAI_ViewController.m
//  advertisement
//
//  Created by huazhan Huang on 2017/3/22.
//  Copyright © 2017年 zhiYong_lai. All rights reserved.
//

#import "history_LAI_ViewController.h"

@interface history_LAI_ViewController ()<UITextFieldDelegate>

@end

@implementation history_LAI_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    for (int i = 0; i<3; i++) {
        UITextField *text = [[UITextField alloc]initWithFrame:CGRectMake(30,100*(i+1),120,30)];
        text.backgroundColor = [UIColor redColor];
        text.delegate = self;
        text.tag = i;
        [self.view addSubview:text];
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(20,64,100,30);
    [button setTitle:@"111" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(savetest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    switch (textField.tag) {
        case 0:
        {
            [NSManagedObjectContext makeManagedObjectContext:^(NSManagedObjectContext *context) {
                context.addObject(SAOMAOName,textField.text);
            }];
        }
            break;
        case 1:
        {
            [NSManagedObjectContext makeManagedObjectContext:^(NSManagedObjectContext *context) {
                context.addObject(SAOMAOURL,textField.text);
            }];
        }

            break;
        case 2:
        {
            [NSManagedObjectContext makeManagedObjectContext:^(NSManagedObjectContext *context) {
                context.addObject(SAOMAOTime,textField.text);

            }];
        }
 
            break;
        default:
            break;
    }
}
- (void)savetest{
    {
        [NSManagedObjectContext makeManagedObjectContext:^(NSManagedObjectContext *context) {
            context.searchObject();
        }];
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
