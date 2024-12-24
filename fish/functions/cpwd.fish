function cpwd --description 'pwd copied to clipboard'
  command pwd | tr -d '\n' | xclip -se clipboard; and echo 'pwd copied to clipboard';
end
