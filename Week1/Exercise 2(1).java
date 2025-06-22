package ecommerce;

import java.util.Arrays;
import java.util.Scanner;

public class ECommerceSearch {

    static class Product implements Comparable<Product> {
        int productId;
        String productName;
        String category;

        Product(int id, String name, String cat) {
            productId = id;
            productName = name;
            category = cat;
        }

        public int compareTo(Product other) {
            return Integer.compare(this.productId, other.productId);
        }

        public String toString() {
            return "[" + productId + ", " + productName + ", " + category + "]";
        }
    }

    public static int linearSearch(Product[] products, int targetId) {
        for (int i = 0; i < products.length; i++) {
            if (products[i].productId == targetId) {
                return i;
            }
        }
        return -1;
    }

    public static int binarySearch(Product[] products, int targetId) {
        int left = 0, right = products.length - 1;
        while (left <= right) {
            int mid = (left + right) / 2;
            if (products[mid].productId == targetId) {
                return mid;
            } else if (products[mid].productId < targetId) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return -1;
    }

    public static void main(String[] args) {
        Product[] productList = {
            new Product(101, "Phone", "Electronics"),
            new Product(205, "Shirt", "Clothing"),
            new Product(150, "Book", "Stationery"),
            new Product(310, "Laptop", "Electronics"),
            new Product(125, "Pen", "Stationery")
        };

        Scanner sc = new Scanner(System.in);
        System.out.print("Enter Product ID to search: ");
        int targetId = sc.nextInt();

        int linearResult = linearSearch(productList, targetId);
        if (linearResult != -1) {
            System.out.println("Found (Linear Search): " + productList[linearResult]);
        } else {
            System.out.println("Not Found (Linear Search)");
        }

        Arrays.sort(productList);
        int binaryResult = binarySearch(productList, targetId);
        if (binaryResult != -1) {
            System.out.println("Found (Binary Search): " + productList[binaryResult]);
        } else {
            System.out.println("Not Found (Binary Search)");
        }

        sc.close();
    }
}
