# Teste técnico Flutter — Cotação de moedas via WebSocket

Solução de um **desafio técnico de Flutter** (template `foxbit_hiring_test_template`): uma tela que lista pares de moedas negociados (ex.: `BTC/BRL`) e mostra a **cotação em tempo real**, consumindo uma API **WebSocket**. O projeto segue **Clean Architecture** com `flutter_clean_architecture` e inclui testes automatizados para a camada de conexão.

O enunciado original, com os critérios de avaliação e o contrato do WebSocket, está em [ENUNCIADO.md](ENUNCIADO.md).

## O que o app faz

1. Abre a conexão WebSocket e mantém o *heartbeat*.
2. Chama `getInstruments` para listar os pares disponíveis (`InstrumentId`, `Symbol`, `SortIndex`).
3. Faz `SubscribeLevel1` para cada par e atualiza a tela a cada mudança: `LastTradedPx` (cotação atual), `Rolling24HrVolume` e `Rolling24HrPxChange`.

## Conceitos técnicos

**Clean Architecture em quatro camadas.**

| Camada | Pasta | Papel |
| --- | --- | --- |
| Domain | `lib/domain` | Contratos de repositório e *use cases* (`HeartbeatUseCase`) |
| Data | `lib/data` | Implementação dos repositórios e o helper de WebSocket |
| Device | `lib/device` | Recursos específicos do dispositivo |
| App | `lib/app` | Páginas (padrão **MVP/Presenter** + Controller), widgets e navegação |

**Padrão View–Controller–Presenter.** O pacote `flutter_clean_architecture` divide cada tela em `View`, `Controller` e `Presenter`; o *presenter* executa os *use cases* e entrega os resultados ao controller, que atualiza a view.

**Streams e programação reativa.** Os *use cases* retornam `Stream`s e a atualização contínua de cotações é tratada com `rxdart`.

**Protocolo de mensagens WebSocket.** Cada mensagem é um envelope JSON `{ m, i, n, o }` (tipo, sequência, nome da chamada e *payload* serializado em string), que exige decodificar duas vezes (envelope e `o`).

**Testes.** `test/` contém testes de ping/conexão do WebSocket e um observador de testes padrão, para validar a comunicação sem depender da interface.

## Stack

Flutter · Dart · `flutter_clean_architecture` · `rxdart` · `websok` · `lint`

## Estrutura

```
lib/
  app/        # pages (home), widgets (cotation_widget), navigator
  data/       # websocket helper, repositories
  device/     # utilitários de dispositivo
  domain/     # repositories (contratos), usecases
  main.dart
test/         # conexão/ping do WebSocket
```

## Como executar

```bash
flutter pub get
flutter run
flutter test
```

> O projeto usa um SDK antigo do Dart (`>=2.7.0 <3.0.0`); use uma versão compatível do Flutter (por exemplo via FVM).
