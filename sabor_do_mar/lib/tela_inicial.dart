import 'package:flutter/material.dart';
import 'componentes.dart';
import 'produto.dart';
import 'tema.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  // Estado simples, mantido apenas enquanto o aplicativo está aberto.
  final Map<Produto, int> _carrinho = {};
  int get _quantidade => _carrinho.values.fold(0, (total, q) => total + q);
  int get _total => _carrinho.entries
      .fold(0, (total, item) => total + item.key.centavos * item.value);

  void _adicionar(Produto produto) {
    setState(() => _carrinho.update(produto, (q) => q + 1, ifAbsent: () => 1));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text('${produto.nome} adicionado!'),
        action:
            SnackBarAction(label: 'VER CARRINHO', onPressed: _abrirCarrinho),
        duration: const Duration(seconds: 2),
      ));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _appBar(),
        drawer: _menu(),
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1040),
              // O cardápio precisa rolar em celulares e em telas baixas.
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                children: [
                  const Apresentacao(),
                  ProdutoDestaque(aoPedir: () => _adicionar(produtos.first)),
                  const SizedBox(height: 28),
                  Text('Outros favoritos',
                      style: tituloEstilo.copyWith(fontSize: 30)),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.only(top: 8, bottom: 20),
                        width: 66,
                        height: 3,
                        color: turquesa,
                      )),
                  _favoritos(),
                  const Rodape(),
                ],
              ),
            ),
          ),
        ),
      );

  AppBar _appBar() => AppBar(
        title: const Marca(),
        actions: [
          IconButton(
            tooltip: 'Carrinho ($_quantidade itens)',
            onPressed: _abrirCarrinho,
            icon: Badge(
              backgroundColor: coral,
              label: Text('$_quantidade'),
              child: const Icon(Icons.shopping_cart_outlined, size: 27),
            ),
          ),
          const SizedBox(width: 14),
        ],
      );

  Widget _favoritos() => LayoutBuilder(builder: (context, constraints) {
        final cartoes = produtos
            .skip(1)
            .map((produto) => CartaoProduto(
                  produto: produto,
                  aoAbrir: () => _abrirProduto(produto),
                ))
            .toList();
        if (constraints.maxWidth < 650) {
          return Column(children: [
            for (final cartao in cartoes)
              Padding(
                  padding: const EdgeInsets.only(bottom: 18), child: cartao),
          ]);
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < cartoes.length; i++) ...[
              if (i > 0) const SizedBox(width: 20),
              Expanded(child: cartoes[i]),
            ],
          ],
        );
      });

  Widget _menu() => Drawer(
          child: SafeArea(
              child: Column(children: [
        const SizedBox(
            width: double.infinity,
            height: 120,
            child: ColoredBox(
                color: verde,
                child: Icon(Icons.waves, color: Colors.white, size: 60))),
        ListTile(
            leading: const Icon(Icons.restaurant_menu),
            title: const Text('Cardápio'),
            onTap: () => Navigator.pop(context)),
        ListTile(
            leading: const Icon(Icons.shopping_cart_outlined),
            title: const Text('Meu carrinho'),
            onTap: () {
              Navigator.pop(context);
              _abrirCarrinho();
            }),
        ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Sobre a temakeria'),
            onTap: () {
              Navigator.pop(context);
              showDialog<void>(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const Text('Sabor do Mar'),
                        content: const Text(
                            'Temakis preparados na hora, com ingredientes frescos e muito sabor.\n\nProjeto acadêmico de DDM1. Os pedidos são apenas demonstrativos.'),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Fechar'))
                        ],
                      ));
            }),
      ])));

  void _abrirProduto(Produto produto) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      backgroundColor: creme,
      builder: (sheetContext) => StatefulBuilder(builder: (context, atualizar) {
        String tamanho = 'Normal';
        final extras = <String>{};
        final removidos = <String>{};
        final observacoes = TextEditingController();
        const opcoesExtras = {
          'Cream cheese extra': 300,
          'Cebolinha extra': 150,
          'Gergelim': 100
        };
        const ingredientes = ['Arroz japonês', 'Cream cheese', 'Cebolinha'];
        return SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: AspectRatio(
                        aspectRatio: 1.8, child: FotoProduto(produto))),
                const SizedBox(height: 20),
                Text(produto.nome,
                    style: const TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        color: verde)),
                const SizedBox(height: 10),
                Text(produto.descricao,
                    style: const TextStyle(fontSize: 17, height: 1.5)),
                const SizedBox(height: 18),
                const Text('Tamanho',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, color: verde)),
                DropdownButton<String>(
                  value: tamanho,
                  isExpanded: true,
                  items: const ['Pequeno', 'Normal', 'Grande']
                      .map((item) =>
                          DropdownMenuItem(value: item, child: Text(item)))
                      .toList(),
                  onChanged: (value) => atualizar(() => tamanho = value!),
                ),
                const Text('Ingredientes extras',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, color: verde)),
                ...opcoesExtras.entries.map((item) => CheckboxListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      title: Text('${item.key} (+${dinheiro(item.value)})'),
                      value: extras.contains(item.key),
                      onChanged: (value) => atualizar(() => value!
                          ? extras.add(item.key)
                          : extras.remove(item.key)),
                    )),
                const Text('Remover ingredientes',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, color: verde)),
                ...ingredientes.map((item) => CheckboxListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      title: Text(item),
                      value: removidos.contains(item),
                      onChanged: (value) => atualizar(() => value!
                          ? removidos.add(item)
                          : removidos.remove(item)),
                    )),
                TextField(
                  controller: observacoes,
                  maxLines: 2,
                  decoration: const InputDecoration(
                      labelText: 'Observações',
                      hintText: 'Ex.: pouco molho, por favor',
                      border: OutlineInputBorder()),
                ),
                const SizedBox(height: 18),
                Builder(builder: (context) {
                  final adicional = extras.fold<int>(
                      0, (total, nome) => total + opcoesExtras[nome]!);
                  final ajusteTamanho = tamanho == 'Grande'
                      ? 500
                      : tamanho == 'Pequeno'
                          ? -300
                          : 0;
                  final preco = produto.centavos + adicional + ajusteTamanho;
                  return Text(dinheiro(preco),
                      style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: verde));
                }),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(sheetContext);
                    _adicionar(produto);
                  },
                  icon: const Icon(Icons.add_shopping_cart),
                  label: const Text('Adicionar ao carrinho'),
                ),
              ]),
        ));
      }),
    );
  }

  void _abrirCarrinho() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      backgroundColor: creme,
      builder: (sheetContext) =>
          StatefulBuilder(builder: (context, atualizarCarrinho) {
        void alterar(Produto produto, int delta) {
          setState(() {
            final quantidade = (_carrinho[produto] ?? 0) + delta;
            if (quantidade <= 0) {
              _carrinho.remove(produto);
            } else {
              _carrinho[produto] = quantidade;
            }
          });
          atualizarCarrinho(() {});
        }

        return SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 28),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Meu carrinho',
                    style: TextStyle(
                        fontSize: 28,
                        color: verde,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 18),
                if (_carrinho.isEmpty) ...[
                  const Padding(
                      padding: EdgeInsets.all(20),
                      child: Icon(Icons.shopping_bag_outlined,
                          color: turquesa, size: 54)),
                  const Text(
                      'Seu carrinho está vazio.\nEscolha seu temaki favorito!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 17)),
                  const SizedBox(height: 24),
                  ElevatedButton(
                      onPressed: () => Navigator.pop(sheetContext),
                      child: const Text('Ver cardápio')),
                ] else ...[
                  for (final item in _carrinho.entries) ...[
                    Text(item.key.nome,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: verde)),
                    Row(children: [
                      Expanded(
                          child: Text(dinheiro(item.key.centavos * item.value),
                              style: const TextStyle(fontSize: 17))),
                      IconButton(
                          tooltip: 'Remover ${item.key.nome}',
                          onPressed: () => alterar(item.key, -1),
                          icon: const Icon(Icons.remove_circle_outline)),
                      Text('${item.value}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17)),
                      IconButton(
                          tooltip: 'Adicionar ${item.key.nome}',
                          onPressed: () => alterar(item.key, 1),
                          icon: const Icon(Icons.add_circle_outline)),
                    ]),
                    const Divider(height: 24),
                  ],
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total',
                            style: TextStyle(
                                fontSize: 23, fontWeight: FontWeight.bold)),
                        Text(dinheiro(_total),
                            style: const TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                color: verde)),
                      ]),
                  const SizedBox(height: 12),
                  const Text('Pedido demonstrativo • sem cobrança',
                      style: TextStyle(fontSize: 13, color: verde)),
                  const SizedBox(height: 18),
                  ElevatedButton(
                    onPressed: () {
                      final total = _total;
                      setState(() => _carrinho.clear());
                      Navigator.pop(sheetContext);
                      showDialog<void>(
                          context: this.context,
                          builder: (context) => AlertDialog(
                                title: const Text(
                                    'Pedido demonstrativo concluído!'),
                                content: Text(
                                    'Total: ${dinheiro(total)}\n\nObrigado por experimentar o Sabor do Mar. Nenhum pedido real foi enviado.'),
                                actions: [
                                  TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Voltar ao cardápio'))
                                ],
                              ));
                    },
                    child: const Text('Concluir demonstração'),
                  ),
                ],
              ]),
        ));
      }),
    );
  }
}
