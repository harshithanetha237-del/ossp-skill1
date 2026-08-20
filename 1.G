GNU nano 8.7.1                                                              exp2.A *
            fprintf(stderr, "Partial write: expected %zd, wrote %zd\n",
                    bytes_read, bytes_written);
            close(src_fd);
            close(dst_fd);
            exit(EXIT_FAILURE);
        }

        total_bytes_copied += bytes_written;
    }

    if (bytes_read < 0) {
        perror("read failed");
        close(src_fd);
        close(dst_fd);
        exit(EXIT_FAILURE);
    }

    /* ---------------------------------------------------------
     * STEP 4: close() both file descriptors.
     * Another system call -> kernel releases the fd table entry
     * and flushes any buffered data associated with it.
     * --------------------------------------------------------- */
    if (close(src_fd) < 0) {
        perror("close (source) failed");
        exit(EXIT_FAILURE);
    }
    if (close(dst_fd) < 0) {
        perror("close (destination) failed");
        exit(EXIT_FAILURE);
    }

    printf("[User space] Copy complete: %ld bytes copied from '%s' to '%s'\n",
           total_bytes_copied, src_path, dst_path);

    return 0;
}
