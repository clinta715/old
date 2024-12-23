//mtm.h

typedef struct {
    unsigned char magic[3];
    unsigned char version;
    unsigned char songname[20];
    unsigned int  num_tracks;
    unsigned char last_pattern;
    unsigned char last_order;
    unsigned int  comment_length;
    unsigned char num_samples;
    unsigned char attr;
    unsigned char beats_per_track;
    unsigned char num_tracks_to_playback;
    unsigned char panpos[32];
    } mtmheader;

typedef struct {
    unsigned char samplename[22];
    long length;
    long loopstart;
    long loopend;
    unsigned char finetune;
    unsigned char volume;
    unsigned char attr;
    } mtmsample;

