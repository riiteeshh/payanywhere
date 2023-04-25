import 'dart:typed_data';

class Decrypter {
  static final Uint8List s_box = Uint8List.fromList([
    0x52,
    0x09,
    0x6A,
    0xD5,
    0x30,
    0x36,
    0xA5,
    0x38,
    0xBF,
    0x40,
    0xA3,
    0x9E,
    0x81,
    0xF3,
    0xD7,
    0xFB,
    0x7C,
    0xE3,
    0x39,
    0x82,
    0x9B,
    0x2F,
    0xFF,
    0x87,
    0x34,
    0x8E,
    0x43,
    0x44,
    0xC4,
    0xDE,
    0xE9,
    0xCB,
    0x54,
    0x7B,
    0x94,
    0x32,
    0xA6,
    0xC2,
    0x23,
    0x3D,
    0xEE,
    0x4C,
    0x95,
    0x0B,
    0x42,
    0xFA,
    0xC3,
    0x4E,
    0x08,
    0x2E,
    0xA1,
    0x66,
    0x28,
    0xD9,
    0x24,
    0xB2,
    0x76,
    0x5B,
    0xA2,
    0x49,
    0x6D,
    0x8B,
    0xD1,
    0x25,
    0x72,
    0xF8,
    0xF6,
    0x64,
    0x86,
    0x68,
    0x98,
    0x16,
    0xD4,
    0xA4,
    0x5C,
    0xCC,
    0x5D,
    0x65,
    0xB6,
    0x92,
    0x6C,
    0x70,
    0x48,
    0x50,
    0xFD,
    0xED,
    0xB9,
    0xDA,
    0x5E,
    0x15,
    0x46,
    0x57,
    0xA7,
    0x8D,
    0x9D,
    0x84,
    0x90,
    0xD8,
    0xAB,
    0x00,
    0x8C,
    0xBC,
    0xD3,
    0x0A,
    0xF7,
    0xE4,
    0x58,
    0x05,
    0xB8,
    0xB3,
    0x45,
    0x06,
    0xD0,
    0x2C,
    0x1E,
    0x8F,
    0xCA,
    0x3F,
    0x0F,
    0x02,
    0xC1,
    0xAF,
    0xBD,
    0x03,
    0x01,
    0x13,
    0x8A,
    0x6B,
    0x3A,
    0x91,
    0x11,
    0x41,
    0x4F,
    0x67,
    0xDC,
    0xEA,
    0x97,
    0xF2,
    0xCF,
    0xCE,
    0xF0,
    0xB4,
    0xE6,
    0x73,
    0x96,
    0xAC,
    0x74,
    0x22,
    0xE7,
    0xAD,
    0x35,
    0x85,
    0xE2,
    0xF9,
    0x37,
    0xE8,
    0x1C,
    0x75,
    0xDF,
    0x6E,
    0x47,
    0xF1,
    0x1A,
    0x71,
    0x1D,
    0x29,
    0xC5,
    0x89,
    0x6F,
    0xB7,
    0x62,
    0x0E,
    0xAA,
    0x18,
    0xBE,
    0x1B,
    0xFC,
    0x56,
    0x3E,
    0x4B,
    0xC6,
    0xD2,
    0x79,
    0x20,
    0x9A,
    0xDB,
    0xC0,
    0xFE,
    0x78,
    0xCD,
    0x5A,
    0xF4,
    0x1F,
    0xDD,
    0xA8,
    0x33,
    0x88,
    0x07,
    0xC7,
    0x31,
    0xB1,
    0x12,
    0x10,
    0x59,
    0x27,
    0x80,
    0xEC,
    0x5F,
    0x60,
    0x51,
    0x7F,
    0xA9,
    0x19,
    0xB5,
    0x4A,
    0x0D,
    0x2D,
    0xE5,
    0x7A,
    0x9F,
    0x93,
    0xC9,
    0x9C,
    0xEF,
    0xA0,
    0xE0,
    0x3B,
    0x4D,
    0xAE,
    0x2A,
    0xF5,
    0xB0,
    0xC8,
    0xEB,
    0xBB,
    0x3C,
    0x83,
    0x53,
    0x99,
    0x61,
    0x17,
    0x2B,
    0x04,
    0x7E,
    0xBA,
    0x77,
    0xD6,
    0x26,
    0xE1,
    0x69,
    0x14,
    0x63,
    0x55,
    0x21,
    0x0C,
    0x7D
  ]);

  static final Uint8List mul2 = Uint8List.fromList([
    0x00,
    0x0e,
    0x1c,
    0x12,
    0x38,
    0x36,
    0x24,
    0x2a,
    0x70,
    0x7e,
    0x6c,
    0x62,
    0x48,
    0x46,
    0x54,
    0x5a,
    0xe0,
    0xee,
    0xfc,
    0xf2,
    0xd8,
    0xd6,
    0xc4,
    0xca,
    0x90,
    0x9e,
    0x8c,
    0x82,
    0xa8,
    0xa6,
    0xb4,
    0xba,
    0xdb,
    0xd5,
    0xc7,
    0xc9,
    0xe3,
    0xed,
    0xff,
    0xf1,
    0xab,
    0xa5,
    0xb7,
    0xb9,
    0x93,
    0x9d,
    0x8f,
    0x81,
    0x3b,
    0x35,
    0x27,
    0x29,
    0x03,
    0x0d,
    0x1f,
    0x11,
    0x4b,
    0x45,
    0x57,
    0x59,
    0x73,
    0x7d,
    0x6f,
    0x61,
    0xad,
    0xa3,
    0xb1,
    0xbf,
    0x95,
    0x9b,
    0x89,
    0x87,
    0xdd,
    0xd3,
    0xc1,
    0xcf,
    0xe5,
    0xeb,
    0xf9,
    0xf7,
    0x4d,
    0x43,
    0x51,
    0x5f,
    0x75,
    0x7b,
    0x69,
    0x67,
    0x3d,
    0x33,
    0x21,
    0x2f,
    0x05,
    0x0b,
    0x19,
    0x17,
    0x76,
    0x78,
    0x6a,
    0x64,
    0x4e,
    0x40,
    0x52,
    0x5c,
    0x06,
    0x08,
    0x1a,
    0x14,
    0x3e,
    0x30,
    0x22,
    0x2c,
    0x96,
    0x98,
    0x8a,
    0x84,
    0xae,
    0xa0,
    0xb2,
    0xbc,
    0xe6,
    0xe8,
    0xfa,
    0xf4,
    0xde,
    0xd0,
    0xc2,
    0xcc,
    0x41,
    0x4f,
    0x5d,
    0x53,
    0x79,
    0x77,
    0x65,
    0x6b,
    0x31,
    0x3f,
    0x2d,
    0x23,
    0x09,
    0x07,
    0x15,
    0x1b,
    0xa1,
    0xaf,
    0xbd,
    0xb3,
    0x99,
    0x97,
    0x85,
    0x8b,
    0xd1,
    0xdf,
    0xcd,
    0xc3,
    0xe9,
    0xe7,
    0xf5,
    0xfb,
    0x9a,
    0x94,
    0x86,
    0x88,
    0xa2,
    0xac,
    0xbe,
    0xb0,
    0xea,
    0xe4,
    0xf6,
    0xf8,
    0xd2,
    0xdc,
    0xce,
    0xc0,
    0x7a,
    0x74,
    0x66,
    0x68,
    0x42,
    0x4c,
    0x5e,
    0x50,
    0x0a,
    0x04,
    0x16,
    0x18,
    0x32,
    0x3c,
    0x2e,
    0x20,
    0xec,
    0xe2,
    0xf0,
    0xfe,
    0xd4,
    0xda,
    0xc8,
    0xc6,
    0x9c,
    0x92,
    0x80,
    0x8e,
    0xa4,
    0xaa,
    0xb8,
    0xb6,
    0x0c,
    0x02,
    0x10,
    0x1e,
    0x34,
    0x3a,
    0x28,
    0x26,
    0x7c,
    0x72,
    0x60,
    0x6e,
    0x44,
    0x4a,
    0x58,
    0x56,
    0x37,
    0x39,
    0x2b,
    0x25,
    0x0f,
    0x01,
    0x13,
    0x1d,
    0x47,
    0x49,
    0x5b,
    0x55,
    0x7f,
    0x71,
    0x63,
    0x6d,
    0xd7,
    0xd9,
    0xcb,
    0xc5,
    0xef,
    0xe1,
    0xf3,
    0xfd,
    0xa7,
    0xa9,
    0xbb,
    0xb5,
    0x9f,
    0x91,
    0x83,
    0x8d
  ]);
  static final Uint8List mul3 = Uint8List.fromList([
    0x00,
    0x00,
    0x0d,
    0x1a,
    0x17,
    0x34,
    0x39,
    0x2e,
    0x23,
    0x68,
    0x65,
    0x72,
    0x7f,
    0x5c,
    0x51,
    0x46,
    0x4b,
    0xd0,
    0xdd,
    0xca,
    0xc7,
    0xe4,
    0xe9,
    0xfe,
    0xf3,
    0xb8,
    0xb5,
    0xa2,
    0xaf,
    0x8c,
    0x81,
    0x96,
    0x9b,
    0xbb,
    0xb6,
    0xa1,
    0xac,
    0x8f,
    0x82,
    0x95,
    0x98,
    0xd3,
    0xde,
    0xc9,
    0xc4,
    0xe7,
    0xea,
    0xfd,
    0xf0,
    0x6b,
    0x66,
    0x71,
    0x7c,
    0x5f,
    0x52,
    0x45,
    0x48,
    0x03,
    0x0e,
    0x19,
    0x14,
    0x37,
    0x3a,
    0x2d,
    0x20,
    0x6d,
    0x60,
    0x77,
    0x7a,
    0x59,
    0x54,
    0x43,
    0x4e,
    0x05,
    0x08,
    0x1f,
    0x12,
    0x31,
    0x3c,
    0x2b,
    0x26,
    0xbd,
    0xb0,
    0xa7,
    0xaa,
    0x89,
    0x84,
    0x93,
    0x9e,
    0xd5,
    0xd8,
    0xcf,
    0xc2,
    0xe1,
    0xec,
    0xfb,
    0xf6,
    0xd6,
    0xdb,
    0xcc,
    0xc1,
    0xe2,
    0xef,
    0xf8,
    0xf5,
    0xbe,
    0xb3,
    0xa4,
    0xa9,
    0x8a,
    0x87,
    0x90,
    0x9d,
    0x06,
    0x0b,
    0x1c,
    0x11,
    0x32,
    0x3f,
    0x28,
    0x25,
    0x6e,
    0x63,
    0x74,
    0x79,
    0x5a,
    0x57,
    0x40,
    0x4d,
    0xda,
    0xd7,
    0xc0,
    0xcd,
    0xee,
    0xe3,
    0xf4,
    0xf9,
    0xb2,
    0xbf,
    0xa8,
    0xa5,
    0x86,
    0x8b,
    0x9c,
    0x91,
    0x0a,
    0x07,
    0x10,
    0x1d,
    0x3e,
    0x33,
    0x24,
    0x29,
    0x62,
    0x6f,
    0x78,
    0x75,
    0x56,
    0x5b,
    0x4c,
    0x41,
    0x61,
    0x6c,
    0x7b,
    0x76,
    0x55,
    0x58,
    0x4f,
    0x42,
    0x09,
    0x04,
    0x13,
    0x1e,
    0x3d,
    0x30,
    0x27,
    0x2a,
    0xb1,
    0xbc,
    0xab,
    0xa6,
    0x85,
    0x88,
    0x9f,
    0x92,
    0xd9,
    0xd4,
    0xc3,
    0xce,
    0xed,
    0xe0,
    0xf7,
    0xfa,
    0xb7,
    0xba,
    0xad,
    0xa0,
    0x83,
    0x8e,
    0x99,
    0x94,
    0xdf,
    0xd2,
    0xc5,
    0xc8,
    0xeb,
    0xe6,
    0xf1,
    0xfc,
    0x67,
    0x6a,
    0x7d,
    0x70,
    0x53,
    0x5e,
    0x49,
    0x44,
    0x0f,
    0x02,
    0x15,
    0x18,
    0x3b,
    0x36,
    0x21,
    0x2c,
    0x0c,
    0x01,
    0x16,
    0x1b,
    0x38,
    0x35,
    0x22,
    0x2f,
    0x64,
    0x69,
    0x7e,
    0x73,
    0x50,
    0x5d,
    0x4a,
    0x47,
    0xdc,
    0xd1,
    0xc6,
    0xcb,
    0xe8,
    0xe5,
    0xf2,
    0xff,
    0xb4,
    0xb9,
    0xae,
    0xa3,
    0x80,
    0x8d,
    0x9a,
    0x97
  ]);
//galos feild

  static final Uint8List rcon = Uint8List.fromList([
    0x8d,
    0x01,
    0x02,
    0x04,
    0x08,
    0x10,
    0x20,
    0x40,
    0x80,
    0x1b,
    0x36,
    0x6c,
    0xd8,
    0xab,
    0x4d,
    0x9a,
    0x2f,
    0x5e,
    0xbc,
    0x63,
    0xc6,
    0x97,
    0x35,
    0x6a,
    0xd4,
    0xb3,
    0x7d,
    0xfa,
    0xef,
    0xc5,
    0x91,
    0x39,
    0x72,
    0xe4,
    0xd3,
    0xbd,
    0x61,
    0xc2,
    0x9f,
    0x25,
    0x4a,
    0x94,
    0x33,
    0x66,
    0xcc,
    0x83,
    0x1d,
    0x3a,
    0x74,
    0xe8,
    0xcb,
    0x8d,
    0x01,
    0x02,
    0x04,
    0x08,
    0x10,
    0x20,
    0x40,
    0x80,
    0x1b,
    0x36,
    0x6c,
    0xd8,
    0xab,
    0x4d,
    0x9a,
    0x2f,
    0x5e,
    0xbc,
    0x63,
    0xc6,
    0x97,
    0x35,
    0x6a,
    0xd4,
    0xb3,
    0x7d,
    0xfa,
    0xef,
    0xc5,
    0x91,
    0x39,
    0x72,
    0xe4,
    0xd3,
    0xbd,
    0x61,
    0xc2,
    0x9f,
    0x25,
    0x4a,
    0x94,
    0x33,
    0x66,
    0xcc,
    0x83,
    0x1d,
    0x3a,
    0x74,
    0xe8,
    0xcb,
    0x8d,
    0x01,
    0x02,
    0x04,
    0x08,
    0x10,
    0x20,
    0x40,
    0x80,
    0x1b,
    0x36,
    0x6c,
    0xd8,
    0xab,
    0x4d,
    0x9a,
    0x2f,
    0x5e,
    0xbc,
    0x63,
    0xc6,
    0x97,
    0x35,
    0x6a,
    0xd4,
    0xb3,
    0x7d,
    0xfa,
    0xef,
    0xc5,
    0x91,
    0x39,
    0x72,
    0xe4,
    0xd3,
    0xbd,
    0x61,
    0xc2,
    0x9f,
    0x25,
    0x4a,
    0x94,
    0x33,
    0x66,
    0xcc,
    0x83,
    0x1d,
    0x3a,
    0x74,
    0xe8,
    0xcb,
    0x8d,
    0x01,
    0x02,
    0x04,
    0x08,
    0x10,
    0x20,
    0x40,
    0x80,
    0x1b,
    0x36,
    0x6c,
    0xd8,
    0xab,
    0x4d,
    0x9a,
    0x2f,
    0x5e,
    0xbc,
    0x63,
    0xc6,
    0x97,
    0x35,
    0x6a,
    0xd4,
    0xb3,
    0x7d,
    0xfa,
    0xef,
    0xc5,
    0x91,
    0x39,
    0x72,
    0xe4,
    0xd3,
    0xbd,
    0x61,
    0xc2,
    0x9f,
    0x25,
    0x4a,
    0x94,
    0x33,
    0x66,
    0xcc,
    0x83,
    0x1d,
    0x3a,
    0x74,
    0xe8,
    0xcb,
    0x8d,
    0x01,
    0x02,
    0x04,
    0x08,
    0x10,
    0x20,
    0x40,
    0x80,
    0x1b,
    0x36,
    0x6c,
    0xd8,
    0xab,
    0x4d,
    0x9a,
    0x2f,
    0x5e,
    0xbc,
    0x63,
    0xc6,
    0x97,
    0x35,
    0x6a,
    0xd4,
    0xb3,
    0x7d,
    0xfa,
    0xef,
    0xc5,
    0x91,
    0x39,
    0x72,
    0xe4,
    0xd3,
    0xbd,
    0x61,
    0xc2,
    0x9f,
    0x25,
    0x4a,
    0x94,
    0x33,
    0x66,
    0xcc,
    0x83,
    0x1d,
    0x3a,
    0x74,
    0xe8,
    0xcb,
    0x8d
  ]);
//rotate s-box Rcon
  void KeyExpansionCore(List intt, int i) {
    //rotate left
    List t = intt[0];
    intt[0] = intt[1];

    intt[1] = intt[2];
    intt[2] = intt[3];

    intt[3] = t;

    //s-box four bytes
    intt[0] = s_box[intt[0]];
    intt[1] = s_box[intt[1]];
    intt[2] = s_box[intt[2]];
    intt[3] = s_box[intt[3]];

    //Rcon
    intt[0] ^= rcon[i];
  }

  void KeyExpansion(List inputkey, List expandedKeys)
//the first 16 byte is orginal key
  {
    for (int i = 0; i < 16; i++) expandedKeys[i] = inputkey[i];

    //Variables:
    int bytesGenerated = 16;
    int rconIteration = 1;
    List temp = [];

    while (bytesGenerated < 176) {
      //read 4 bytes for the core
      for (int i = 0; i < 4; i++)
        temp[i] = expandedKeys[i + bytesGenerated - 4];

      //perform the core once for each 16 byte key
      if (bytesGenerated % 16 == 0) {
        KeyExpansionCore(temp, rconIteration);
        rconIteration++;
      }

      //XOR temp
      for (int a = 0; a < 4; a++) {
        expandedKeys[bytesGenerated] =
            expandedKeys[bytesGenerated - 16] ^ temp[a];
        bytesGenerated++;
      }
    }
  }

  void inv_Subytes(List state) //
  {
    for (int i = 0; i < 16; i++) {
      state[i] = s_box[state[i]];
    }
  }

//rotate right
  void inv_Shiftrows(state) {
    List tmp = [];
    tmp[0] = state[0];
    tmp[1] = state[7];
    tmp[2] = state[10];
    tmp[3] = state[13];

    tmp[4] = state[1];
    tmp[5] = state[4];
    tmp[6] = state[11];
    tmp[7] = state[14];

    tmp[8] = state[2];
    tmp[9] = state[5];
    tmp[10] = state[8];
    tmp[11] = state[15];

    tmp[12] = state[3];
    tmp[13] = state[6];
    tmp[14] = state[9];
    tmp[15] = state[12];

    for (int i = 0; i < 16; i++) {
      state[i] = tmp[i];
    }
  }

//galos feild constatnt matrix {2311,1231,1123,3112} all pre compute value mul2 mul3
  void inv_Mixcloumns(List state) {
    List tmp = [];
    tmp[0] = (mul2[state[0]] ^ mul3[state[1]] ^ state[2] ^ state[3]);
    tmp[1] = (state[0] ^ mul2[state[1]] ^ mul3[state[2]] ^ state[3]);
    tmp[2] = (state[0] ^ state[1] ^ mul2[state[2]] ^ mul3[state[3]]);
    tmp[3] = (mul3[state[0]] ^ state[1] ^ state[2] ^ mul2[state[3]]);

    tmp[4] = (mul2[state[4]] ^ mul3[state[5]] ^ state[6] ^ state[7]);
    tmp[5] = (state[4] ^ mul2[state[5]] ^ mul3[state[6]] ^ state[7]);
    tmp[6] = (state[4] ^ state[5] ^ mul2[state[6]] ^ mul3[state[7]]);
    tmp[7] = (mul3[state[4]] ^ state[5] ^ state[6] ^ mul2[state[7]]);

    tmp[8] = (mul2[state[8]] ^ mul3[state[9]] ^ state[10] ^ state[11]);
    tmp[9] = (state[8] ^ mul2[state[9]] ^ mul3[state[10]] ^ state[11]);
    tmp[10] = (state[8] ^ state[9] ^ mul2[state[10]] ^ mul3[state[11]]);
    tmp[11] = (mul3[state[8]] ^ state[9] ^ state[10] ^ mul2[state[11]]);

    tmp[12] = (mul2[state[12]] ^ mul3[state[13]] ^ state[14] ^ state[15]);
    tmp[13] = (state[12] ^ mul2[state[13]] ^ mul3[state[14]] ^ state[15]);
    tmp[14] = (state[12] ^ state[13] ^ mul2[state[14]] ^ mul3[state[15]]);
    tmp[15] = (mul3[state[12]] ^ state[13] ^ state[14] ^ mul2[state[15]]);

    for (int i = 0; i < 16; i++) {
      state[i] = tmp[i];
    }
  }

  void Addroundkey(List state, List roundkey) {
    for (int i = 0; i < 16; i++) {
      state[i] ^= roundkey[i];
    }
  }

  String decrypt(List message, List key) // message and key taken
  {
    List state = [];
    for (int i = 0; i < 16; i++) {
      state[i] = message[i];
    }
    int number_of_rounds = 9;

    //expand key
    List expandedKey = [];
    KeyExpansion(key, expandedKey);

    Addroundkey(state, key); //roundkey
    for (int i = 0; i < number_of_rounds; i++) {
      inv_Subytes(state);
      inv_Shiftrows(state);
      inv_Mixcloumns(state);
      Addroundkey(state, expandedKey);
    }
    //Finalround
    inv_Subytes(state);
    inv_Shiftrows(state);
    Addroundkey(state, expandedKey);
    //copy over the encrypted messsage
    for (int i = 0; i < 16; i++) {
      message[i] = state[i];
    }
    String data = message.join();
    return data;
  }
}