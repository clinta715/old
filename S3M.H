// s3m.h - guess

typedef struct {
    unsigned char name[28];
    unsigned char magic1;
    unsigned char type;
    unsigned char e;
    unsigned char f;
    unsigned int orders;
    unsigned int samples;
    unsigned int patterns;
    unsigned int flags;
    unsigned int created;
    unsigned int format;
    unsigned char magic[4];
    unsigned char volume;
    unsigned char speed;
    unsigned char tempo;
    unsigned char mastervol;
    unsigned char temp[10];
    unsigned int special;
    unsigned char channels[32];
    } s3mheader;

typedef struct {
    unsigned char t;
    unsigned char samplename[12];
    unsigned char memseg[3];
    unsigned int length;
    unsigned int lenhi;
    unsigned int loop;
    unsigned int loophi;
    unsigned int loope;
    unsigned int loopehi;
    unsigned char vol;
    unsigned char shit;
    unsigned char p;
    unsigned char f;
    unsigned int c2spd;
    unsigned int c2spdhi;
    unsigned char shit2[4];
    unsigned int gp;
    unsigned int shit3;
    unsigned int lastused[2];
    unsigned char samplenamedick[28];
    unsigned char magic[4];
    } s3msample;

