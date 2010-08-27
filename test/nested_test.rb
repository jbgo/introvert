require 'test_helper'

class MyClass
	def foo
		bar
		baz
	end
	def bar
		boo
	end
	def boo
		fee
		fum
	end
	def baz
		fi
	end
	def fee
	end
	def fi
		fo
		fum
	end
	def fo
	end
	def fum
	end
end

m = MyClass.new

Introvert.trace(:call_tree) do
	m.foo
end
