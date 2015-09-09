//
//  ViewController.m
//  PlaceAutoCompleteDemo
//
//  Created by Jayaprada Behera on 08/09/15.
//  Copyright (c) 2015 WebileApps. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>


@interface ViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    __weak IBOutlet UITextField *searchTxtField;
    GMSPlacesClient *_placesClient;

    __weak IBOutlet UITableView *tableView;
    NSMutableArray *searchDataArray;
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    searchDataArray = [NSMutableArray array];
    searchTxtField.delegate = self;
    tableView.delegate = self;
    tableView.dataSource = self;
    _placesClient = [[GMSPlacesClient alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
}  // return NO to not change text
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    [self placeAutocompleteWithStr:textField.text];
    return YES;
}

- (void)placeAutocompleteWithStr:(NSString *)place {
    
    GMSAutocompleteFilter *filter = [[GMSAutocompleteFilter alloc] init];
    filter.type = kGMSPlacesAutocompleteTypeFilterCity;
    
    [_placesClient autocompleteQuery:place
                              bounds:nil
                              filter:filter
                            callback:^(NSArray *results, NSError *error) {
                                if (error != nil) {
                                    NSLog(@"Autocomplete error %@", [error localizedDescription]);
                                    return;
                                }
                                
                                for (GMSAutocompletePrediction* result in results) {
                                    NSLog(@"Result '%@' with placeID %@", result.attributedFullText.string, result.placeID);
                                    [searchDataArray addObject:result.attributedFullText.string];
                                }
                                [tableView reloadData];
                            }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return searchDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.textColor = [UIColor darkGrayColor];
    [cell.textLabel setFont:[UIFont fontWithName:@"SourceSansPro-Regular" size:12.f]];
    cell.textLabel.text =[searchDataArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
