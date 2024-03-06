import java.util.Scanner;

public class PizzaCalculator {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // Prompt Joe for number of round pizzas sold
        System.out.print("Enter the number of 11\" round pizzas sold: ");
        int numRoundPizzas = scanner.nextInt();

        // Prompt Joe for number of square pizzas sold
        System.out.print("Enter the number of 9\" square pizzas sold: ");
        int numSquarePizzas = scanner.nextInt();

        // Prompt Joe for his estimate of total pizzas sold in square feet
        System.out.print("Enter your estimate of total pizzas sold in square feet: ");
        float totalEstimate = scanner.nextFloat();

        // Calculate total square footage of round pizzas
        double roundPizzaArea = Math.PI * Math.pow(5.5, 2);
        double totalRoundArea = numRoundPizzas * roundPizzaArea;
        double totalRoundSquareFeet = totalRoundArea / 144.0;

        // Calculate total square footage of square pizzas
        int squarePizzaArea = 81;
        int totalSquareArea = numSquarePizzas * squarePizzaArea;
        double totalSquareSquareFeet = totalSquareArea / 144.0;

        // Calculate total square footage of all pizzas
        double totalPizzaSquareFeet = totalRoundSquareFeet + totalSquareSquareFeet;

        // Print out the results
        System.out.println("Total number of square feet of pizza sold: " + totalPizzaSquareFeet);
        System.out.println("Total number of square feet of round pizzas sold: " + totalRoundSquareFeet);
        System.out.println("Total number of square feet of square pizzas sold: " + totalSquareSquareFeet);

        // Print the message "Woosh!" if total pizza sold is greater than Joe's
        // estimate, otherwise print "Bummer!"
        if (totalPizzaSquareFeet > totalEstimate) {
            System.out.println("Woosh!");
        } else {
            System.out.println("Bummer!");
        }
    }
}
