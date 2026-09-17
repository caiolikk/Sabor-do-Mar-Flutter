// Valores em centavos evitam arredondamentos no total do carrinho.
class Produto {
  final String nome;
  final String descricao;
  final int centavos;
  final String imagem;

  const Produto(this.nome, this.descricao, this.centavos, this.imagem);
}

String dinheiro(int centavos) =>
    'R\$ ${(centavos / 100).toStringAsFixed(2).replaceAll('.', ',')}';

const produtos = [
  Produto(
      'Temaki Salmão',
      'Salmão fresco, arroz japonês e cream cheese envoltos em nori.',
      2490,
      'assets/images/salmao.png'),
  Produto('Temaki Filadélfia', 'Salmão, cream cheese e cebolinha.', 2690,
      'assets/images/filadelfia.png'),
  Produto('Temaki Hot', 'Salmão, cream cheese, molho especial e cebolinha.',
      2590, 'assets/images/hot.png'),
  Produto('Temaki Camarão', 'Camarão, cream cheese e cebolinha.', 2990,
      'assets/images/camarao.png'),
];
