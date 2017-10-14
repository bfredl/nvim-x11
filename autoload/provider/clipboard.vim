
let g:nvimx11_path =  expand( '<sfile>:p:h:h:h' )
lua <<EOT
 nvimX11 = require('nvimX11')
EOT

function! provider#clipboard#Call(method, args) abort
  if get(s:, 'here', v:false)  " Clipboard provider must not recurse. #7184
    return 0
  endif
  let s:here = v:true
  try
    return provider#clipboard#invoke(a:method, a:args)
  finally
    let s:here = v:false
  endtry
endfunction

function! provider#clipboard#invoke(method, args) abort
  if a:method == "get"
    let sel = a:args[0]
    let [str, regtype] = luaeval("{nvimX11.get(_A)}", sel)

    " TODO: this should be an elementary operation:
    if type(str) == v:t_string
      let data = split(str, "\n", v:true)
    elseif type(str) == v:t_dict
      if str._TYPE != v:msgpack_types['string']
        echoerr "blargh"
      end
      let data = str._VAL
    end

    return [data, regtype]
  elseif a:method == "set"
    let [data, regtype, sel] = a:args
    let str = {'_TYPE': v:msgpack_types['string'], '_VAL': data}
    call luaeval("nvimX11.set(_A.sel, _A.str, _A.regtype)", l:)
    return 1
  end
endfunction
