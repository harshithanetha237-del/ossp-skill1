#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

#define MAX_INPUT 1024
#define MAX_ARGS 64

int main()
{
    char input[MAX_INPUT];
    char *args[MAX_ARGS];

    printf("=================================\n");
    printf("       MINI UNIX SHELL\n");
    printf("=================================\n");
    printf("Type 'exit' to quit.\n\n");

    while (1)
    {
        printf("mini-shell> ");
        fflush(stdout);

        /* Read command from user */
        if (fgets(input, sizeof(input), stdin) == NULL)
        {
            break;
        }

        /* Remove newline */
        input[strcspn(input, "\n")] = '\0';

        /* Ignore empty input */
        if (strlen(input) == 0)
        {
continue;
        }

        /* Create child process */
        pid_t pid = fork();

        if (pid < 0)
        {
            perror("fork failed");
        }
        else if (pid == 0)
        {
            /* Child process executes command */
            execvp(args[0], args);

            /* Runs only if execvp fails */
            perror("Command execution failed");
            exit(EXIT_FAILURE);
        }
        else
        {
            /* Parent process waits for child */
            waitpid(pid, NULL, 0);
        }
    }

    return 0;
}
