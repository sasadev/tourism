# -*- encoding: UTF-8 -*-
module HtmlTagHelper
####################################
#         link_to_remote           #
####################################

	JS_ESCAPE_MAP = {
			'\\'    => '\\\\',
			'</'    => '<\/',
			"\r\n"  => '\n',
			"\n"    => '\n',
			"\r"    => '\n',
			'"'     => '\\"',
			"'"     => "\\'"
	}

	CALLBACKS    = Set.new([ :complete, :error ] +
														 (100..599).to_a)

	JS_ESCAPE_MAP["\342\200\250"] = '&#x2028;'

	def escape_javascript(javascript)
		if javascript
			result = javascript.gsub(/(\\|<\/|\r\n|\342\200\250|[\n\r"'])/u) {|match| JS_ESCAPE_MAP[match] }
			javascript.html_safe? ? result.html_safe : result
		else
			''
		end
	end

	def link_to_remote(name, options = {}, html_options = {})
		link_to_function(name, remote_function(options), html_options || options.delete(:html))
	end

	def link_to_function(name, function, html_options={})
		onclick = "#{"#{html_options[:onclick]}; " if html_options[:onclick]}#{function}; return false;"
		href = html_options[:href] || '#'
		content_tag(:a, name, html_options.merge(:href => href, :onclick => onclick))
	end

	def remote_function(options={})
		javascript_options = options_for_ajax(options)
		callbacks = build_callbacks(options)

		function = ""

		update = ''
		if options[:update] && options[:update].is_a?(Hash)
			update  = []
			update << "success:'#{options[:update][:success]}'" if options[:update][:success]
			update << "failure:'#{options[:update][:failure]}'" if options[:update][:failure]
			update  = '{' + update.join(',') + '}'
		elsif options[:update]
			update << "'#{options[:update]}'"
		end

		function << "jQuery.ajax({"
		function << "type: '#{ options[:method] ? options[:method] : 'GET' }',"
		function << "url:  '#{ options[:url] ? url_for(options[:url]) : '#' }',"
		function << "data: #{ javascript_options },"
		callbacks.each {|callback,code| function << "#{callback.to_s}: #{code}, "	} if callbacks.present?
		function << "success: function(data) {"
		function << options[:success] + '; ' if options[:success].present?
		function << if options[:position]
									case options[:position].to_sym
										when :top
											"jQuery('##{options[:update]}').prepend(data); "
										when :bottom
											"jQuery('##{options[:update]}').append(data); "
										when :before
											"jQuery('##{options[:update]}').before(data); "
										when :after
											"jQuery('##{options[:update]}').after(data); "
										else
											"jQuery('##{options[:update]}').html(data); "
									end
								else
									"jQuery('##{options[:update]}').html(data); "
								end
		function << "} });"

		function = "#{options[:before]}; #{function}" if options[:before]
		function = "#{function}; #{options[:after]};"  if options[:after]
		function = "if (#{options[:condition]}) { #{function}; }" if options[:condition]
		function = "if (confirm('#{escape_javascript(options[:confirm])}')) { #{function}; } else { return false; }" if options[:confirm]
		return function.html_safe
	end

	def options_for_ajax(options)
		js_options={'parameters' => '""'}

		if options[:submit]
			submit = options[:submit]
			submit = [submit] if submit.is_a?(String)
			js_options['parameters'] = "jQuery('#{submit.map{|i| "##{i} input, ##{i} textarea,  ##{i} select, ##{i}"}.join(",")}').serialize('')"
		elsif options[:with]
			js_options['parameters'] = options[:with]
		end
		if protect_against_forgery? && !options[:form]
			if js_options['parameters']
				js_options['parameters'] << " + '&"
			else
				js_options['parameters'] = "'"
			end
			js_options['parameters'] << "#{request_forgery_protection_token}=' + encodeURIComponent('#{escape_javascript form_authenticity_token}')"
		end
		return js_options['parameters']
	end

	def build_callbacks(options)
		callbacks = {}
		options.each do |callback, code|
			if CALLBACKS.include?(callback)
				callbacks[callback] = "function(request){#{code}}"
			end
		end
		return callbacks
	end

	def method_option_to_s(method)
		(method.is_a?(String) and !method.index("'").nil?) ? method : "'#{method}'"
	end

	def link_to_modal(name, options = {}, html_options = {})
		options[:update] = "modal-body"
		html_options.merge!( data: { toggle: "modal",
																 target: "#admin-modal" } )
		link_to_remote(name, options, html_options)
	end

	def link_to_modal_front(name, options = {}, html_options = {})

		before_txt = "$('#leadModal').html('読み込み中...');"
		before_txt += 'parent.postMessage(JSON.stringify({"ancher":"pagetop"}),"*");'
		options.merge!(update: 'leanModal', before: before_txt)
		html_options.merge!( href: '#leanModal', rel: 'leanModal' )
		link_to_remote(name, options, html_options)
	end

end
