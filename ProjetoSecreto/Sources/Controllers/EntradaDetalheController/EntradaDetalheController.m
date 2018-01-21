//
//  EntradaDetalheController.m
//  ProjetoSecreto
//
//  Created by Adriano Carnaroli on 21/01/18.
//  Copyright © 2018 Sig. All rights reserved.
//

#import "EntradaDetalheController.h"
#import <MapKit/MapKit.h>

@interface EntradaDetalheController () <MKMapViewDelegate, CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet UILabel *descricao;
@property (strong, nonatomic) IBOutlet UILabel *valor;
@property (strong, nonatomic) IBOutlet UILabel *Categoria;
@property (strong, nonatomic) IBOutlet MKMapView *mapa;

@end

@implementation EntradaDetalheController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.descricao.text = self.entrada.descricao;
    
    NSNumberFormatter *formatoValor = [NSNumberFormatter new];
    formatoValor.numberStyle = NSNumberFormatterCurrencyStyle;
    
    self.valor.text = [formatoValor stringFromNumber:self.entrada.valor];
    self.Categoria.text = self.entrada.categoria.descricao;
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:[self.entrada.latitude doubleValue] longitude:[self.entrada.longitude doubleValue]];
    
    MKPointAnnotation *anotacao = [MKPointAnnotation new];
    
    anotacao.coordinate = location.coordinate;
    
    NSDateFormatter* formatoData = [NSDateFormatter new];
    formatoData.dateFormat = @"dd/MM/yy";
    
    anotacao.title = [formatoData stringFromDate:self.entrada.data];
    
    [self.mapa addAnnotation: anotacao];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
	
- (IBAction)voltarTela:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
