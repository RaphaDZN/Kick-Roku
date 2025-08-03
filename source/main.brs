' ===============================================================
' PONTO DE ENTRADA PRINCIPAL
' Responsável por iniciar e exibir as cenas do aplicativo.
' ===============================================================

sub Main()
    ' Objeto global para passar dados entre cenas
    m.global = {
        lastScene: invalid
    }
    showScene("HomeScene")
end sub

' Função genérica para mostrar qualquer cena
sub showScene(sceneName as string, sceneData = invalid)
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)
    scene = screen.createScene(sceneName)

    ' Passa dados para a cena que está sendo criada
    if sceneData <> invalid
        for each field in sceneData
            scene[field] = sceneData[field]
        end for
    end if

    screen.show()

    while(true)
        msg = wait(0, m.port)
        msgType = type(msg)
        if msgType = "roSGScreenEvent"
            if msg.isScreenClosed() then exit while
        end if
    end while
end sub