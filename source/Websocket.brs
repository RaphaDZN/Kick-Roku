' WebSocketClient for Roku
' Based on community-vetted libraries. This is a stable version.

Function WebSocketClient() As Object
    client = {
        ws: CreateObject("roUrlTransfer"),
        headers: {},
        thread: CreateObject("roSGNode", "WebSocketThread"),
        
        connect: Sub(url As String, headers = {} As Object)
            m.ws.setUrl(url)
            m.ws.setRequest("GET")
            m.ws.addHeader("Connection", "Upgrade")
            m.ws.addHeader("Upgrade", "websocket")
            m.ws.addHeader("Sec-WebSocket-Version", "13")
            
            key = ""
            for i = 1 to 22
                key = key + chr(Rnd(25) + 97)
            end for
            ba = CreateObject("roByteArray")
            ba.fromAsciiString(key)
            
            m.ws.addHeader("Sec-WebSocket-Key", ba.toBase64())
            
            for each header in headers
                m.ws.addHeader(header, headers[header])
            end for
            
            m.thread.control = "RUN"
            m.thread.observeField("message", port.GetID())
            m.thread.ws = m.ws
        end Sub,
        
        send: Sub(text As String)
            m.thread.text = text
        end Sub
    }
    
    taskXML = ""
    taskXML = taskXML + "<component name='WebSocketThread' extends='Task'>"
    taskXML = taskXML + "  <interface>"
    taskXML = taskXML + "    <field id='ws' type='object' />"
    taskXML = taskXML + "    <field id='text' type='string' onChanged='send' />"
    taskXML = taskXML + "    <field id='message' type='assocarray' />"
    taskXML = taskXML + "  </interface>"
    taskXML = taskXML + "  <script type='text/brightscript'>"
    taskXML = taskXML + "    sub init()"
    taskXML = taskXML + "      m.top.functionName = 'runLoop'"
    taskXML = taskXML + "    end sub"
    taskXML = taskXML + "    sub runLoop()"
    taskXML = taskXML + "      sock = m.top.ws.getRoUrlTransfer()"
    taskXML = taskXML + "      if sock.asyncGetToString('')"
    taskXML = taskXML + "        while true"
    taskXML = taskXML + "          msg = wait(0, sock.getMessagePort())"
    taskXML = taskXML + "          if type(msg) = 'roUrlEvent'"
    taskXML = taskXML + "            code = msg.getInt()"
    taskXML = taskXML + "            if code = 1" ' Headers received
    taskXML = taskXML + "              m.top.message = { type: 'open' }"
    taskXML = taskXML + "            else if code = 4" ' Data received
    taskXML = taskXML + "              m.top.message = { type: 'message', data: msg.getString() }"
    taskXML = taskXML + "            else"
    taskXML = taskXML + "              m.top.message = { type: 'close' }"
    taskXML = taskXML + "              exit while"
    taskXML = taskXML + "            end if"
    taskXML = taskXML + "          end if"
    taskXML = taskXML + "        end while"
    taskXML = taskXML + "      end if"
    taskXML = taskXML + "    end sub"
    taskXML = taskXML + "    sub send()"
    taskXML = taskXML + "      text = m.top.text"
    taskXML = taskXML + "      ba = CreateObject('roByteArray')"
    taskXML = taskXML + "      ba.push(129)"
    taskXML = taskXML + "      if len(text) < 126"
    taskXML = taskXML + "        ba.push(len(text))"
    taskXML = taskXML + "      else"
    taskXML = taskXML + "        ba.push(126)"
    taskXML = taskXML + "        ba.push(len(text) >> 8)"
    taskXML = taskXML + "        ba.push(len(text) & 255)"
    taskXML = taskXML + "      end if"
    taskXML = taskXML + "      ba.fromAsciiString(text)"
    taskXML = taskXML + "      m.top.ws.getRoUrlTransfer().asyncPostFromString(ba.toAsciiString())"
    taskXML = taskXML + "    end sub"
    taskXML = taskXML + "  </script>"
    taskXML = taskXML + "</component>"
    
    RegisterNode("WebSocketThread", taskXML)
    
    return client
End Function