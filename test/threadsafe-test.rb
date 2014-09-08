require '../lib/hiredis.rb'
require 'hiredis'

@conn = Hiredis::ThreadSafeConnection.new
@conn.connect("127.0.0.1", 6379)

$stderr.puts "Could not connect" unless @conn

def push_data
  Thread.new do
    begin
      key = rand(100000000000)

      1000.times do |i|
        @conn.write ["SET", "temp://#{key.to_s}#{key}#{i}", i]
        @conn.write ["EXPIRE", "temp://#{key.to_s}#{key}#{i}", 5]
        @conn.read
      end

      1000.times do
        @conn.read
      end

      1000.times do |i|
        @conn.write ["GET", "temp://#{key.to_s}#{key}#{i}"]
      end

      1000.times do |i|
        res = @conn.read.to_i
        if res != i
          raise "not equal"
        end
      end

      p "Test passed! #{key}"
    rescue => e
      $stderr.puts e
    end
  end
end

100.times do
  push_data
end

loop do
  sleep 1
end
