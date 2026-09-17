import 'package:flutter/material.dart';
import 'produto.dart';
import 'tema.dart';

class Marca extends StatelessWidget {
  const Marca({super.key});

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.waves_rounded, size: 36),
          const SizedBox(width: 10),
          Flexible(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Sabor do Mar',
                  style:
                      tituloEstilo.copyWith(color: Colors.white, fontSize: 25)),
              const Text('T E M A K E R I A',
                  style: TextStyle(fontSize: 9, letterSpacing: 2)),
            ],
          )),
        ],
      );
}

class Apresentacao extends StatelessWidget {
  const Apresentacao({super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              const Icon(Icons.restaurant, color: coral, size: 22),
              const SizedBox(width: 9),
              Expanded(
                  child: Text('Temaki feito na hora',
                      style: tituloEstilo.copyWith(fontSize: 21))),
            ]),
            const SizedBox(height: 12),
            Text('Sabor do Mar',
                style: tituloEstilo.copyWith(fontSize: 46, height: 1.1)),
            const SizedBox(height: 12),
            const Text(
                'Ingredientes frescos, muito sabor\ne o melhor da culinária japonesa.',
                style: TextStyle(fontSize: 17, height: 1.5, color: verde)),
          ],
        ),
      );
}

class FotoProduto extends StatelessWidget {
  final Produto produto;
  const FotoProduto(this.produto, {super.key});

  @override
  Widget build(BuildContext context) => Image.asset(
        produto.imagem,
        fit: BoxFit.cover,
        width: double.infinity,
        semanticLabel: produto.nome,
        errorBuilder: (context, error, stackTrace) => const ColoredBox(
            color: verde,
            child:
                Center(child: Icon(Icons.restaurant, size: 60, color: creme))),
      );
}

class ProdutoDestaque extends StatelessWidget {
  final VoidCallback aoPedir;
  const ProdutoDestaque({super.key, required this.aoPedir});

  @override
  Widget build(BuildContext context) =>
      LayoutBuilder(builder: (context, constraints) {
        final largo = constraints.maxWidth >= 650;
        final produto = produtos.first;
        final detalhes = Padding(
          padding: EdgeInsets.all(largo ? 30 : 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                    color: coral, borderRadius: BorderRadius.circular(30)),
                child: const Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.workspace_premium, size: 18, color: Colors.white),
                  SizedBox(width: 7),
                  Text('MAIS PEDIDO',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: .7)),
                ]),
              ),
              const SizedBox(height: 18),
              Text(produto.nome,
                  style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: Colors.white)),
              const SizedBox(height: 10),
              Text(produto.descricao,
                  style: const TextStyle(
                      fontSize: 16, height: 1.5, color: Colors.white)),
              const SizedBox(height: 16),
              Text(dinheiro(produto.centavos),
                  style: const TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF8CE9E8))),
              const SizedBox(height: 18),
              ElevatedButton.icon(
                onPressed: aoPedir,
                icon: const Icon(Icons.shopping_cart_outlined),
                label: const Text('PEDIR AGORA',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, letterSpacing: .6)),
              ),
            ],
          ),
        );
        return ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: ColoredBox(
            color: const Color(0xFF08272A),
            child: largo
                ? Stack(children: [
                    Positioned.fill(child: FotoProduto(produto)),
                    Positioned.fill(
                        child: DecoratedBox(
                            decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.black.withValues(alpha: .90),
                        Colors.black.withValues(alpha: .55),
                        Colors.transparent
                      ], stops: const [
                        0,
                        .42,
                        .85
                      ]),
                    ))),
                    SizedBox(
                        width: constraints.maxWidth * .54, child: detalhes),
                  ])
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                        AspectRatio(
                            aspectRatio: 1.9, child: FotoProduto(produto)),
                        detalhes,
                      ]),
          ),
        );
      });
}

class CartaoProduto extends StatelessWidget {
  final Produto produto;
  final VoidCallback aoAbrir;
  const CartaoProduto(
      {super.key, required this.produto, required this.aoAbrir});

  @override
  Widget build(BuildContext context) => Card(
        margin: EdgeInsets.zero,
        color: const Color(0xFFFFFBF5),
        elevation: 2,
        shadowColor: verde.withValues(alpha: .16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: aoAbrir,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            AspectRatio(aspectRatio: 1.5, child: FotoProduto(produto)),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(produto.nome,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: verde)),
                    const SizedBox(height: 8),
                    Text(produto.descricao,
                        style: const TextStyle(
                            color: verde, fontSize: 15, height: 1.45)),
                    const SizedBox(height: 16),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              child: Text(dinheiro(produto.centavos),
                                  style: const TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold,
                                      color: verde))),
                          const Icon(Icons.add_circle,
                              color: turquesa, size: 30),
                        ]),
                  ]),
            ),
          ]),
        ),
      );
}

class Rodape extends StatelessWidget {
  const Rodape({super.key});
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 38, bottom: 22),
        child: Column(children: [
          const Icon(Icons.waves, size: 46, color: turquesa),
          const SizedBox(height: 8),
          Text('Feito na hora. Saboreado com calma.',
              textAlign: TextAlign.center,
              style: tituloEstilo.copyWith(fontSize: 19)),
          const SizedBox(height: 8),
          const Text('SABOR DO MAR • TEMAKERIA',
              style: TextStyle(color: verde, fontSize: 10, letterSpacing: 2)),
        ]),
      );
}
