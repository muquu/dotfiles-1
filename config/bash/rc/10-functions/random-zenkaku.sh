random-zenkaku() {
  local c=${1:-20} zen=
  zen+="あいうえおかきくけこさしすせそたちつてとなにぬねのやゆよわをんがぎぐげござじずぜぞだぢづでどばびぶべぼぱぴぷぺぽゑ"
  zen+="アイウエオカキクケコサシスセソタチツテトナニヌネノヤユヨワヲンガギグゲゴザジズゼゾダヂヅデドバビブベボパピプペポヱヲ"
  zen+="０１２３４５６７８９"
  zen+="ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚ"
  zen+="ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ"
  for _ in $(seq "$c"); do
    echo -n "${zen:$((RANDOM % ${#zen})):1}"
  done
  echo
}
