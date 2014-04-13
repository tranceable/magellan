//
//  MapController.h
//  Magellan
//
//  Created by Eric Salahov on 13/04/14.
//  Copyright (c) 2014 Eric Salahov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ArcGIS/ArcGIS.h>

@interface MapController : UIViewController <AGSLayerDelegate, AGSPortalDelegate>

@property (weak, nonatomic) IBOutlet AGSMapView *mapView;

@end
