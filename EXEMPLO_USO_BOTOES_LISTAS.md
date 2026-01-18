# Exemplos de Uso - Botões e Listas WhatsApp

Este documento mostra como usar as novas funcionalidades de envio de mensagens com botões e listas na Evolution API.

## Importação

```typescript
import { useSendButtons, useSendList, useSendButtonsWithImage } from "@/lib/queries/chat/sendMessage";
```

## 1. Enviar Mensagem com Botões

```typescript
const { sendButtons } = useSendButtons();
const { instance } = useInstance(); // Supondo que você tem acesso à instância

// Exemplo de uso - Formato whaileys/Baileys (Whatsapp-Bot-esListas)
const enviarBotoes = async () => {
  const buttonsData = {
    number: "5511999999999@c.us",
    text: "Escolha uma opção:",
    footer: "Digite o número do botão",
    buttons: [
      {
        buttonId: "opcao1",
        buttonText: {
          displayText: "✅ Sim"
        },
        type: 1 // 1 = reply button
      },
      {
        buttonId: "opcao2",
        buttonText: {
          displayText: "❌ Não"
        },
        type: 1
      },
      {
        buttonId: "opcao3",
        buttonText: {
          displayText: "⏸️ Mais tarde"
        },
        type: 1
      }
    ]
  };

  await sendButtons({
    instanceName: instance.name,
    token: instance.token,
    data: buttonsData
  });
};
```

## 2. Enviar Mensagem com Lista (Sections)

```typescript
const { sendList } = useSendList();

// Exemplo de uso - Formato whaileys/Baileys (Whatsapp-Bot-esListas)
const enviarLista = async () => {
  const listData = {
    number: "5511999999999@c.us",
    text: "Escolha uma opção", // Texto opcional da mensagem
    title: "Título da Lista",
    buttonText: "Clique aqui",
    footer: "Rodapé da mensagem", // Opcional
    sections: [
      {
        title: "Seção 1",
        rows: [
          {
            rowId: "servico1", // Note: rowId ao invés de id
            title: "Serviço 1",
            description: "Descrição do serviço 1"
          },
          {
            rowId: "servico2",
            title: "Serviço 2",
            description: "Descrição do serviço 2"
          }
        ]
      },
      {
        title: "Seção 2",
        rows: [
          {
            rowId: "produto1",
            title: "Produto 1",
            description: "Descrição do produto 1"
          }
        ]
      }
    ]
  };

  await sendList({
    instanceName: instance.name,
    token: instance.token,
    data: listData
  });
};
```

## 3. Enviar Mensagem com Botões e Imagem

```typescript
const { sendButtonsWithImage } = useSendButtonsWithImage();

// Exemplo de uso - Formato whaileys/Baileys (Whatsapp-Bot-esListas)
const enviarBotoesComImagem = async () => {
  const buttonsWithImageData = {
    number: "5511999999999@c.us",
    image: {
      url: "https://exemplo.com/imagem.jpg"
      // OU usar base64:
      // media: "data:image/jpeg;base64,/9j/4AAQSkZJRg..."
    },
    caption: "Escolha uma opção:",
    footer: "Clique em um botão",
    buttons: [
      {
        buttonId: "btn1",
        buttonText: {
          displayText: "Botão 1"
        },
        type: 1
      },
      {
        buttonId: "btn2",
        buttonText: {
          displayText: "Botão 2"
        },
        type: 1
      }
    ],
    headerType: 4 // 4 = imagem no header
  };

  await sendButtonsWithImage({
    instanceName: instance.name,
    token: instance.token,
    data: buttonsWithImageData
  });
};
```

## Formato dos Dados (whaileys/Baileys - Whatsapp-Bot-esListas)

### Botões
- **buttonId**: ID único para identificar o botão quando clicado
- **buttonText.displayText**: Texto exibido no botão (máximo 20 caracteres recomendado)
- **type**: Deve ser `1` (tipo reply button)

### Listas
- **text**: Texto opcional da mensagem (aparece antes da lista)
- **title**: Título da lista (aparece no topo)
- **buttonText**: Texto do botão que abre a lista
- **footer**: Texto opcional no rodapé
- **sections**: Array de seções
  - Cada seção tem um `title` e `rows`
  - Cada `row` precisa de `rowId` (não `id`) e `title`
  - `description` é opcional mas recomendado

## Observações Importantes

1. **Limites**:
   - Máximo de 3 botões por mensagem
   - Máximo de 10 seções por lista
   - Máximo de 10 linhas por seção

2. **Formato de número**: Use o formato completo do WhatsApp com `@c.us` no final

3. **Tratamento de erros**: Sempre envolva as chamadas em try/catch

```typescript
try {
  await sendButtons({ ... });
  toast.success("Mensagem enviada com sucesso!");
} catch (error) {
  console.error("Erro:", error);
  toast.error("Erro ao enviar mensagem");
}
```
