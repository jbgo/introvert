class CallTrace

	autoload :Procs, 'call_trace/procs'
	
	@@trace_proc = 
		Proc.new do |event, file, line, id, binding, classname|
			printf "%8s %s:%-2d %10s %8s\n", event, file, line, id, classname
		end

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
		self.use_trace_proc(Procs.send(proc_sym)) if proc_sym
		self.start
		yield
		self.stop
	end

	# You can pass a proc object or a block, but not both
	def self.use_trace_proc(p, &b)
		@@trace_proc = p or b
	end

end
