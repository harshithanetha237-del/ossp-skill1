#include <stdio.h>
#include <math.h>

int main() {
    int n, original, remainder, digits = 0;
    int sum = 0;

    printf("Enter a number: ");
    scanf("%d", &n);

    original = n;

    // Count the number of digits
    while (n != 0) {
        digits++;
        n /= 10;
    }

    n = original;

    // Calculate the sum of each digit raised to the power of digits
    while (n != 0) {
        remainder = n % 10;
        sum += pow(remainder, digits);
        n /= 10;
    }

    if (sum == original)
        printf("%d is an Armstrong number.\n", original);
    else
        printf("%d is not an Armstrong number.\n", original);

    return 0;
}
