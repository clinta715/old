// MOD.H - info 4 mod files...

typedef struct {
        unsigned char name[22];
	unsigned int size;
        unsigned char fine;
        unsigned char volume;
	unsigned int loops;
	unsigned int loope;
	} modsample;

typedef struct {
    unsigned char title[20];
    modsample samples[31];
    unsigned char patterns;
    unsigned char songend;
    unsigned char header[4];
    unsigned char orders[128];
    } mod_header;
