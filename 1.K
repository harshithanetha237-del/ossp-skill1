#include <stdlib.h>
#include <fcntl.h>      // For open()
#include <unistd.h>     // For read(), write(), close()
#include <sys/stat.h>   // For file permissions

#define BUFFER_SIZE 1024

int main(int argc, char *argv[])
{
    int source_fd, dest_fd;
    ssize_t bytes_read, bytes_written;
    char buffer[BUFFER_SIZE];

    // Check the number of command-line arguments
    if (argc != 3)
    {
        printf("Usage: %s <source_file> <destination_file>\n", argv[0]);
        return 1;
    }

    // Open the source file in read-only mode
    source_fd = open(argv[1], O_RDONLY);
    if (source_fd < 0)
    {
        perror("Error opening source file");
        return 1;
    }

    // Create/Open the destination file
    dest_fd = open(argv[2], O_WRONLY | O_CREAT | O_TRUNC, 0644);
    if (dest_fd < 0)
    {
        perror("Error opening destination file");
        close(source_fd);
        return 1;
    }

