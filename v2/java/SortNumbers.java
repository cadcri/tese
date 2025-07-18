import java.io.*;
import java.util.*;

public class SortNumbers {
    public static final int MAX_NUMBERS = 10_000_000;

    public static void main(String[] args) {
        if (args.length != 1) {
            System.err.println("Usage: java SortNumbers <filename>");
            System.exit(1);
        }

        String filename = args[0];
        int[] numbers = new int[MAX_NUMBERS];
        int count = 0;

        try (BufferedReader reader = new BufferedReader(new FileReader(filename))) {
            String line;
            while ((line = reader.readLine()) != null) {
                try {
                    numbers[count++] = Integer.parseInt(line.trim());
                    if (count >= MAX_NUMBERS) {
                        System.err.println("Too many numbers");
                        break;
                    }
                } catch (NumberFormatException e) {
                    System.err.println("Invalid number: " + line);
                }
            }
        } catch (IOException e) {
            System.err.println("Error reading file: " + e.getMessage());
            System.exit(1);
        }

        Arrays.sort(numbers, 0, count);

        // Uncomment below if you want to print the sorted numbers
        // for (int i = 0; i < count; i++) {
        //     System.out.println(numbers[i]);
        // }
    }
}