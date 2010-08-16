module CallTrace::Procs

	def self.nested_method_calls
		methods = [] # keep track of methods we've seen
		Proc.new do |event, file, line, id, binding, classname|
			if (event == 'call' || event == 'c-call') && classname.to_s != 'CallTrace'
				stack = eval('caller', binding)
				calling_method = self.method_name_from_caller(stack[0])
				if methods.empty?
					methods << id.to_s
				elsif calling_method == methods.last
					methods << id.to_s
				elsif (i = methods.rindex(calling_method))
					methods = methods[0, i]
					methods << id.to_s
				else
					methods.clear
					methods << id.to_s
				end
				puts ('. ' * (methods.size - 1)) +
					self.classname_or_blank(classname) +
				  id.to_s +
					" --- #{file} (#{line})"
			end
		end
	end

	private

	def self.method_name_from_caller(str)
		if str
			m = str.match(/`(\w+)'/)
			(m && m.captures.size > 0) ? m.captures[0] : nil
		end
	end

	def self.classname_or_blank(cname)
		cname ? cname.to_s + '.' : ''
	end

end
