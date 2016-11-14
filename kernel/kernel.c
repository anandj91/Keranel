void write_string(int color, const char* str);

void main()
{
    write_string(10, "First driver");
}

void write_string(int color, const char* str)
{
    volatile char* video_memory = (char*) 0xb8000;

    while(*str != '\0') {
        *video_memory = *(str);
        str++;
        video_memory++;
        *video_memory = color;
        video_memory++;
    }
}
