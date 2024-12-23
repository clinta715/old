
#define MODFORMATS 40

char *mod_ext[] = { ".MOD", ".669", ".FAR", ".ULT", ".S3M", ".AMF", ".MTM",
                    ".STX", ".STM", ".DSM", ".DMF", ".UNI", ".WOW", ".NST",
                    ".LNK", ".PSM", ".EMD", ".MID", ".XMI", ".CMF", ".ROL",
                    ".SAT", ".HSC", ".MED", ".PAC", ".MUS", ".XM",  ".INR",
                    ".ZIP", ".ARJ", ".RAR", ".LZH", ".LHA", ".UC2", ".TSS",
                    ".ZOO", ".ARC", ".PAK", ".HAP", ".SQZ" };

int has_comment[] = { 0, 0, 1, 1, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0,
                      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0,0,0,0,0,0,0,0,0 };
int def_channels[] = { 8, 8, 16, 32, 16, 16, 32, 4, 4, 16, 32, 32, 8, 4, 0, 16,
                       32,32,32, 11, 11, 11, 11, 4,16, 32, 32, 32, 0, 0, 0,0,0,0,16,
                       0,0,0,0,0 };

char *mod_types[] = {
    "ProTracker or FastTracker : 4,6,or 8+ channel .MOD file...",
    "Tran's Composer 669 : 8 channel...",
    "Digital Infinity's Farandola Composer : 1-32 channel file...",
    "MAS UltraTracker : 1-32 channel .ULT file...",
    "Future Crew's Scream Tracker 3.01+ : 1-16 channel file...",
    "Otto Chrons Advanced Module Format for DSMI players...",
    "Renaissance's MultiTracker Module Editor : 1-32 channel file...",
    "Future Crew's STMIK 0.9b : 4 channel music file...",
    "Future Crew's Scream Tracker 2.0 : 4 channel .STM file...",
    "Psychic Monk's DSM format module...",
    "D-Lusion's X-Tracker : 1-32 channel .DMF file...",
    "MikMak's .UNI universal format for MikMod 1.00+...",
    "Eat me Drink me Love me Kill me",
    "NoiseTracker : 4-channel .NST file...",
    "LameShell LameLink Link File...",
    "Elastik / EMD format 32 channel file.",
    "[midi type file]",
    "[midi type file]",
    "[fm music file]",
    "[fm music file]",
    "[fm music file]",
    "[fm music file]",
    "[not available]",
    "[not available]",
    "[not available]",
    "[midi type file]",
    "FastTracker 2.0 .XM file, 32-channels",
    "[unknown]",
    "ARCHIVE",
    "ARCHIVE",
    "ARCHIVE",
    "ARCHIVE",
    "ARCHIVE",
    "ARCHIVE",
    "[unknown]",
    "ARCHIVE",
    "ARCHIVE",
    "ARCHIVE",
    "ARCHIVE",
    "ARCHIVE" };

char *search_ext[] = { "*.MOD", "*.669", "*.FAR", "*.ULT", "*.S3M", "*.AMF",
                       "*.MTM", "*.STX", "*.STM", "*.DSM", "*.DMF", "*.UNI",
                       "*.WOW", "*.NST", "*.LNK", "*.PSM", "*.EMD", "*.MID",
                       "*.XMI", "*.CMF", "*.ROL", "*.SAT", "*.HSC", "*.MED",
                       "*.PAC", "*.MUS", "*.XM",  "*.INR", "*.ZIP", "*.ARJ",
                       "*.RAR", "*.LZH", "*.LHA", "*.TSS", "*.ZOO", "*.ARC",
                       "*.PAK", "*.HAP" };

int skip_val[] = { 0, 2, 4, 15, 0, 4, 4, 0, 0, 20, 13, 305, 0, 0, 141, 4, 13,
                  -1,-1,-1, -1,-1,-1,-1,-1,-1, 0xf,-1, -1, -1, -1, -1, -1,-1,
                  -1, -1, -1, -1, -1, -1 };
// -1 = no title, use mod_types string for title
