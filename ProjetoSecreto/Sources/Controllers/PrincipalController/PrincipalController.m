#import "PrincipalController.h"
#import "CargaCategoriaStoryboardController.h"
#import "EntradaTableController.h"
#import "CategoriaDao.h"
#import "EntradaDao.h"
#import "EntradaVisualizacaoTableController.h"

@interface PrincipalController ()

@end

@implementation PrincipalController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"primeiraCarga"]) {
        CargaCategoriaStoryboardController *destino = segue.destinationViewController;
        destino.carga = [NSNumber numberWithInt:1];
    } else if([segue.identifier isEqualToString:@"segundaCarga"]) {
        CargaCategoriaStoryboardController *destino = segue.destinationViewController;
        destino.carga = [NSNumber numberWithInt:2];
    } else if([segue.identifier isEqualToString:@"incluiValores"]) {
        EntradaTableController *entrada = segue.destinationViewController;
        entrada.usuario = 1;
    }else if([segue.identifier isEqualToString:@"visualizarDespesas"]) {
        EntradaVisualizacaoTableController *entrada = segue.destinationViewController;
        entrada.visualizacao = YES;
        entrada.visualizar = @"DESPESA";
        entrada.usuario = 1;
    }else if([segue.identifier isEqualToString:@"visualizarReceitas"]) {
        EntradaVisualizacaoTableController *entrada = segue.destinationViewController;
        entrada.visualizacao = YES;
        entrada.visualizar = @"RECEITA";
        entrada.usuario = 1;
    }
    
}

- (IBAction)excluirInformacoes:(id)sender {
    EntradaDao *eDao = [EntradaDao new];
    CategoriaDao *cDao = [CategoriaDao new];
    [eDao removerTodos];
    [cDao removerTodos];
    
}

@end
