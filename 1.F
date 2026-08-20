#include <stdio.h>

int main() {
    int num;

    printf("Enter a number: ");
    scanf("%d", &num);

    if (num < 0)
        printf("%d is a Negative number.\n", num);
    else
        printf("%d is Not a Negative number.\n", num);

    return 0;
}
