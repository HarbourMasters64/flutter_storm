const int MAX_PATH = 1024;

const int FILE_BEGIN = 0;

const int FILE_CURRENT = 1;

const int FILE_END = 2;

const int O_LARGEFILE = 0;

const int ERROR_SUCCESS = 0;

const int ERROR_FILE_NOT_FOUND = 2;

const int ERROR_ACCESS_DENIED = 1;

const int ERROR_INVALID_HANDLE = 9;

const int ERROR_NOT_ENOUGH_MEMORY = 12;

const int ERROR_NOT_SUPPORTED = 45;

const int ERROR_INVALID_PARAMETER = 22;

const int ERROR_NEGATIVE_SEEK = 29;

const int ERROR_DISK_FULL = 28;

const int ERROR_ALREADY_EXISTS = 17;

const int ERROR_INSUFFICIENT_BUFFER = 55;

const int ERROR_BAD_FORMAT = 1000;

const int ERROR_NO_MORE_FILES = 1001;

const int ERROR_HANDLE_EOF = 1002;

const int ERROR_CAN_NOT_COMPLETE = 1003;

const int ERROR_FILE_CORRUPT = 1004;

const int STORMLIB_VERSION = 2328;

const String STORMLIB_VERSION_STRING = '9.24';

const int ID_MPQ = 441536589;

const int ID_MPQ_USERDATA = 458313805;

const int ID_MPK = 441143373;

const int ID_MPK_VERSION_2000 = 808464434;

const int ERROR_AVI_FILE = 10000;

const int ERROR_UNKNOWN_FILE_KEY = 10001;

const int ERROR_CHECKSUM_ERROR = 10002;

const int ERROR_INTERNAL_FILE = 10003;

const int ERROR_BASE_FILE_MISSING = 10004;

const int ERROR_MARKED_FOR_DELETE = 10005;

const int ERROR_FILE_INCOMPLETE = 10006;

const int ERROR_UNKNOWN_FILE_NAMES = 10007;

const int ERROR_CANT_FIND_PATCH_PREFIX = 10008;

const int ERROR_FAKE_MPQ_HEADER = 10009;

const int HASH_TABLE_SIZE_MIN = 4;

const int HASH_TABLE_SIZE_DEFAULT = 4096;

const int HASH_TABLE_SIZE_MAX = 524288;

const int HASH_ENTRY_DELETED = 4294967294;

const int HASH_ENTRY_FREE = 4294967295;

const int HET_ENTRY_DELETED = 128;

const int HET_ENTRY_FREE = 0;

const int SFILE_OPEN_HARD_DISK_FILE = 2;

const int SFILE_OPEN_CDROM_FILE = 3;

const int SFILE_OPEN_FROM_MPQ = 0;

const int SFILE_OPEN_CHECK_EXISTS = 4294967292;

const int SFILE_OPEN_BASE_FILE = 4294967293;

const int SFILE_OPEN_ANY_LOCALE = 4294967294;

const int SFILE_OPEN_LOCAL_FILE = 4294967295;

const int MPQ_FLAG_READ_ONLY = 1;

const int MPQ_FLAG_CHANGED = 2;

const int MPQ_FLAG_MALFORMED = 4;

const int MPQ_FLAG_HASH_TABLE_CUT = 8;

const int MPQ_FLAG_BLOCK_TABLE_CUT = 16;

const int MPQ_FLAG_CHECK_SECTOR_CRC = 32;

const int MPQ_FLAG_SAVING_TABLES = 64;

const int MPQ_FLAG_PATCH = 128;

const int MPQ_FLAG_WAR3_MAP = 256;

const int MPQ_FLAG_STARCRAFT_BETA = 512;

const int MPQ_FLAG_LISTFILE_NONE = 1024;

const int MPQ_FLAG_LISTFILE_NEW = 2048;

const int MPQ_FLAG_LISTFILE_FORCE = 4096;

const int MPQ_FLAG_ATTRIBUTES_NONE = 8192;

const int MPQ_FLAG_ATTRIBUTES_NEW = 16384;

const int MPQ_FLAG_SIGNATURE_NONE = 32768;

const int MPQ_FLAG_SIGNATURE_NEW = 65536;

const int MPQ_SUBTYPE_MPQ = 0;

const int MPQ_SUBTYPE_SQP = 1;

const int MPQ_SUBTYPE_MPK = 2;

const int SFILE_INVALID_SIZE = 4294967295;

const int SFILE_INVALID_POS = 4294967295;

const int SFILE_INVALID_ATTRIBUTES = 4294967295;

const int MPQ_FILE_IMPLODE = 256;

const int MPQ_FILE_COMPRESS = 512;

const int MPQ_FILE_ENCRYPTED = 65536;

const int MPQ_FILE_FIX_KEY = 131072;

const int MPQ_FILE_PATCH_FILE = 1048576;

const int MPQ_FILE_SINGLE_UNIT = 16777216;

const int MPQ_FILE_DELETE_MARKER = 33554432;

const int MPQ_FILE_SECTOR_CRC = 67108864;

const int MPQ_FILE_SIGNATURE = 268435456;

const int MPQ_FILE_EXISTS = 2147483648;

const int MPQ_FILE_REPLACEEXISTING = 2147483648;

const int MPQ_FILE_COMPRESS_MASK = 65280;

const int MPQ_FILE_DEFAULT_INTERNAL = 4294967295;

const int MPQ_FILE_VALID_FLAGS = 2534605568;

const int MPQ_FILE_VALID_FLAGS_W3X = 2516779776;

const int MPQ_FILE_VALID_FLAGS_SCX = 2147681024;

const int BLOCK_INDEX_MASK = 268435455;

const int MPQ_COMPRESSION_HUFFMANN = 1;

const int MPQ_COMPRESSION_ZLIB = 2;

const int MPQ_COMPRESSION_PKWARE = 8;

const int MPQ_COMPRESSION_BZIP2 = 16;

const int MPQ_COMPRESSION_SPARSE = 32;

const int MPQ_COMPRESSION_ADPCM_MONO = 64;

const int MPQ_COMPRESSION_ADPCM_STEREO = 128;

const int MPQ_COMPRESSION_LZMA = 18;

const int MPQ_COMPRESSION_NEXT_SAME = 4294967295;

const int MPQ_WAVE_QUALITY_HIGH = 0;

const int MPQ_WAVE_QUALITY_MEDIUM = 1;

const int MPQ_WAVE_QUALITY_LOW = 2;

const int HET_TABLE_SIGNATURE = 441730376;

const int BET_TABLE_SIGNATURE = 441730370;

const int MPQ_KEY_HASH_TABLE = 3283040112;

const int MPQ_KEY_BLOCK_TABLE = 3968054179;

const String LISTFILE_NAME = '(listfile)';

const String SIGNATURE_NAME = '(signature)';

const String ATTRIBUTES_NAME = '(attributes)';

const String PATCH_METADATA_NAME = '(patch_metadata)';

const int MPQ_FORMAT_VERSION_1 = 0;

const int MPQ_FORMAT_VERSION_2 = 1;

const int MPQ_FORMAT_VERSION_3 = 2;

const int MPQ_FORMAT_VERSION_4 = 3;

const int MPQ_ATTRIBUTE_CRC32 = 1;

const int MPQ_ATTRIBUTE_FILETIME = 2;

const int MPQ_ATTRIBUTE_MD5 = 4;

const int MPQ_ATTRIBUTE_PATCH_BIT = 8;

const int MPQ_ATTRIBUTE_ALL = 15;

const int MPQ_ATTRIBUTES_V1 = 100;

const int BASE_PROVIDER_FILE = 0;

const int BASE_PROVIDER_MAP = 1;

const int BASE_PROVIDER_HTTP = 2;

const int BASE_PROVIDER_MASK = 15;

const int STREAM_PROVIDER_FLAT = 0;

const int STREAM_PROVIDER_PARTIAL = 16;

const int STREAM_PROVIDER_MPQE = 32;

const int STREAM_PROVIDER_BLOCK4 = 48;

const int STREAM_PROVIDER_MASK = 240;

const int STREAM_FLAG_READ_ONLY = 256;

const int STREAM_FLAG_WRITE_SHARE = 512;

const int STREAM_FLAG_USE_BITMAP = 1024;

const int STREAM_OPTIONS_MASK = 65280;

const int STREAM_PROVIDERS_MASK = 255;

const int STREAM_FLAGS_MASK = 65535;

const int MPQ_OPEN_NO_LISTFILE = 65536;

const int MPQ_OPEN_NO_ATTRIBUTES = 131072;

const int MPQ_OPEN_NO_HEADER_SEARCH = 262144;

const int MPQ_OPEN_FORCE_MPQ_V1 = 524288;

const int MPQ_OPEN_CHECK_SECTOR_CRC = 1048576;

const int MPQ_OPEN_PATCH = 2097152;

const int MPQ_OPEN_FORCE_LISTFILE = 4194304;

const int MPQ_OPEN_READ_ONLY = 256;

const int MPQ_CREATE_LISTFILE = 1048576;

const int MPQ_CREATE_ATTRIBUTES = 2097152;

const int MPQ_CREATE_SIGNATURE = 4194304;

const int MPQ_CREATE_ARCHIVE_V1 = 0;

const int MPQ_CREATE_ARCHIVE_V2 = 16777216;

const int MPQ_CREATE_ARCHIVE_V3 = 33554432;

const int MPQ_CREATE_ARCHIVE_V4 = 50331648;

const int MPQ_CREATE_ARCHIVE_VMASK = 251658240;

const int FLAGS_TO_FORMAT_SHIFT = 24;

const int SFILE_VERIFY_SECTOR_CRC = 1;

const int SFILE_VERIFY_FILE_CRC = 2;

const int SFILE_VERIFY_FILE_MD5 = 4;

const int SFILE_VERIFY_RAW_MD5 = 8;

const int SFILE_VERIFY_ALL = 15;

const int VERIFY_OPEN_ERROR = 1;

const int VERIFY_READ_ERROR = 2;

const int VERIFY_FILE_HAS_SECTOR_CRC = 4;

const int VERIFY_FILE_SECTOR_CRC_ERROR = 8;

const int VERIFY_FILE_HAS_CHECKSUM = 16;

const int VERIFY_FILE_CHECKSUM_ERROR = 32;

const int VERIFY_FILE_HAS_MD5 = 64;

const int VERIFY_FILE_MD5_ERROR = 128;

const int VERIFY_FILE_HAS_RAW_MD5 = 256;

const int VERIFY_FILE_RAW_MD5_ERROR = 512;

const int VERIFY_FILE_ERROR_MASK = 683;

const int SFILE_VERIFY_MPQ_HEADER = 1;

const int SFILE_VERIFY_HET_TABLE = 2;

const int SFILE_VERIFY_BET_TABLE = 3;

const int SFILE_VERIFY_HASH_TABLE = 4;

const int SFILE_VERIFY_BLOCK_TABLE = 5;

const int SFILE_VERIFY_HIBLOCK_TABLE = 6;

const int SFILE_VERIFY_FILE = 7;

const int SIGNATURE_TYPE_NONE = 0;

const int SIGNATURE_TYPE_WEAK = 1;

const int SIGNATURE_TYPE_STRONG = 2;

const int ERROR_NO_SIGNATURE = 0;

const int ERROR_VERIFY_FAILED = 1;

const int ERROR_WEAK_SIGNATURE_OK = 2;

const int ERROR_WEAK_SIGNATURE_ERROR = 3;

const int ERROR_STRONG_SIGNATURE_OK = 4;

const int ERROR_STRONG_SIGNATURE_ERROR = 5;

const int MD5_DIGEST_SIZE = 16;

const int SHA1_DIGEST_SIZE = 20;

const int LANG_NEUTRAL = 0;

const int CCB_CHECKING_FILES = 1;

const int CCB_CHECKING_HASH_TABLE = 2;

const int CCB_COPYING_NON_MPQ_DATA = 3;

const int CCB_COMPACTING_FILES = 4;

const int CCB_CLOSING_ARCHIVE = 5;

const int MPQ_HEADER_SIZE_V1 = 32;

const int MPQ_HEADER_SIZE_V2 = 44;

const int MPQ_HEADER_SIZE_V3 = 68;

const int MPQ_HEADER_SIZE_V4 = 208;

const int MPQ_HEADER_DWORDS = 52;