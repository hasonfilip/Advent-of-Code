#!/usr/bin/gawk -f 

BEGIN {
  FS = ","
  WIDTH = HEIGHT = 70
  x = 1; y = 2
  file = file ? file : "graph.txt"
  bytes = bytes ? bytes : 1024
  printf "" > file
}

NR <= bytes {
  corrupted[$1][$2] = 1
}

END {
  for (j = 0; j <= HEIGHT; j++) {
    for (i = 0; i <= WIDTH; i++) {
      if (corrupted[i][j])
        continue
      if (!corrupted[i+1][j] && i < WIDTH)
        print i "," j, i+1 "," j, 1 >> file
      if (!corrupted[i][j+1] && j < HEIGHT)
        print i "," j, i "," j+1, 1 >> file
    }
  }
  system("gawk -v u="0","0" -v t="WIDTH","HEIGHT" -f dijkstra.awk "file"")
}

function print_map() {
  for (j = 0; j <= HEIGHT; j++) {
    for (i = 0; i <= WIDTH; i++)
      printf "%s", corrupted[i][j] ? "#" : "."
    print ""
  }
}

function DFS(x, y, path) {
  if (x == WIDTH && y == HEIGHT) {
    print path
    exit
  }
  if (x < 0 || x > WIDTH || y < 0 || y > HEIGHT || corrupted[x][y] || visited[x][y])
    return
  visited[x][y] = 1
  path++
  DFS(x-1, y, path)
  DFS(x+1, y, path)
  DFS(x, y-1, path)
  DFS(x, y+1, path)
}
