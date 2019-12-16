# bashsig.sh

## Examples

```bash
. bashsig.sh
your_function () { $(bashsig gives you arguments)
  echo "$arguments"
}
echo "Hello $(your_function a small world)!"
# => Hello world!
```
```bash
. bashsig.sh
your_function () { $(bashsig -g: pokemon)
  if [[ ${g:=8} -ne 8 ]]; then
    echo "Wrong pokemon generation!"
    return 1
  fi
  echo "I love $pokemon!"
}
echo -g 5 Pikachu
# => Wrong pokemon generation!
echo -g 8 Vulpix
# => I love Vulpix!
```
```bash
. bashsig.sh
log-wrapper () { $(bashsig level format @)
  log --destination=somewhere --level="$level" --format="$format" "$@"
}
```