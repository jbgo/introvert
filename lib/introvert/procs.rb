module Introvert::Procs
	def self.all_events
		Proc.new do |event, file, line, id, binding, classname|
			printf "%8s %s:%-2d %10s %8s\n", event, file, line, id, classname
		end
	end

	def self.call_tree
		trace_call = /introvert\.rb:\d+:in `trace'$/
		Proc.new do |event, file, line, id, binding, classname|
			if (event == 'call' || event == 'c-call') && classname.to_s != 'Introvert'
				stack = eval('caller', binding)
				stack.each_with_index do |frame, index|
					if frame =~ trace_call
						if index <= 1 # in trace block
							puts
						else
							puts '. ' * (index - 2) + classname.to_s + '.' + id.to_s + '() => ' +
								   self.truncate_file_name(file) + ":(#{line}}"
						end
					end
				end
			end
		end
	end

	protected

	def self.truncate_file_name(fname)
		r = fname.rindex('/') || 0
		fname[r + 1, fname.length - r]
	end
end
