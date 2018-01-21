//
//  EntradaTableController.m
//  ProjetoSecreto
//
//  Created by Adriano Carnaroli on 16/01/18.
//  Copyright © 2018 Sig. All rights reserved.
//

#import "EntradaVisualizacaoTableController.h"
#import "EntradaDao.h"
#import "Entrada.h"
#import "CategoriaDao.h"
#import "DBCategoria+CoreDataClass.h"
#import "DBEntrada+CoreDataClass.h"
#import "EntradaTableCell.h"
#import "EntradaStoryboardController.h"
#import "EntradaDetalheStoryboardController.h"

@interface EntradaVisualizacaoTableController ()

@property (strong, nonatomic) IBOutlet UIView *viewDados;

@property(nonatomic, strong) EntradaDao *entradaDao;
@property(nonatomic, strong) NSMutableArray<Entrada*> *entradas;
@property(nonatomic, assign) NSNumber *count;

@property(nonatomic,strong) CategoriaDao *categoriaDao;

@end

@implementation EntradaVisualizacaoTableController

- (void) viewDidLoad {
    [super viewDidLoad];
    self.entradaDao = [EntradaDao new];
    self.categoriaDao = [CategoriaDao new];
    self.count = [NSNumber numberWithUnsignedInteger:self.entradas.count];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"EntradaTableCell" bundle:nil] forCellReuseIdentifier:@"entradaCell"];
    
    [self carregarTable];
    
}

- (void) carregarTable {
    
    NSArray<DBEntrada*>* dbEntradas = [self.entradaDao pesquisarTodos:self.usuario];
    self.entradas = [@[] mutableCopy];
    
    NSArray<Categoria*> *categorias = [self carregarCategorias];
    
    NSNumber *somatorioReceitas = 0;
    NSNumber *somatorioDespesas = 0;
    
    for (DBEntrada *dbEntrada in dbEntradas) {
        int idEntrada = [self.count intValue] + 1;
        Entrada *entrada = [Entrada new];
        [entrada setData:dbEntrada.data];
        [entrada setValor:[NSNumber numberWithDouble:dbEntrada.valor]];
        [entrada setUsuario:[NSNumber numberWithInt:dbEntrada.usuario]];
        [entrada setLatitude:[NSNumber numberWithDouble:dbEntrada.latitude]];
        [entrada setLongitude:[NSNumber numberWithDouble:dbEntrada.longitude]];
        [entrada setCategoria:categorias[dbEntrada.categoria-1]];
        [entrada setIdEntrada:[NSNumber numberWithInt:idEntrada]];
        if(!self.visualizacao) {
            [self.entradas addObject:entrada];
        } else {
            if ([entrada.categoria.tipoEntrada isEqualToString:self.visualizar]) {
                [self.entradas addObject:entrada];
            }
        }
        
        
        if([entrada.categoria.tipoEntrada isEqualToString:@"RECEITA"]) {
            somatorioReceitas = @([entrada.valor doubleValue] + [somatorioReceitas doubleValue]);
        } else{
            somatorioDespesas = @([entrada.valor doubleValue] + [somatorioDespesas doubleValue]);
        }
    }
    
    NSNumberFormatter *formatoValor = [NSNumberFormatter new];
    formatoValor.numberStyle = NSNumberFormatterCurrencyStyle;
    
    self.somatorioDespesas.text = [formatoValor stringFromNumber:somatorioDespesas];
    self.somatorioReceitas.text = [formatoValor stringFromNumber:somatorioReceitas];
    self.count = [NSNumber numberWithUnsignedInteger:self.entradas.count];
    
    [self.tableView reloadData];
    
}

-(NSArray<Categoria*>*) carregarCategorias {
    NSArray<DBCategoria*>* dbCategorias = [self.categoriaDao pesquisarTodos];
    
    NSMutableArray *categorias = [@[] mutableCopy];
    
    
    for (DBCategoria *dbCategoria in dbCategorias) {
        Categoria *categoria = [Categoria new];
        [categoria setDescricao:dbCategoria.descricao];
        [categoria setIdCategoria: [NSNumber numberWithInt:dbCategoria.idCategoria]];
        [categoria setTipoEntrada:dbCategoria.tipoEntrada];
        [categorias addObject:categoria];
    }
    
    return categorias;
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.count integerValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EntradaTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"entradaCell" forIndexPath:indexPath];
    
    [cell inserirElementos:self.entradas[indexPath.row]];
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"segueCell"]) {
        NSIndexPath *path = [self.tableView indexPathForCell:sender];
        EntradaDetalheStoryboardController *entradaDetalhe = segue.destinationViewController;
        entradaDetalhe.entrada = self.entradas[path.row];
    }
    
}

- (IBAction)voltarTela:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/



/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

@end
