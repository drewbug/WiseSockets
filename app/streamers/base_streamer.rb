class BaseStreamer
  def initialize
    @clients = []
    @on_update = nil
    on_init if respond_to? :on_init
    enable! if App::Persistence[:"#{__key__}_enabled"]
  end

  def update(val)
    send_packet jsonify(val).to_data if App::Persistence[:"#{__key__}_enabled"]
    @on_update.call val unless @on_update.nil?
  end

  def on_update(&block)
    @on_update = block
  end

  def stop_updates
    @on_update = nil
  end

  def enable!
    @socket = GCDAsyncSocket.alloc.initWithDelegate(self, delegateQueue:Dispatch::Queue.main.dispatch_object)
    Pointer.new(:object).tap { |error| @socket.acceptOnPort(self.port, error: error) }
  end

  def disable!
    @socket.disconnect
  end

  def enabled?
    App::Persistence[:"#{__key__}_enabled"]
  end

  def enabled=(value)
    App::Persistence[:"#{__key__}_enabled"] = value
    value ? enable! : disable!
  end

  def port
    App::Persistence[:"#{__key__}_port"]
  end

  def port=(value)
    App::Persistence[:"#{__key__}_port"] = value
  end

  def socket(_, didAcceptNewSocket: socket)
    @clients << socket
  end

  def socketDidDisconnect(socket, withError: error)
    @clients.delete socket
  end

  def send_packet(data)
    @clients.each_with_index do |client, i|
      client.writeData(data, withTimeout: 15.0, tag: i)
    end
  end
end
