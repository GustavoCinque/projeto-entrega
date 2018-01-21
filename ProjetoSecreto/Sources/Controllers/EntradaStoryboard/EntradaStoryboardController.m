//
//  EntradaStoryboardController.m
//  ProjetoSecreto
//
//  Created by Adriano Carnaroli on 18/01/18.
//  Copyright © 2018 Sig. All rights reserved.
//

#import "EntradaStoryboardController.h"
#import "DBEntrada+CoreDataClass.h"
#import "EntradaDao.h"
#import "DBCategoria+CoreDataClass.h"
#import "CategoriaDao.h"
#import <CoreLocation/CoreLocation.h>

@interface EntradaStoryboardController ()<UIPickerViewDelegate, UIPickerViewDataSource, CLLocationManagerDelegate> {
    
}

@property(nonatomic, strong) UITextField *campoTexto;
@property(nonatomic, strong) UITextView *campoTextoView;
@property(strong, nonatomic) IBOutlet UILabel *labelTipoEntrada;

@property(nonatomic, strong) EntradaDao *entradaDao;
@property(nonatomic, strong) CategoriaDao *categoriaDao;
@property(nonatomic, strong) NSMutableArray<DBCategoria*> *listaCategorias;


@property (strong, nonatomic) IBOutlet UITextView *campoDescricao;
@property (strong, nonatomic) IBOutlet UITextField *campoValor;
@property (strong, nonatomic) IBOutlet UIPickerView *campoCategoria;

@property(nonatomic, strong) CLLocationManager *locationManager;
@property(nonatomic, strong) CLLocation *localSalvo;

@end

@implementation EntradaStoryboardController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(self.receita) {
        self.labelTipoEntrada.text = @"Adicionar Receita";
    } else {
        self.labelTipoEntrada.text = @"Adicionar Despesa";
    }
    
    [self.view setBackgroundColor:[[UIColor clearColor] colorWithAlphaComponent:0.5]];
    self.entradaDao = [EntradaDao new];
    self.categoriaDao = [CategoriaDao new];
    
    self.listaCategorias =[@[] mutableCopy];
    self.campoCategoria.delegate = self;
    NSArray<DBCategoria*> *newLista = [self.categoriaDao pesquisarTodos];
    
    for (DBCategoria *categoria in newLista) {
        if(self.receita) {
            if([categoria.tipoEntrada isEqualToString:@"RECEITA"]) {
                [self.listaCategorias addObject:categoria];
            }
        } else {
            if([categoria.tipoEntrada isEqualToString:@"DESPESA"]) {
                [self.listaCategorias addObject:categoria];
            }
        }
    }
    
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        [self.locationManager requestWhenInUseAuthorization];
    
    [self.locationManager startUpdatingLocation];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.campoTexto = textField;
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if(self.campoTexto) {
        [self.campoTexto resignFirstResponder];
        self.campoTexto = nil;
    }
    
    if(self.campoTextoView) {
        [self.campoTextoView resignFirstResponder];
        self.campoTextoView = nil;
    }
    
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    self.campoTextoView = textView;
    return YES;
}

- (IBAction)salvar:(id)sender {
    if([self camposPreechidos]) {
        NSString *mensagem = @"Deseja vincular o seu local atual?";
        
        UIAlertController *confirmaInclusaoCategorias = [UIAlertController alertControllerWithTitle:@"Inclusão de valores" message:mensagem preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *acaoNao = [UIAlertAction actionWithTitle:@"Não" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            DBEntrada *entrada = [self.entradaDao newInstance];
            entrada.idEntrada = self.idEntrada;
            entrada.categoria = [self.campoCategoria selectedRowInComponent:0];
            entrada.data = [NSDate date];
            entrada.usuario = self.usuario;
            entrada.valor = [self.campoValor.text doubleValue];
            [self.entradaDao salvar];
            [self dismissViewControllerAnimated:YES completion:nil];
            [self.locationManager stopUpdatingLocation];
            [self.tableController carregarTable];
            
        }];
        
        UIAlertAction *acaoSim = [UIAlertAction actionWithTitle:@"Sim" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            DBEntrada *entrada = [self.entradaDao newInstance];
            entrada.idEntrada = self.idEntrada;
            entrada.categoria = self.listaCategorias[[self.campoCategoria selectedRowInComponent:0]].idCategoria;
            entrada.data = [NSDate date];
            entrada.usuario = self.usuario;
            entrada.valor = [self.campoValor.text doubleValue];
            entrada.latitude = self.localSalvo.coordinate.latitude;
            entrada.longitude = self.localSalvo.coordinate.longitude;
            [self.entradaDao salvar];
            [self dismissViewControllerAnimated:YES completion:nil];
            [self.locationManager stopUpdatingLocation];
            [self.tableController carregarTable];
        }];
        
        [confirmaInclusaoCategorias addAction:acaoNao];
        [confirmaInclusaoCategorias addAction:acaoSim];
        
        [self presentViewController:confirmaInclusaoCategorias animated:YES completion:nil];
    } else {
        self.view.transform = CGAffineTransformMakeTranslation(20, 0);
        [UIView animateWithDuration:0.4 delay:0.0 usingSpringWithDamping:0.2 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.view.transform = CGAffineTransformIdentity;
        } completion:nil];
        self.view.transform = CGAffineTransformMakeTranslation(20, 0);
        [UIView animateWithDuration:0.4 delay:0.0 usingSpringWithDamping:0.2 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.view.transform = CGAffineTransformIdentity;
        } completion:nil];
    }
    
}

-(BOOL) camposPreechidos {
    NSString *descricao = self.campoDescricao.text;
    NSString *valor = self.campoValor.text;
    return !([descricao isEqualToString:@""] || [valor isEqualToString:@""] || self.listaCategorias.count == 0);
}

- (IBAction)descartar:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.listaCategorias.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.listaCategorias[row].descricao;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    self.localSalvo = [locations lastObject];
}

@end
