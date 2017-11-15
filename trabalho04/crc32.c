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
      crc = crc ^ byte; // crc xor byte
      printf("CRC xor byte: %x\n", crc);
      for (j = 7; j >= 0; j--) {    // Do eight times.
         mask = (crc & 1); // crc and 1
         crc = (crc >> 1); // shift right in crc
         printf("CRC shiftright: %x\n", crc);
         unsigned int aux = (0xEDB88320 & -mask);
         printf("T6: %x\n", aux);
         crc = crc ^ aux; // crc xor (const and negation(mask))
         printf("CRC after mask: %x\n", crc);
      }
      i = i + 1;
      byte = message[i];            // Get next byte.
      printf("Next Byte: %x\n", byte);
   }
   printf("CRC after all: %x\n", crc);
   return ~crc; // one complement of crc
}

int main (int argc, char* argv[]) {
    unsigned int result = crc32b(argv[1]);
    printf("%x\n", result);
    return 0;
}
