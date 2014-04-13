//
//  MapController.m
//  Magellan
//
//  Created by Eric Salahov on 13/04/14.
//  Copyright (c) 2014 Eric Salahov. All rights reserved.
//

#import "MapController.h"
#import "XMLReader.h"

@interface MapController ()

@end

@implementation MapController {
    
    AGSPortal *portal;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Add a basemap tiled layer
    NSURL* url = [NSURL URLWithString:@"http://services.arcgisonline.com/ArcGIS/rest/services/Canvas/World_Light_Gray_Base/MapServer"];
    AGSTiledMapServiceLayer *tiledLayer = [AGSTiledMapServiceLayer tiledMapServiceLayerWithURL:url];
    [self.mapView addMapLayer:tiledLayer withName:@"Basemap Tiled Layer"];
    
    
    NSURL * url2 = [NSURL URLWithString:@"http://map1a.vis.earthdata.nasa.gov/twms-geo/twms.cgi?request=GetTileService"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url2];
    
    NSError *error;
    NSURLResponse *response;
    NSData *webData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSError *parserError = NULL;
    NSDictionary *xmlDict = [XMLReader dictionaryForXMLData:webData
                                                    options:XMLReaderOptionsProcessNamespaces
                                                      error:&parserError];
    
    NSLog(@"Data: %@, response: %@, error: %@", xmlDict, response, error);
}

- (void) layerDidLoad: (AGSLayer*) layer{
  	NSLog(@"Layer added successfully");
}

- (void) layer : (AGSLayer*) layer didFailToLoadwithError:(NSError*) error {
    NSLog(@"Error: %@",error);
    
//    //Inspect the error and then either ...
//    //A. Remove the layer if it's not essential
//    if(!layer == self.mapView.baseLayer)
//        [self.mapView removeMapLayerWithName:layerView.name];
//    
//    //B. Or, try resubmitting the layer, with different URL or credentials perhaps
//    AGSTiledMapServiceLayer* tiledLyr = (AGSTiledMapServiceLayer*)layer;
//    [tiledLyr resubmitWithURL:url credential:cred];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
