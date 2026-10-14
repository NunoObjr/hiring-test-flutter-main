# Teste técnico Flutter — Cotação de moedas via WebSocket

Base de um **desafio técnico de Flutter** (template `foxbit_hiring_test_template`): construir uma tela que lista pares de moedas negociados (ex.: `BTC/BRL`) e mostra a **cotação em tempo real**, consumindo uma API **WebSocket**. O projeto está estruturado em **Clean Architecture** com `flutter_clean_architecture`.

> **Status:** ponto de partida. A infraestrutura de WebSocket, o *use case* de heartbeat, o widget de cotação e o teste de ping estão prontos; a listagem (`getInstruments`) e a assinatura de cotações (`SubscribeLevel1`) descritas no desafio ainda **não foram implementadas**.

O enunciado original, com os critérios de avaliação e o contrato do WebSocket, está em [ENUNCIADO.md](ENUNCIADO.md).

## O que já existe

| Item | Onde |
| --- | --- |
| Helper de conexão WebSocket com geração de ids e `BehaviorSubject` para as respostas | `lib/data/helpers/websocket.dart` |
| Contrato e implementação do repositório de *heartbeat* | `lib/domain/repositories`, `lib/data/repositories` |
| *Use case* de heartbeat (`HeartbeatUseCase`) | `lib/domain/usecases` |
| Tela inicial e widget de card de cotação (`CotationWidget`) | `lib/app/pages/home`, `lib/app/widgets` |
| Teste de conexão e ping do WebSocket | `test/websocket_ping_test.dart` |

## Próximos passos (conforme o desafio)

- [ ] Implementar `getInstruments` e listar os pares (`InstrumentId`, `Symbol`, `SortIndex`)
- [ ] Assinar `SubscribeLevel1` por par e atualizar `LastTradedPx`, `Rolling24HrVolume` e `Rolling24HrPxChange`
- [ ] Ligar os dados ao `CotationWidget` na tela inicial
- [ ] Cobrir os novos fluxos com testes automatizados

## Conceitos técnicos

**Clean Architecture em camadas.**

| Camada | Pasta | Papel |
| --- | --- | --- |
| Domain | `lib/domain` | Contratos de repositório e *use cases* |
| Data | `lib/data` | Implementação dos repositórios e helper de WebSocket |
| Device | `lib/device` | Recursos específicos do dispositivo |
| App | `lib/app` | Páginas (View + Controller + Presenter), widgets e navegação |

**View–Controller–Presenter.** O pacote `flutter_clean_architecture` divide cada tela em `View`, `Controller` e `Presenter`; o *presenter* executa os *use cases* e devolve os resultados ao controller, que atualiza a view.

**Streams e programação reativa.** Os *use cases* retornam `Stream`s, e `rxdart` (`BehaviorSubject`) entrega a última mensagem recebida a quem se inscrever.

**Protocolo de mensagens.** Cada mensagem é um envelope JSON `{ m, i, n, o }` (tipo, sequência, nome da chamada e *payload* serializado em string), o que exige decodificar duas vezes (envelope e `o`).

## Stack

Flutter · Dart · `flutter_clean_architecture` · `rxdart` · `websok` · `lint`

## Como executar

```bash
flutter pub get
flutter run
flutter test
```

> O projeto usa um SDK antigo do Dart (`>=2.7.0 <3.0.0`); use uma versão compatível do Flutter (por exemplo via FVM).
