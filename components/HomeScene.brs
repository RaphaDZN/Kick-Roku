' ===============================================================
' LÓGICA DA TELA PRINCIPAL (Versão de Debug com Prints)
' ===============================================================

sub init()
    m.streamsGrid = m.top.findNode("streamsGrid")
    m.searchButton = m.top.findNode("searchButton")
    
    m.top.observeField("focusedChild", "onFocusChange")
    m.streamsGrid.observeField("itemSelected", "onStreamSelected")
    m.searchButton.observeField("buttonSelected", "onSearchSelected")
    
    print "[VerdeStream DEBUG] HomeScene iniciada. Contratando o ApiTask..."
    
    ' Contrata o nosso novo operário especializado
    apiTask = CreateObject("roSGNode", "ApiTask")
    apiTask.observeField("result", "onStreamsLoaded")
    apiTask.control = "RUN"
    
    ' ===============================================================
    ' A LINHA QUE FALTAVA (A "MESA" DO OPERÁRIO)
    ' Anexamos a task à cena para que o "faxineiro" não a remova.
    ' ===============================================================
    m.top.appendChild(apiTask)
end sub
' Esta função roda na THREAD DE LÓGICA, de forma segura.
function loadStreamsTask() as object
    print "[VerdeStream DEBUG] Task iniciada. Chamando getCategoryStreams()..."
    apiResult = getCategoryStreams()
    print "[VerdeStream DEBUG] Resultado da API recebido na Task: "; apiResult
    return apiResult
end function

' Esta função é chamada QUANDO a task termina, de volta na THREAD DE DESIGN.
sub onStreamsLoaded()
    print "[VerdeStream DEBUG] Task concluída. Observador 'onStreamsLoaded' ativado."
    taskNode = m.top.findNode("apiTask")
    streamsData = taskNode.result
    print "[VerdeStream DEBUG] Dados recebidos pela cena: "; streamsData

    if streamsData <> invalid and streamsData.channels <> invalid
        print "[VerdeStream DEBUG] Dados válidos. Exibindo streams..."
        displayStreams(streamsData.channels)
    else
        print "[VerdeStream DEBUG] ERRO ou DADOS VAZIOS: Dados inválidos ou vazios recebidos da API. A grade não será populada."
    end if
end sub

' Exibe os streams na grade.
sub displayStreams(streams as object)
    gridContent = CreateObject("roSGNode", "ContentNode")
    for each stream in streams
        item = gridContent.createChild("ContentNode")
        item.title = stream.user.username
        item.subtitle = stream.session_title
        item.streamerSlug = stream.slug
        item.HDGRIDPOSTERURL = stream.thumbnail.url
    end for
    m.streamsGrid.content = gridContent
    print "[VerdeStream DEBUG] Grade populada com "; streams.count(); " itens."
end sub

' Evento de clique no botão de busca.
sub onSearchSelected()
    keyboard = createObject("roSGNode", "Keyboard")
    keyboard.observeField("text", "onSearchText")
    keyboard.show()
end sub

' Evento de texto inserido na busca.
sub onSearchText()
    keyboard = m.top.findNode("Keyboard")
    if keyboard <> invalid
        searchText = keyboard.text
        if searchText <> invalid and searchText <> ""
           m.global.showScene("PlayerScene", { streamerSlug: searchText })
        end if
    end if
end sub

' Evento de clique em um stream da grade.
sub onStreamSelected()
    selectedItem = m.streamsGrid.content.getChild(m.streamsGrid.itemSelected)
    m.global.showScene("PlayerScene", { streamerSlug: selectedItem.streamerSlug })
end sub

' Garante que a grade tenha o foco inicial.
sub onFocusChange()
    if m.top.hasFocus() and m.streamsGrid.content <> invalid and m.streamsGrid.content.getChildCount() > 0
        m.streamsGrid.setFocus(true)
    end if
end sub