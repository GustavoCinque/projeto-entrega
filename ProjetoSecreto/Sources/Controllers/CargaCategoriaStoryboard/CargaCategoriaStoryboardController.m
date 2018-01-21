//
//  CargaCategoriaStoryboardController.m
//  ProjetoSecreto
//
//  Created by Adriano Carnaroli on 14/01/18.
//  Copyright © 2018 Sig. All rights reserved.
//

#import "CargaCategoriaStoryboardController.h"
#import "CategoriaService.h"
#import "CategoriaDao.h"
#import "DBCategoria+CoreDataClass.h"

@interface CargaCategoriaStoryboardController ()

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@property(strong, nonatomic) CategoriaService *categoriaService;

@property(strong, nonatomic) CategoriaDao *categoriaDao;

@end

@implementation CargaCategoriaStoryboardController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.categoriaService = [CategoriaService new];
    self.categoriaDao = [CategoriaDao new];
    
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    self.spinner.autoresizingMask = (UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin);
     
    [self.spinner startAnimating];
    
    if([self.carga intValue] == 1) {
        [self.categoriaService carregarPrimeiraCargaCategorias:^(NSArray<Categoria *> *categorias, NSError *error) {
            if (error) {
                NSLog(@"Erro: %@", error.localizedDescription);
            }
            [self carregarCargaCategorias: categorias];
        }];
    } else if([self.carga intValue] == 2) {
        [self.categoriaService carregarSegundaCargaCategorias:^(NSArray<Categoria *> *categorias, NSError *error) {
            if (error) {
                NSLog(@"Erro: %@", error.localizedDescription);
            }
            [self carregarCargaCategorias: categorias];
        }];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) carregarCargaCategorias:(NSArray<Categoria *>*) categorias{
    NSString *mensagem = [NSString stringWithFormat:@"Confirma a inclusão de %lu nova(s) categoria(s)?", categorias.count];
    
    UIAlertController *confirmaInclusaoCategorias = [UIAlertController alertControllerWithTitle:@"Categorias" message:mensagem preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *acaoNao = [UIAlertAction actionWithTitle:@"Não" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self.spinner stopAnimating];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    UIAlertAction *acaoSim = [UIAlertAction actionWithTitle:@"Sim" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        for (Categoria *categoria in categorias) {
            [self criarDBCategoria: categoria];
            [self.categoriaDao salvar];
        }
        
        [self.spinner stopAnimating];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [confirmaInclusaoCategorias addAction:acaoNao];
    [confirmaInclusaoCategorias addAction:acaoSim];
    
    [self presentViewController:confirmaInclusaoCategorias animated:YES completion:nil];
}

- (void) criarDBCategoria:(Categoria*)categoria{
    DBCategoria *dbCategoria = [self.categoriaDao newInstance];
    dbCategoria.descricao = categoria.descricao;
    dbCategoria.idCategoria = [categoria.idCategoria integerValue];
    dbCategoria.tipoEntrada = categoria.tipoEntrada;
}

@end
