decode_state(get_process_state(pid)));

        /* Give the child a moment to start sleeping, then sample state */
        usleep(500000); /* 0.5 sec */
        printf("Parent -> Child's state while child is sleeping(): %s\n\n",
               decode_state(get_process_state(pid)));

        /* Wait for child to finish WITHOUT reaping immediately,
         * so we can catch it as a zombie for demonstration.        */
        sleep(3); /* child will have called exit() by now */
        printf("Parent -> Child's state right after child exit() "
               "(before wait()): %s\n\n",
               decode_state(get_process_state(pid)));

        int status;
        pid_t reaped = waitpid(pid, &status, 0);  /* reap the zombie */

        printf("===================================================\n");
        printf(" AFTER waitpid() - child has been reaped\n");
        printf("===================================================\n");
        if (reaped == pid) {
            if (WIFEXITED(status))
                printf("Parent -> Reaped child PID %d, exit status = %d\n",
                       reaped, WEXITSTATUS(status));
            else
                printf("Parent -> Child %d terminated abnormally\n", reaped);
        }
        printf("Parent -> Child's state after reaping: %s\n",
               decode_state(get_process_state(pid)));

        printf("\nParent -> PID: %d | PPID: %d | State: %s | Exiting now.\n",
               getpid(), getppid(), decode_state(get_process_state(getpid())));
    }

    return 0;
}
