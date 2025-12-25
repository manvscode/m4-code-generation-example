divert(-1)dnl These are the expected inputs
    #define(`NAME', pizza_delivery)
    #define(`TYPE', pizza)
    #define(`INCLUDE_FILE', pizza.h)
    #define(`AUTHOR', Joe Marrero)
    #define(`ADD_DESTROY', true)
    #define(`PASS_BY_REF', true)
divert(0)dnl
divert(-1)dnl These are helper macros
    define(`TYPE_PTR', TYPE*)
    define(`CONST_TYPE_PTR', const TYPE*)
    # DEBUG this macro later
    define(`CURRENT_YEAR', `esyscmd(date  +"%Y" | tr -d "\n")')
    define(`COPYRIGHT', Copyright CURRENT_YEAR`,' AUTHOR`'. All rights reserved.)dnl
    define(`NAME_CAPITALIZED', translit(NAME, [a-z], [A-Z]))dnl
    define(`cat', $1$2$3$4$5$6$7$8$9)dnl
    changecom(`', `')dnl
    define(`HEADER_GUARD', cat(_, translit(NAME, [a-z], [A-Z]), _H_))dnl
divert(0)dnl
