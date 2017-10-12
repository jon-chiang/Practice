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
#import "PIXWebAPIManager.h"
#import "Post.h"

@interface ViewController ()

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *posts;
@property (assign, nonatomic) NSInteger currentPage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Set up TableView
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 100;
    [self.view addSubview:self.tableView];
    
    self.tableView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0);
    
    self.posts = [[NSMutableArray alloc] init];
    
    
    [self loadPage:1];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// MARK: Fecth Web Info

- (void)loadPage:(NSInteger)page {
    PIXWebAPIManager *shared = [PIXWebAPIManager sharedInstance];
    NSDictionary *parameters = @{@"type":@"hot", @"page":@(page), @"per_page":@"20"};
    [shared fetchFromURL:@"https://styleme-app-api.events.pixnet.net/goods/list" parameters:parameters completion:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error && [responseObject count] != 0) {
            self.currentPage = page;
            [self.posts addObjectsFromArray:responseObject];
            [self.tableView reloadData];
        }
    }];
}

// MARK: Table View DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

- (JCPTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellID = @"cell";
    JCPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell) {
        cell = [[JCPTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    Post *post = (Post *)self.posts[indexPath.row];
    cell.titleLabel.text = post.name;
    cell.detailLabel.text = post.summary;
    [cell.thumbImageView sd_setImageWithURL:post.URL placeholderImage:[UIImage imageNamed:@"dog"]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

// MARK: TableView delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"current row:%dl", indexPath.row);
    
    if (indexPath.row >= self.currentPage*20 - 1) {
        //NSLog(@"Touch bottom");
        [self loadPage:self.currentPage+1];
    }
}

@end
