# Scout App — Instruções para o Codex

## Objetivo principal

Este projeto existe para eu me tornar um desenvolvedor Flutter profissional e independente.

O objetivo não é apenas terminar o aplicativo rapidamente. Ao concluir este projeto, devo ser capaz de:

* criar aplicativos Flutter do zero;
* compreender e aplicar arquitetura MVVM;
* configurar Android e iOS;
* integrar APIs, Firebase e serviços nativos;
* gerir estado, navegação e persistência;
* tratar erros, loading, timeout e conectividade;
* testar, depurar, otimizar e publicar aplicativos;
* personalizar completamente um projeto Flutter;
* configurar CI/CD e ambientes;
* compreender todas as alterações realizadas no projeto.

Não escondas complexidade importante apenas para terminar mais rapidamente.

## Referências técnicas

Usar como referência principal:

1. Documentação oficial do Flutter e Dart.
2. Recomendações oficiais de arquitetura Flutter.
3. Práticas reconhecidas da comunidade Flutter, incluindo ideias ensinadas por Andrea Bizzotto, Tadas Petra e outros desenvolvedores experientes.
4. Princípios sólidos de engenharia de software e desenvolvimento mobile.

Não copiar padrões cegamente. Avaliar se cada prática faz sentido para o Scout App.

## Arquitetura

O projeto deve usar MVVM.

### View

A View:

* é composta por widgets Flutter;
* apresenta o estado;
* recebe ações do utilizador;
* chama métodos do ViewModel;
* não acessa Firebase, APIs, banco local ou plugins diretamente;
* não contém regras de negócio;
* pode conter apenas lógica simples de layout, animação, visibilidade e navegação.

### ViewModel

O ViewModel:

* gere o estado da View;
* recebe ações da View;
* valida dados relacionados à apresentação;
* chama repositories ou use cases;
* transforma modelos de domínio em estado de UI;
* trata loading, sucesso e erro;
* deve ser testável sem depender de widgets.

Usar Riverpod para fornecer ViewModels, dependências e estado.

Escolher entre `Provider`, `NotifierProvider`, `AsyncNotifierProvider`,
`StreamProvider` e outros providers de acordo com a necessidade real.

Não usar um tipo de provider apenas por preferência.

### Repository

O Repository:

* é a fonte de verdade dos dados da funcionalidade;
* coordena serviços remotos e locais;
* trata cache, sincronização, retry e atualização quando necessário;
* retorna modelos de domínio;
* não conhece widgets;
* não deve depender de outro repository diretamente.

### Service

O Service:

* comunica com uma fonte externa;
* pode acessar REST API, Firebase, armazenamento local ou plugin nativo;
* não contém estado de UI;
* deve ter responsabilidade específica.

Exemplos:

* `AuthService`
* `FirestorePlayerService`
* `ScoutApiService`
* `LocationService`
* `LocalStorageService`

### Domain

A camada de domínio é opcional.

Criar use cases somente quando a lógica:

* combinar vários repositories;
* for complexa;
* for reutilizada por vários ViewModels;
* não pertencer claramente ao ViewModel nem ao Repository.

Evitar use cases para operações triviais.

## Organização

Preferir organização por funcionalidade.

Exemplo:

```text
lib/
├── app/
├── core/
└── features/
    └── authentication/
        ├── data/
        ├── domain/
        └── presentation/
```

Dentro de `presentation`, usar quando necessário:

```text
views/
view_models/
widgets/
states/
```

Não criar ficheiros, interfaces ou camadas vazias apenas para seguir um padrão.

## Estado

Preferir:

* estado imutável;
* fluxo de dados unidirecional;
* estados explícitos de loading, sucesso e erro;
* uma fonte de verdade para cada tipo de dado;
* tratamento adequado de estado assíncrono;
* reconstruções de widgets controladas.

Não manter a mesma informação em vários providers sem necessidade.

## Configuração Android

O projeto deve permitir aprendizagem prática sobre:

* `android/app/build.gradle` ou `build.gradle.kts`;
* `settings.gradle`;
* `gradle.properties`;
* Android SDK;
* `compileSdk`;
* `minSdk`;
* `targetSdk`;
* `namespace`;
* `applicationId`;
* variantes de build;
* permissões no `AndroidManifest.xml`;
* configuração de Firebase;
* `google-services.json`;
* ícones;
* splash screen;
* deep links;
* intent filters;
* notificações;
* localização;
* background services;
* ProGuard e R8;
* assinatura;
* keystore;
* criação de APK e App Bundle;
* publicação na Play Store.

Ao alterar configuração Android:

1. explicar qual ficheiro será alterado;
2. explicar o significado da configuração;
3. explicar o impacto em debug e release;
4. não colocar segredos diretamente no Git;
5. executar ou indicar os comandos de validação.

## Configuração iOS

O projeto deve permitir aprendizagem prática sobre:

* pasta `ios`;
* Xcode;
* `Runner`;
* Bundle Identifier;
* Deployment Target;
* `Info.plist`;
* permissões;
* capabilities;
* entitlements;
* Firebase;
* `GoogleService-Info.plist`;
* signing;
* certificates;
* provisioning profiles;
* App Store Connect;
* deep links;
* notificações;
* localização;
* background modes;
* criação e publicação de builds.

Mesmo quando o desenvolvimento atual for feito no Windows e Android,
manter a arquitetura preparada para iOS.

Não fingir que uma alteração iOS foi validada quando não houver acesso a macOS ou Xcode.

## Segredos e chaves

Nunca colocar segredos reais em:

* código Dart;
* `pubspec.yaml`;
* `AGENTS.md`;
* README;
* commits Git;
* ficheiros públicos.

Distinguir claramente:

* identificadores públicos;
* configurações públicas de cliente;
* API keys restritas;
* client secrets;
* tokens;
* senhas;
* chaves privadas;
* keystores;
* certificados.

Usar conforme o caso:

* variáveis de ambiente;
* `--dart-define`;
* ficheiros locais ignorados pelo Git;
* GitHub Actions Secrets;
* secrets do ambiente de deploy;
* restrições por package name, bundle ID, SHA ou domínio.

Criar ficheiros `.example` sem valores secretos quando necessário.

Antes de adicionar uma chave, explicar se ela é realmente secreta e quais restrições devem ser configuradas.

## Ambientes

Preparar o projeto progressivamente para:

* development;
* staging;
* production.

As configurações podem incluir:

* URLs diferentes;
* Firebase projects diferentes;
* logging diferente;
* chaves diferentes;
* package names ou bundle IDs diferentes;
* feature flags.

Não implementar flavors completos prematuramente. Introduzir quando houver uma necessidade concreta e explicar o processo.

## Firebase

Ao trabalhar com Firebase:

* explicar a configuração Android e iOS;
* separar Firebase SDK de Repository;
* tratar autenticação e erros;
* explicar persistência de sessão;
* configurar Firestore com modelos claros;
* considerar regras de segurança;
* não confiar apenas em validação do cliente;
* explicar índices necessários;
* tratar upload e download;
* evitar leituras desnecessárias;
* considerar custos e limites.

## Integração com API

Ao integrar REST APIs:

* usar cliente HTTP configurado;
* definir base URL por ambiente;
* tratar timeout;
* tratar autenticação;
* tratar códigos HTTP;
* mapear DTOs;
* separar DTO de modelo de domínio quando justificar;
* implementar retry apenas em operações seguras;
* considerar idempotência;
* tratar falta de internet;
* usar logs seguros;
* nunca registar tokens ou senhas.

## Armazenamento local e offline

Praticar:

* Hive ou solução local adequada;
* SharedPreferences apenas para valores simples;
* armazenamento seguro para credenciais sensíveis;
* cache;
* sincronização;
* resolução de conflitos;
* estado offline;
* expiração de dados;
* migração do banco local.

Não usar SharedPreferences como banco de dados principal.

## Plugins e recursos nativos

Ao adicionar um plugin:

1. verificar documentação oficial;
2. avaliar manutenção e compatibilidade;
3. explicar configuração Android;
4. explicar configuração iOS;
5. verificar permissões;
6. verificar lifecycle;
7. tratar erros e indisponibilidade;
8. evitar adicionar plugin quando o SDK já resolve adequadamente.

O projeto deve praticar, quando fizer sentido:

* câmera;
* galeria;
* localização;
* mapas;
* notificações;
* armazenamento;
* conectividade;
* partilha;
* biometria;
* background execution;
* deep links;
* app lifecycle;
* platform channels.

## UI e design

Praticar:

* temas claro e escuro;
* Material Design;
* design system;
* componentes reutilizáveis;
* responsividade;
* acessibilidade;
* internacionalização;
* animações;
* formulários;
* estados vazios;
* erros;
* skeletons e loading;
* adaptação a tamanhos e orientações diferentes.

Não transformar cada widget pequeno num componente separado sem benefício.

## Performance

Avaliar quando relevante:

* rebuilds;
* uso de `const`;
* listas grandes;
* imagens;
* cache;
* paginação;
* isolates;
* operações no main isolate;
* memória;
* startup;
* tamanho do aplicativo;
* consumo de rede;
* consumo de bateria.

Não aplicar otimizações sem medir ou justificar.

## Testes

Adicionar progressivamente:

* testes unitários de ViewModels;
* testes de repositories;
* testes de services com mocks ou fakes;
* widget tests;
* integration tests;
* testes de erros e estados assíncronos.

Evitar testes que apenas reproduzem a implementação sem verificar comportamento.

## Logging e erros

Criar uma estratégia consistente para:

* exceções;
* falhas esperadas;
* mensagens para o utilizador;
* logs de desenvolvimento;
* logs de produção;
* crash reporting.

Não mostrar stack traces ou detalhes internos ao utilizador.

Não ignorar exceções silenciosamente.

## Git e qualidade

Antes de finalizar uma alteração:

```bash
dart format .
flutter analyze
flutter test
```

Quando aplicável:

```bash
flutter test integration_test
flutter build apk
flutter build appbundle
```

Mostrar:

* ficheiros alterados;
* motivo de cada alteração;
* comandos executados;
* resultados;
* riscos;
* limitações;
* próximos passos.

Não modificar ficheiros não relacionados sem explicar.

## CI/CD

O projeto deve evoluir para uma pipeline que pratique:

* validação de formatação;
* análise estática;
* testes;
* build Android;
* gestão de segredos;
* geração de artefactos;
* assinatura;
* distribuição interna;
* deploy;
* versionamento;
* changelog;
* rollback quando aplicável.

Começar manualmente e automatizar após o processo estar compreendido.

## Forma de colaboração

Para tarefas grandes:

1. analisar o estado atual;
2. apresentar um plano;
3. identificar ficheiros afetados;
4. explicar decisões;
5. implementar em partes pequenas;
6. validar;
7. explicar o resultado.

Para tarefas de aprendizagem:

1. explicar o conceito;
2. mostrar onde ele aparece no projeto;
3. apresentar um exemplo pequeno;
4. deixar uma parte para eu implementar quando adequado;
5. rever a minha implementação;
6. explicar erros e melhorias.

Não completar automaticamente toda a funcionalidade quando eu estiver tentando praticar.

Quando eu pedir apenas explicação, não alterar ficheiros.

Quando eu pedir implementação, não parar apenas numa explicação.

## Honestidade técnica

Não afirmar que:

* testes passaram sem executá-los;
* Android foi validado sem executar as ferramentas;
* iOS foi validado sem macOS e Xcode;
* uma configuração está segura sem analisar o contexto;
* uma biblioteca é recomendada sem verificar documentação atual;
* uma solução funciona em produção apenas porque compila.

Indicar claramente qualquer limitação de validação.

## Resultado esperado

Ao final do Scout App, eu devo compreender:

* Flutter e Dart;
* arquitetura MVVM;
* Riverpod;
* GoRouter;
* Firebase;
* APIs;
* armazenamento local;
* Android;
* iOS;
* segurança;
* testes;
* performance;
* CI/CD;
* publicação;
* manutenção;
* depuração;
* customização completa do projeto.
