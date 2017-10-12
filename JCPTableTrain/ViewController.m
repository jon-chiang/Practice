//
//  ViewController.m
//  JCPTableTrain
//
//  Created by jon on 2017/10/11.
//  Copyright © 2017年 pixnet. All rights reserved.
//

#import "ViewController.h"
#import "JCPTableViewCell.h"
#import <AFNetworking.h>
#import "SDAutoLayout.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ViewController ()

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *data;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Set up TableView
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 100;
    [self.view addSubview:self.tableView];
    
    self.tableView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0);
    
    self.data = @[];
    
    
    [self fecth];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// MARK: Fecth Web Info

- (void)fecth {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURL *url = [NSURL URLWithString:@"https://styleme-app-api.events.pixnet.net/goods/list?type=recommend&page=1&per_page=20"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSLog(@"%@", responseObject);
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSArray *recommendArray = dict[@"recommend"];
        self.data = recommendArray;
        [self.tableView reloadData];
    }];
    [dataTask resume];
}


// MARK: Table View DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (JCPTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellID = @"cell";
    JCPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell) {
        cell = [[JCPTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    NSDictionary *dict = (NSDictionary *)self.data[indexPath.row];
    
    cell.titleLabel.text = dict[@"name"];
    cell.detailLabel.text = dict[@"summary"];
    NSURL *url = [NSURL URLWithString:dict[@"thumb"]];
    [cell.thumbImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"dog"]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

@end
