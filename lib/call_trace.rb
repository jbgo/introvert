class CallTrace
	@@trace_proc = 
		Proc.new do |event, file, line, id, binding, classname|
			printf "%8s %s:%-2d %10s %8s\n", event, file, line, id, classname
		end

	BUILTIN_PROCS = {
		:ruby_method_calls => Proc.new do |event, file, line, id, binding, classname|
			puts "#{classname}.#{id} -- (#{file}: #{line})" if event == 'call'
		end
	}

	# Start tracing globally. If a proc is given to this method, use the
	# given proc instead of the default proc.
	def self.start
		set_trace_func @@trace_proc
	end

	# Stop tracing globally
	def self.stop
		set_trace_func nil
	end

	# Convenience wrapper for tracing a specific block of code
	def self.trace(proc_sym=nil)
		self.use_trace_proc(&BUILTIN_PROCS[proc_sym]) if BUILTIN_PROCS.has_key?(proc_sym)
		self.start
		yield
		self.stop
	end

	def self.use_trace_proc(&p)
		@@trace_proc = p
	end
end
