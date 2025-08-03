# Kick-Roku
Um cliente não-oficial de código aberto para a plataforma Kick em dispositivos Roku.
# VerdeStream 📺

![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)
![Platform](https://img.shields.io/badge/Platform-Roku-purple)

Um cliente não-oficial e de código aberto para a plataforma de streaming Kick, construído para dispositivos Roku.

*Read this in other languages: [English](#english-version-🇬🇧), [Português](#versão-em-português-🇧🇷).*

---

### Versão em Português 🇧🇷

![Screenshot do App](https://image.roku.com/developer_channels/prod/45d673c3649cde276c6f20b43dcc7392257045dddaaefc7be868a47b0f7db91a.png) 


### Sobre o Projeto

O VerdeStream nasceu da ausência de um aplicativo oficial da Kick para a popular plataforma Roku. Este projeto é uma prova de conceito e um esforço da comunidade para preencher essa lacuna, permitindo que usuários assistam às suas streams favoritas diretamente em suas TVs.

### ⚠️ Status Atual e Aviso Importante

**O aplicativo está funcional, mas atualmente não consegue se conectar à API da Kick devido a um bloqueio do lado do servidor (`Erro 403 Forbidden`).**

A jornada de desenvolvimento deste app foi longa e cheia de desafios. Nós implementamos com sucesso o fluxo de autenticação de aplicativo (`Client Credentials`) conforme a documentação oficial da Kick. No entanto, mesmo com credenciais válidas e requisições corretamente formatadas, o servidor de autenticação da Kick recusa o acesso.

Acreditamos que isso se deva a uma das seguintes razões, que estão fora do nosso controle:
1.  **Aprovação Manual:** A Kick pode exigir um processo de aprovação manual para novos aplicativos de desenvolvedor.
2.  **API Restrita:** O acesso pode ser restrito apenas a parceiros oficiais.

O código está pronto e funcional, esperando que a porta de acesso da Kick seja aberta para clientes de terceiros.

### Funcionalidades
-   **Autenticação de Aplicativo:** Fluxo `OAuth2 Client Credentials` completo.
-   **Navegação:** Visualização da grade de categorias (a ser populada pela API).
-   **Busca:** Funcionalidade de busca por canais.
-   **Player de Vídeo:** Player integrado para assistir às streams.
-   **Chat ao Vivo:** Suporte para visualização do chat em tempo real ao lado do vídeo.

### Como Instalar (Sideload)

Para instalar o VerdeStream, seu dispositivo Roku precisa estar em **Modo de Desenvolvedor**.

1.  **Ativar o Modo Desenvolvedor:** Com o controle remoto, pressione a sequência: **Casa x3, Cima x2, Direita, Esquerda, Direita, Esquerda, Direita.**
2.  Anote o endereço de IP do seu Roku e aceite os termos para reiniciar.
3.  **Empacotar o App:** Baixe o código deste repositório e comprima o **conteúdo** da pasta principal (as pastas `components`, `source`, `images` e o arquivo `manifest`) em um arquivo `.zip`.
4.  **Fazer o Sideload:** Acesse o IP do seu Roku em um navegador, faça o login de desenvolvedor, e use a ferramenta de upload para instalar o arquivo `.zip`.

### Como Configurar para Desenvolvimento

Para que o aplicativo funcione, você precisa de suas próprias credenciais da API da Kick.

1.  Crie uma "Developer Application" no [portal de desenvolvedores da Kick](https://docs.kick.com/getting-started/kick-apps-setup).
2.  Obtenha seu `Client ID` e `Client Secret`.
3.  Abra o arquivo `components/ApiTask.xml`.
4.  Insira suas credenciais nos campos indicados:
    ```xml
    CLIENT_ID = "INSIRA_SEU_CLIENT_ID_AQUI"
    CLIENT_SECRET = "INSIRA_SEU_CLIENT_SECRET_AQUI"
    ```

### Como Contribuir

Este é um projeto de código aberto. Forks, pull requests e a abertura de issues são muito bem-vindos! Se você descobrir uma solução para o bloqueio `403` ou tiver ideias para novas funcionalidades, sinta-se à vontade para contribuir.

### Licença

Distribuído sob a Licença MIT. Veja o arquivo `LICENSE` para mais informações.

---
---

### English Version 🇬🇧

![App Screenshot](https://image.roku.com/developer_channels/prod/45d673c3649cde276c6f20b43dcc7392257045dddaaefc7be868a47b0f7db91a.png)


### About The Project

VerdeStream was born from the lack of an official Kick application for the popular Roku platform. This project is a proof-of-concept and a community effort to bridge this gap, allowing users to watch their favorite streams directly on their TVs.

### ⚠️ Current Status & Important Notice

**The application is functional, but it is currently unable to connect to the Kick API due to a server-side block (`403 Forbidden` error).**

The development journey of this app was long and challenging. We successfully implemented the `Client Credentials` application authentication flow as per the official Kick documentation. However, even with valid credentials and correctly formatted requests, Kick's authentication server denies access.

We believe this is due to one of the following reasons, which are beyond our control:
1.  **Manual Approval:** Kick may require a manual review process for new developer applications.
2.  **Gated API:** Access might be restricted to official partners only.

The code is ready and functional, waiting for Kick's access door to be opened for third-party clients.

### Features
-   **App Authentication:** Full `OAuth2 Client Credentials` flow.
-   **Browse:** Category grid view (to be populated by the API).
-   **Search:** Channel search functionality.
-   **Video Player:** Integrated player to watch live streams.
-   **Live Chat:** Support for viewing the real-time chat alongside the video.

### How To Install (Sideload)

To install VerdeStream, your Roku device must be in **Developer Mode**.

1.  **Enable Developer Mode:** Using your remote, press the sequence: **Home x3, Up x2, Right, Left, Right, Left, Right.**
2.  Note your Roku's IP address and agree to the terms to restart.
3.  **Package the App:** Download the code from this repository and zip the **contents** of the main folder (the `components`, `source`, `images` folders, and the `manifest` file) into a `.zip` archive.
4.  **Sideload:** Access your Roku's IP address in a web browser, log in as a developer, and use the upload tool to install the `.zip` file.

### How to Configure for Development

For the app to work, you need your own Kick API credentials.

1.  Create a "Developer Application" on the [Kick developer portal](https://docs.kick.com/getting-started/kick-apps-setup).
2.  Obtain your `Client ID` and `Client Secret`.
3.  Open the file `components/ApiTask.xml`.
4.  Insert your credentials in the indicated fields:
    ```xml
    CLIENT_ID = "YOUR_CLIENT_ID_HERE"
    CLIENT_SECRET = "YOUR_CLIENT_SECRET_HERE"
    ```

### How to Contribute

This is an open-source project. Forks, pull requests, and opening issues are very welcome! If you discover a solution to the `403` block or have ideas for new features, feel free to contribute.

### License

Distributed under the MIT License. See the `LICENSE` file for more information.
