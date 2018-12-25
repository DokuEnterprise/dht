# RUN THIS IF IT WONT LOAD 
# sudo /sbin/ldconfig -v


CC = gcc # C compiler
CFLAGS = -fPIC -Wall -Wextra -O2 -g # C flags
LDFLAGS = -shared -lcrypt # linking flags
RM = rm -f  # rm command
TARGET_LIB = libdht.so # target lib
HEADERS = $(shell echo *.h)
IDS = $(shell echo *.id)

SRCS = dht.c dht-example.c # source files
OBJS = $(SRCS:.c=.o)

.PHONY: all
all: ${TARGET_LIB}

$(TARGET_LIB): $(OBJS)
	$(CC) ${LDFLAGS} -o $@ $^

$(SRCS:.c=.d):%.d:%.c
	$(CC) $(CFLAGS) -MM $< >$@

include $(SRCS:.c=.d)

.PHONY: clean
clean:
	-${RM} ${TARGET_LIB} ${OBJS} $(SRCS:.c=.d)  ${IDS}

install:
	cp $(HEADERS) /usr/local/include/dht
	cp libdht.so /usr/local/lib