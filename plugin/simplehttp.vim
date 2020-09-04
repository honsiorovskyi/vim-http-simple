command! -range HttpRequest <line1>,<line2>call simplehttp#request()

function! simplehttp#request() range
	let lines = getline(a:firstline,a:lastline)
	let hostMatch = matchlist(lines, '\chost:\s*\(.*\)')
	if len(hostMatch) < 1
		echo "Host header is missing. Aborted."
		return
	endif

	let host = hostMatch[1]
	let command = "socat openssl:" . host . ":443 stdio" 
	let input = join(lines, "\n") . "\n\n"
	
	let result = systemlist(command, input)
	let i = 0
	while i < len(result) 
		let result[i] = substitute(result[i], "", "", "g")
		let i = i + 1
	endwhile
	call append(a:lastline, [''] + result)
endfunction

