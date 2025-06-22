package forecast;

import java.util.Scanner;

public class FinancialForecast {

    public static double forecastValue(double currentValue, double growthRate, int years) {
        if (years == 0) {
            return currentValue;
        }
        return forecastValue(currentValue * (1 + growthRate), growthRate, years - 1);
    }

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        System.out.print("Enter current value: ");
        double currentValue = sc.nextDouble();

        System.out.print("Enter annual growth rate (as decimal, e.g., 0.1 for 10%): ");
        double growthRate = sc.nextDouble();

        System.out.print("Enter number of years to predict: ");
        int years = sc.nextInt();

        double futureValue = forecastValue(currentValue, growthRate, years);

        System.out.printf("Predicted future value after %d years: %.2f\n", years, futureValue);
        sc.close();
    }
}
