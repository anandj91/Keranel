#include<stdint.h>

void type();
void write_char(int color, const char c, volatile char* mem);
static inline void outb(uint16_t port, uint8_t val);
static inline uint8_t inb(uint16_t port);
static inline void io_wait(void);
char get_scan_code();
char getchar();

void main()
{
    type();
}

void type()
{
    volatile char* video_memory = (char*) 0xb8000;

    while(1) {
		char c = get_scan_code();
		write_char(10, c, video_memory);
		video_memory+=2;
    }
}

void write_char(int color, char c, volatile char* mem)
{
	*mem = c+1;
	mem++;
	*mem = color;
}

static inline void outb(uint16_t port, uint8_t val)
{
    asm volatile ( "outb %0, %1" : : "a"(val), "Nd"(port) );
}

static inline uint8_t inb(uint16_t port)
{
    uint8_t ret;
    asm volatile ( "inb %1, %0"
                   : "=a"(ret)
                   : "Nd"(port) );
    return ret;
}

static inline void io_wait(void)
{
    asm volatile ( "outb %%al, $0x80" : : "a"(0) );
}

char get_scan_code()
{
	char c=0;
	do {
		if(inb(0x60)!=c)
		{
			c=inb(0x60);
			if(c>0)
				return c;
		}
	} while(1);
}

