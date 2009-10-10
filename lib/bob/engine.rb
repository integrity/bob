module Bob
  # Different engines to run code in background. An engine is any object
  # that responds to #call and takes a Proc object, which should be executed
  # "in the background". The different engines are:
  module Engine
    autoload :Threaded, "bob/engine/threaded"
    Foreground = lambda {|b| b.call }
  end
end
