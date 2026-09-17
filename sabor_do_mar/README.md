# Sabor do Mar — Temakeria

Aplicativo Flutter acadêmico de DDM1 / ISW-012.

**Autores:** Ana Carolina Sabino e Caio Henrique C. R. Cunha.
Os nomes também estão no corpo da classe `Principal`, em `lib/main.dart`.

## Executar

Abra esta pasta (a que contém `pubspec.yaml`) no VS Code ou Android Studio.
Com o Flutter instalado, execute no terminal:

```sh
flutter pub get
flutter run -d chrome
```

Para Android, inicie um emulador ou conecte um aparelho com depuração USB e execute `flutter run`.
O projeto inclui as pastas Android e Web. O APK não está incluído.
Para gerá-lo em um ambiente Android configurado: `flutter build apk --release`.

## Interface e funcionamento

A tela inicial adapta a referência fornecida: cabeçalho verde-petróleo, fundo creme,
produto em destaque, preço, botão de pedido e três favoritos. As fotos são assets locais.
Em telas largas, os favoritos ficam em uma Row; em telas menores, ficam em uma Column
para manter os textos legíveis. A composição é inspirada na imagem, não uma cópia pixel a pixel.

- “Pedir agora” adiciona o Temaki Salmão ao carrinho.
- Tocar em um favorito abre sua descrição e o botão de adicionar.
- O ícone superior abre o carrinho com quantidades, remoção e total em reais.
- “Concluir demonstração” exibe a confirmação e esvazia o carrinho.
- O menu lateral oferece cardápio, carrinho e informações sobre a temakeria.

Os pedidos são apenas demonstrativos: não há pagamento, servidor ou envio ao restaurante.
O estado do carrinho é mantido em memória e reinicia ao fechar/recarregar o app.

## Requisitos da atividade

| Requisito | Onde aparece |
| --- | --- |
| MaterialApp | `Principal.build`, em `lib/main.dart` |
| Scaffold e AppBar | `TelaInicial` e `_appBar`, em `lib/tela_inicial.dart` |
| Row e Column | Marca, apresentação, cartões e carrinho |
| Text estilizados | Títulos, descrições, preços e etiquetas em `lib/componentes.dart` |
| ElevatedButton | Botão “PEDIR AGORA”, adicionar e concluir |
| MainAxisAlignment | Marca centralizada e total do carrinho |
| CrossAxisAlignment | Textos alinhados à esquerda e linha de favoritos |
| Métodos/widgets separados | `_appBar`, `_menu`, `_favoritos`, `ProdutoDestaque`, `CartaoProduto` etc. |
| ListView, opcional | Rolagem do cardápio, necessária nas telas menores |
| Autores na classe Principal | Comentário dentro da classe em `lib/main.dart` |

A organização segue os exemplos das aulas 05 e 06 do ZIP fornecido.
Os exercícios de perfil e Hello World presentes no material são exemplos didáticos;
a implementação entregue atende à solicitação da temakeria.

## Organização

- `lib/main.dart`: entrada, classe Principal e tema Material.
- `lib/tema.dart`: cores e estilo dos títulos.
- `lib/produto.dart`: produtos, preços em centavos e formatação monetária.
- `lib/componentes.dart`: widgets visuais reutilizáveis.
- `lib/tela_inicial.dart`: tela, navegação e estado do carrinho.
- `assets/images/`: quatro fotos geradas para o cardápio.
- `assets/fonts/`: Roboto e licença fornecida pelo SDK Flutter.
- `test/widget_test.dart`: testes das interações e do layout.

## Verificação

```sh
flutter analyze
flutter test
flutter build web
```

Validado com Flutter 3.47.2 / Dart 3.13.2: análise sem problemas, seis testes passando
(duas jornadas do carrinho e quatro larguras: 320, 390, 768 e 1024 pixels) e compilação web.
A compilação Android depende do SDK/JDK local e não foi validada nesta entrega.

As imagens foram geradas com a ferramenta integrada ImageGen. Os prompts estão em
`assets/images/PROMPTS.md`. As fontes e o renderizador web são incluídos localmente.
