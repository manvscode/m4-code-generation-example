#!/bin/bash

echo "Name of data structure: "
read name

echo "Data Type: "
read type

echo "What header file declares this data type: ($type.h)"
read include_file

echo "Author: "
read author

echo "Add destroy callback? (yes/no)"
read add_destroy

if [[ "$add_destroy" == "yes" ]]; then
    add_destroy=true
else
    add_destroy=false
fi

echo "Should pass by reference? (yes/no)"
read pass_by_ref

if [[ "$pass_by_ref" == "yes" ]]; then
    pass_by_ref=true
else
    pass_by_ref=false
fi


mkdir -p out

#define(`NAME', pizza_delivery)
#define(`TYPE', pizza)
#define(`AUTHOR', Joe Marrero)
#define(`ADD_DESTROY', true)
#define(`PASS_BY_REF', true)

 m4 -E \
     -DNAME="$name" \
     -DTYPE="$type" \
     -DINCLUDE_FILE="$include_file" \
     -DAUTHOR="$author" \
     -DADD_DESTROY="$add_destroy" \
     -DPASS_BY_REF="$pass_by_ref" \
     ./start.m4 ./slist.h.m4 > ./out/$name.h
 m4 -E \
     -DNAME="$name" \
     -DTYPE="$type" \
     -DAUTHOR="$author" \
     -DADD_DESTROY="$add_destroy" \
     -DPASS_BY_REF="$pass_by_ref" \
     ./start.m4 ./slist.c.m4 > ./out/$name.c
