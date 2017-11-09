#include <stdio.h>
#include <stdlib.h>

unsigned int crc32b(unsigned char *message) {
   int i, j;
   unsigned int byte, crc, mask;

   i = 0;
   crc = 0xFFFFFFFF;
   printf("String: %x\n", message);
   while (message[i] != 0) {
      byte = message[i];            // Get next byte.
      printf("CRC: %x\nByte: %x\n", crc, byte);
      crc = crc ^ byte;
      printf("CRC xor byte: %x\n", crc);
      for (j = 7; j >= 0; j--) {    // Do eight times.
         mask = (crc & 1);
         printf("%d mask: %x --> mask negado: %x\n ", j, mask, -mask);
         crc = (crc >> 1);
         printf("crc shiftleft: %x\n", crc);
         crc = crc ^ (0xEDB88320 & -mask);
         printf("%d CRC after mask: %x\n", j, crc);
      }
      i = i + 1;
   }
   return ~crc;
}

int main (int argc, char* argv[]) {
    unsigned int result = crc32b(argv[1]);
    printf("%x\n", result);
    return 0;
}
