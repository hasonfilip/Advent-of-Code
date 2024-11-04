#!/usr/bin/gawk -f

function bin2dec(bin,    i, dec) {
  dec = 0
  for (i = 0; i < length(bin); i++) {
      dec = dec * 2 + substr(bin, i + 1, 1)
  }
  return int(dec)
}

function read_packet(packet,    bit, version, type_id, len_type_id, len_len, len, subpacket_len, offset, continue_reading, num, x, number_of_subpackets) {
  split(packet, bit, "")
  version = bin2dec(bit[1] bit[2] bit[3])
  type_id = bin2dec(bit[4] bit[5] bit[6])
  result += version
  offset = 7

  if (type_id == 4) {
    do {
      continue_reading = bit[offset]
      num = num bit[offset+1] bit[offset+2] bit[offset+3] bit[offset+4]
      offset += 5
    } while (continue_reading)
  }

  else {
    len_type_id = bit[offset]
    len_len = len_type_id ? 11 : 15
    while (len_len--)
      len = len bit[++offset]
    offset++
    if (len_type_id == 0) {
      subpacket_len = bin2dec(len)
      while (subpacket_len > 0) {
        x = read_packet(substr(packet, offset, subpacket_len))
        subpacket_len -= x
        offset += x
      }
    }
    if (len_type_id == 1) {
      number_of_subpackets = bin2dec(len)
      while (number_of_subpackets--)
        offset += read_packet(substr(packet, offset))
    }
  }

  return offset - 1
}

{
  read_packet($0)
  print result
}
