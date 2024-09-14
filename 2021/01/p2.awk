BEGIN { 
  windows[0] = 0; 
  windows[1] = 0; 
  windows[2] = 0; 
  result = 0 
}

NR <= 3 { 
  for (i = 0; i < NR; i++) windows[i] += $1; 
  next 
}

NR > 3 {
  windows[NR % 3] += $1;
  windows[(NR + 1) % 3] += $1;
  if (windows[NR % 3] > windows[(NR + 2) % 3]) {
      result++
  }
  windows[(NR + 2) % 3] = $1;
}

END { print result }
