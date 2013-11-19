#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1
//
//  AppDelegate.m
//  StoryboardUITableView
//
//  Created by Kurry Tran on 10/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "Album.h"
#import "AlbumViewController.h"
@interface NSDictionary(JSONCategories)
+(NSDictionary*)dictionaryWithContentsOfJSONURLString:(NSString*)urlAddress;
-(NSData*)toJSON;
@end

@implementation NSDictionary(JSONCategories)
+(NSDictionary*)dictionaryWithContentsOfJSONURLString:
(NSString*)urlAddress
{
    NSData* data = [NSData dataWithContentsOfURL: [NSURL URLWithString: urlAddress] ];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data
                                                options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

-(NSData*)toJSON
{
    NSError* error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:self
                                                options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}
@end

@implementation AppDelegate{
    NSMutableArray *albums;
    NSMutableArray *loanList;
}


@synthesize window = _window;
@synthesize loanName;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSString *urlString = @"http://api.kivaws.org/v1/loans/search.json?status=fundraising";
    NSDictionary* json = [NSDictionary dictionaryWithContentsOfJSONURLString:urlString];
    NSArray* latestLoans = [json objectForKey:@"loans"]; //2
    //NSDictionary* loan = [latestLoans objectAtIndex:0];
    //loanName = [loan objectForKey:@"name"];
    //NSLog(@"Just created: %@",loanName);
    NSArray *fiveLoans = [latestLoans subarrayWithRange:NSMakeRange(0, 4)];
    loanList = [NSMutableArray arrayWithCapacity:5];

    for (NSDictionary *loan in fiveLoans) {
       // NSDictionary *avatarimage = loan[@"image"];
        NSString *name = loan[@"name"];
        [loanList addObject:name];
        NSLog(@"%@",name);
        // THE REST OF YOUR CODE
    }
    
    //NSArray* latestNames = [[json objectForKey:@"loans"] objectForKey:@"name"];
    
   // NSLog(@"%@",[latestNames objectAtIndex:0]);
    /*
    dispatch_async(kBgQueue, ^{
        NSDictionary* json = [NSDictionary dictionaryWithContentsOfJSONURLString:urlString];
        NSArray* latestLoans = [json objectForKey:@"loans"]; //2
        NSDictionary* loan = [latestLoans objectAtIndex:0];
        loanName = [loan objectForKey:@"name"];
        NSLog(@"Just created: %@",loanName);
        //[self performSelectorOnMainThread:@selector(fetchedData:)withObject:json waitUntilDone:YES];
    });
    
    */
        
    albums = [NSMutableArray arrayWithCapacity:5];
    Album *album1 = [[Album alloc] init];
    Album *album2 = [[Album alloc] init];
    Album *album3 = [[Album alloc] init];
    Album *album4 = [[Album alloc] init];
    Album *album5 = [[Album alloc] init];
    album1.albumName = [loanList objectAtIndex:0];
    album2.albumName = [loanList objectAtIndex:1];
    album3.albumName = [loanList objectAtIndex:2];
    album4.albumName = [loanList objectAtIndex:3];
    album5.albumName = @"Take me canning!";

    album1.artist = @"Official Quest";
    album2.artist = @"Quest Creator: Sam Stine";
    album3.artist = @"Foster The People";
    album4.artist = @"David Guetta";
    album5.artist = @"The Strokes";

    album1.rating = 5;
    album2.rating = 5;
    album3.rating = 5;
    album4.rating = 5;
    album5.rating = 5;

    [albums addObject:album1];
    [albums addObject:album2];
    [albums addObject:album3];
    [albums addObject:album4];
    [albums addObject:album5];
    
    UITabBarController *tabBarController = 
    (UITabBarController *)self.window.rootViewController;
	
    UINavigationController *navigationController = 
    [[tabBarController viewControllers] objectAtIndex:0];
	
    AlbumViewController *albumsViewController = 
    [[navigationController viewControllers] objectAtIndex:0];
	albumsViewController.albums = albums;

    // Override point for customization after application launch.
    return YES;
}

- (void)fetchedData:(NSDictionary *)json {
    NSArray* latestLoans = [json objectForKey:@"loans"]; //2
    NSDictionary* loan = [latestLoans objectAtIndex:0];
    loanName = [loan objectForKey:@"name"];
    NSLog(@"Just created: %@",loanName);
}

							
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
