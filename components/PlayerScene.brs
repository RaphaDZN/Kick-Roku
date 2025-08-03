' ===============================================================
' LÓGICA DA TELA PRINCIPAL (Versão Final com ApiTask)
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
end sub

' Esta função é chamada QUANDO o operário termina o trabalho
sub onStreamsLoaded(event as object)
    streamsData = event.getData()
    print "[VerdeStream DEBUG] HomeScene notificada. Dados recebidos: "; streamsData

    if streamsData <> invalid and streamsData.channels <> invalid
        print "[VerdeStream DEBUG] Dados válidos. Desenhando a grade de streams..."
        displayStreams(streamsData.channels)
    else
        print "[VerdeStream DEBUG] ERRO ou DADOS VAZIOS: A grade não será populada."
    end if
end sub

' Exibe os streams na grade
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

' --- O restante das funções permanece o mesmo ---

sub onSearchSelected()
    keyboard = createObject("roSGNode", "Keyboard")
    keyboard.observeField("text", "onSearchText")
    keyboard.show()
end sub

sub onSearchText()
    keyboard = m.top.findNode("Keyboard")
    if keyboard <> invalid
        searchText = keyboard.text
        if searchText <> invalid and searchText <> ""
           m.global.showScene("PlayerScene", { streamerSlug: searchText })
        end if
    end if
end sub

sub onStreamSelected()
    selectedItem = m.streamsGrid.content.getChild(m.streamsGrid.itemSelected)
    m.global.showScene("PlayerScene", { streamerSlug: selectedItem.streamerSlug })
end sub

sub onFocusChange()
    if m.top.hasFocus() and m.streamsGrid.content <> invalid and m.streamsGrid.content.getChildCount() > 0
        m.streamsGrid.setFocus(true)
    end if
end sub