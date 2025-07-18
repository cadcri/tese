#include <stdio.h>
#include <stdlib.h>

#define MAX_NUMBERS 10000000  // adjust this if needed

int compare(const void *a, const void *b) {
	return (*(int *)a - *(int *)b);
}

int main(int argc, char *argv[]) {
	if (argc != 2) {
		fprintf(stderr, "Usage: %s <filename>\n", argv[0]);
		return 1;
	}

	FILE *file = fopen(argv[1], "r");
	if (!file) {
		perror("fopen");
		return 1;
	}

	int *numbers = malloc(MAX_NUMBERS * sizeof(int));
	if (!numbers) {
		perror("malloc");
		fclose(file);
		return 1;
	}

	int count = 0;
	while (fscanf(file, "%d", &numbers[count]) == 1) {
		count++;
		if (count >= MAX_NUMBERS) {
			fprintf(stderr, "Too many numbers\n");
			break;
		}
	}

	fclose(file);

	qsort(numbers, count, sizeof(int), compare);

	free(numbers);
	return 0;
}