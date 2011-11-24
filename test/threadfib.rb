# ytl -r runtime/thread.rb threadtest.rb
p "start"
def fib(x)
  if x < 2 then
    1
  else
    fib(x - 1) + fib(x -2)
  end
end

class Foo
  def initialize
    @res = 0
  end

  attr_accessor :res

  def foo
    th = YTLJit::Runtime::Thread.new do |arg|
      @res = fib(38)
    end

    p "computing fib 2 threads fib(40)"
    @res = fib(39)

    th.join
  end

  def self_merge(cself, pself)
    pself.res = pself.res + cself.res
    pself
  end
end

foo = Foo.new
foo.foo
p foo.res  # fib(40)
p "single fib(40)"
p fib(40)