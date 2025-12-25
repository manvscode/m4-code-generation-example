#include <stdlib.h>
#include <assert.h>
#include "`'NAME`'.h"

struct NAME`'_node {
	struct NAME`'_node* next;
	TYPE data;
};


ifelse(ADD_DESTROY, true,dnl
void NAME`'_create(NAME`'_t *p_list, NAME`'_element_fxn_t destroy_callback, NAME`'_alloc_fxn_t alloc, NAME`'_free_fxn_t free),
void NAME`'_create(NAME`'_t *p_list, NAME`'_alloc_fxn_t alloc, NAME`'_free_fxn_t free))
{
	assert(p_list);

	p_list->head    = NULL;
	p_list->size    = 0;
ifelse(ADD_DESTROY, true,dnl
	p_list->destroy = destroy_callback;
    ,)
	p_list->alloc = alloc;
	p_list->free  = free;
}

void NAME`'_destroy(NAME`'_t *p_list)
{
	NAME`'_clear(p_list);

	#ifdef NAME`'_DEBUG
	p_list->head    = NULL;
	p_list->size    = 0;
	#endif
}

bool NAME`'_insert_front(NAME`'_t *p_list, ifelse(PASS_BY_REF, true, CONST_TYPE_PTR, TYPE) data) /* O(1) */
{
	NAME`'_node_t *p_node;
	assert(p_list);

	p_node = p_list->alloc(sizeof(NAME`'_node_t));
	assert(p_node);

	if (p_node != NULL)
	{
		p_node->data = ifelse(PASS_BY_REF, true, *data, data);
		p_node->next = p_list->head;

		p_list->head = p_node;
		p_list->size++;
		return true;
	}

	return false;
}

bool NAME`'_remove_front(NAME`'_t *p_list) /* O(1) */
{
	NAME`'_node_t *p_node;
	bool result = true;

	assert(p_list);
	assert(NAME`'_size(p_list) >= 1);

	p_node = p_list->head->next;
ifelse(ADD_DESTROY, true,dnl

    if (p_list->destroy)
    {
        ifelse(PASS_BY_REF, true,dnl
		result = p_list->destroy(&p_list->head->data),dnl
		result = p_list->destroy(p_list->head->data));dnl
    },)
	p_list->free(p_list->head);

	p_list->head = p_node;
	p_list->size--;

	return result;
}

bool NAME`'_insert_next(NAME`'_t *p_list, NAME`'_node_t* p_front_node, ifelse(PASS_BY_REF, true, CONST_TYPE_PTR, TYPE) data) /* O(1) */
{
	assert(p_list);
	assert(p_front_node);

	if (p_front_node)
	{
		NAME`'_node_t *p_node = p_list->alloc(sizeof(NAME`'_node_t));
		assert(p_node);

		if (p_node != NULL)
		{
		    p_node->data = ifelse(PASS_BY_REF, true, *data, data);
			p_node->next = p_front_node->next;

			p_front_node->next = p_node;
			p_list->size++;
			return true;
		}

		return false;
	}

	return NAME`'_insert_front(p_list, data);
}

bool NAME`'_remove_next(NAME`'_t *p_list, NAME`'_node_t *p_front_node) /* O(1) */
{
	assert(p_list);
	assert(NAME`'_size(p_list) >= 1);

	if (p_front_node)
	{
		bool result = true;
		NAME`'_node_t *p_node;
		NAME`'_node_t *p_new_next;

		assert(p_front_node->next);
		p_node     = p_front_node->next;
		p_new_next = p_node->next;
ifelse(ADD_DESTROY, true,dnl

		if (p_list->destroy)
		{
            ifelse(PASS_BY_REF, true,dnl
			result = p_list->destroy(&p_node->data),
            result = p_list->destroy(p_node->data));
        },)
		p_list->free(p_node);

		p_front_node->next = p_new_next;
		p_list->size--;

		return result;
	}

	return NAME`'_remove_front(p_list);
}

void NAME`'_clear(NAME`'_t *p_list)
{
	while (NAME`'_head(p_list))
	{
		NAME`'_remove_front(p_list);
	}
}

void NAME`'_alloc_set(NAME`'_t *p_list, NAME`'_alloc_fxn_t alloc)
{
	assert(p_list);
	assert(alloc);
	p_list->alloc = alloc;
}

void NAME`'_free_set(NAME`'_t *p_list, NAME`'_free_fxn_t free)
{
	assert(p_list);
	assert(free);
	p_list->free = free;
}

NAME`'_iterator_t NAME`'_begin(const NAME`'_t *p_list)
{
	assert(p_list);
	return p_list->head;
}

NAME`'_iterator_t NAME`'_next(const NAME`'_iterator_t iter)
{
	assert(iter);
	return iter->next;
}

ifelse(PASS_BY_REF, true, TYPE_PTR, TYPE) NAME`'_get(const NAME`'_iterator_t iter)
{
	assert(iter);
	return ifelse(PASS_BY_REF, true, &iter->data, iter->data);
}
