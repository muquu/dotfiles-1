ver-cmp() {
  # shellcheck disable=SC2116
  local l=($(echo "${1//[^0-9]/ }")) op=$2 r=($(echo "${3//[^0-9]/ }"))
  case $op in
    eq|==) op='==';;
    ge|\>=) op='>=';;
    le|\<=) op='<=';;
    ne|\!=) ! "${FUNCNAME[0]}" "$1" eq "$3"; return;;
    gt|\>) ! "${FUNCNAME[0]}" "$1" le "$3"; return;;
    lt|\<) ! "${FUNCNAME[0]}" "$1" ge "$3"; return;;
    *) return 1
  esac
  local exp="(( 10#\${l[i]} $op 10#\${r[i++]} ))" i=0
  while [[ -n "${l[$i]}${r[$i]}" ]]; do
    eval "$exp" || return
  done
}
# 第2引数が無ければ $BASH_VERSION と比較
ver-eq() { [[ -z $2 ]] && set -- "$BASH_VERSION" "$1"; ver-cmp "$1" eq "$2"; }
ver-ge() { [[ -z $2 ]] && set -- "$BASH_VERSION" "$1"; ver-cmp "$1" ge "$2"; }
ver-le() { [[ -z $2 ]] && set -- "$BASH_VERSION" "$1"; ver-cmp "$1" le "$2"; }
# イコールなし系は逆のNOTにしておくとバージョンの桁が合わないケースの実装が楽
ver-ne() { ! ver-eq "$@"; }
ver-gt() { ! ver-le "$@"; }
ver-lt() { ! ver-ge "$@"; }
