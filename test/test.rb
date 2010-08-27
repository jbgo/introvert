require File.join(File.dirname(__FILE__), 'test_helper')

class TraceTest
	def sos(a,b)
		a*a + b*b
	end
	class Inner
		def huh(c,d)
			c + d - (d - c)
		end
	end
end

Introvert.trace do
	c = TraceTest.new
	c.sos(3,4)
	d = TraceTest::Inner.new
	d.huh(5,6)
end
