# Example of using m4 for C code generation
This is an example of how to use m4 to create reusable generic code.

## Install GNU m4
Make sure that you have m4 installed:

    brew install m4

## Run the example

    $ ./test.sh 
    Name of data structure: 
    device_list
    Data Type: 
    device_t
    What header file declares this data type: (device_t.h)
    device.h
    Author: 
    John Doe
    Add destroy callback? (yes/no)
    yes
    Should pass by reference? (yes/no)
    yes
