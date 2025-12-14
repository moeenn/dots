#pragma once

typedef enum
{
    RESULT_OK = 0,
    RESULT_ERR = 1,
} result_e;

#define passert(condition)                                                                                             \
    if (!(condition))                                                                                                  \
    {                                                                                                                  \
        fprintf(stderr, "%s:%d assertion failed\n", __FILE_NAME__, __LINE__);                                          \
        exit(EXIT_FAILURE);                                                                                            \
    }
