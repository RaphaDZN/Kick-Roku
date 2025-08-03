' ===============================================================
' LÓGICA DO COMPONENTE GridItem
' ===============================================================

' A função init() é chamada automaticamente quando o componente é criado.
sub init()
    ' Observa a mudança no campo "itemContent" e define a função
    ' "onContentChange" como a responsável por lidar com a mudança.
    m.top.observeField("itemContent", "onContentChange")
end sub

' Esta função é chamada sempre que um novo conteúdo é atribuído ao item.
sub onContentChange()
    ' Pega os dados do item que foram passados pelo Grid.
    itemData = m.top.itemContent
    
    ' Checa se os dados são válidos antes de tentar usá-los.
    if itemData <> invalid
        ' Encontra os elementos visuais pelo ID e atualiza suas propriedades.
        m.top.findNode("itemPoster").uri = itemData.HDGRIDPOSTERURL
        m.top.findNode("itemTitle").text = itemData.title
        m.top.findNode("itemSubtitle").text = itemData.subtitle
    end if
end sub