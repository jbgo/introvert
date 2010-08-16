module CallTrace::Procs

#	def self.nested_method_calls
#		depth = 0
#		methods = []
#		Proc.new do |event, file, line, id, binding, classname|
#			env = eval(binding)
#			stack = env.caller
#			calling_method = self.method_name_from_caller(stack[0])
#			if calling_method == methods.last
#				depth += 1
#				methods << id
#			else
#				depth -= 1
#				methods.pop
#			end
#			puts ('. ' * depth) + self.maybe_classname(classname) + '.' + id
#		end
#	end

	def self.simple_proc
		count = 0
		Proc.new do |event, file, line, id, binding, classname|
			if event == 'call' || event == 'c-call'
				puts 'call #' + count.to_s
				count += 1
			end
		end
	end

	private

#	def self.method_name_from_caller(str)
#		if str
#			m = str.match(/`(\w+)'/)
#			(m && m.captures.size > 0) ? m.captures[0] : nil
#		end
#	end
#
#	def self.maybe_classname(cname)
#		cname ? cname + '.' : ''
#	end

end
