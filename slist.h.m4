#ifndef HEADER_GUARD
#define HEADER_GUARD
/*
 * A singly linked-list of TYPE.
 *
 * COPYRIGHT
 */
#ifdef __cplusplus
extern "C" {
#endif

#include <stddef.h>
#include <stdbool.h>
ifelse(INCLUDE_FILE,`',,#include "`'INCLUDE_FILE`'")

/**
 * NAME`'_alloc_fxn_t is a function pointer for a memory allocation function.
 * It's signature matches the standard C library malloc() function and
 * allows data structures to be allocated with a custom allocation function.
 */
typedef void* (*NAME`'_alloc_fxn_t)(size_t size);

/**
 * NAME`'_free_fxn_t is a function pointer for a memory deallocation function.
 * It's signature matches the standard C library free() function and allows
 * data structures to be allocated with a custom allocation function.
 */
typedef void (*NAME`'_free_fxn_t)(void *data);
ifelse(ADD_DESTROY, true,dnl

/**
 * Destroy function for TYPE.
 */
typedef bool (*NAME`'_element_fxn_t)(TYPE* element);
,)dnl

struct NAME`'_node;
typedef struct NAME`'_node NAME`'_node_t;

typedef struct NAME {
	NAME`'_node_t* head;
	size_t size;
ifelse(ADD_DESTROY, true,dnl
	NAME`'_element_fxn_t destroy;
,)dnl
	NAME`'_alloc_fxn_t  alloc;
	NAME`'_free_fxn_t   free;
} NAME`'_t;

typedef NAME`'_node_t* NAME`'_iterator_t;


ifelse(ADD_DESTROY, true,dnl
void    NAME`'_create        (NAME`'_t *p_list, NAME`'_element_fxn_t destroy_callback, NAME`'_alloc_fxn_t alloc, NAME`'_free_fxn_t free),
void    NAME`'_create        (NAME`'_t *p_list, NAME`'_alloc_fxn_t alloc, NAME`'_free_fxn_t free));
void    NAME`'_destroy       (NAME`'_t *p_list);
bool    NAME`'_insert_front  (NAME`'_t *p_list, ifelse(PASS_BY_REF, true, CONST_TYPE_PTR, TYPE) data); /* O(1) */
bool    NAME`'_remove_front  (NAME`'_t *p_list); /* O(1) */
bool    NAME`'_insert_next   (NAME`'_t *p_list, NAME`'_node_t* p_front_node, ifelse(PASS_BY_REF, true, CONST_TYPE_PTR, TYPE) data); /* O(1) */
bool    NAME`'_remove_next   (NAME`'_t *p_list, NAME`'_node_t* p_front_node); /* O(1) */
void    NAME`'_clear         (NAME`'_t *p_list); /* O(N) */

void    NAME`'_alloc_set     (NAME`'_t *p_list, NAME`'_alloc_fxn_t alloc);
void    NAME`'_free_set      (NAME`'_t *p_list, NAME`'_free_fxn_t free);

NAME`'_iterator_t NAME`'_begin  (const NAME`'_t *p_list);
#define          NAME`'_end() ((NAME`'_iterator_t)NULL)
NAME`'_iterator_t NAME`'_next   (const NAME`'_iterator_t iter);
ifelse(PASS_BY_REF, true, TYPE_PTR, TYPE) NAME`'_get(const NAME`'_iterator_t iter);

#define NAME`'_push               NAME`'_insert_front
#define NAME`'_pop                NAME`'_remove_front

#define NAME`'_head(p_list)       ((p_list)->head)
#define NAME`'_front(p_list)      ((p_list)->head)
#define NAME`'_size(p_list)       ((p_list)->size)
#define NAME`'_is_empty(p_list)   ((p_list)->size <= 0)

#ifdef __cplusplus
}
#endif
#endif /* HEADER_GUARD */
