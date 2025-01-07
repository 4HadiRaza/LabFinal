import java.util.*;

class Item {
    String name;
    String category;
    double price;
    double rating;

    public Item(String name, String category, double price, double rating) {
        this.name = name;
        this.category = category;
        this.price = price;
        this.rating = rating;
    }

    @Override
    public String toString() {
        return String.format("Item{name='%s', category='%s', price=%.2f, rating=%.1f}", name, category, price, rating);
    }
}

class User {
    String name;
    String preferredCategory;
    double budget;

    public User(String name, String preferredCategory, double budget) {
        this.name = name;
        this.preferredCategory = preferredCategory;
        this.budget = budget;
    }
}

class UserPreference {
    private final String category;
    private final double budget;

    public UserPreference(String category, double budget) {
        this.category = category;
        this.budget = budget;
    }

    public String getCategory() {
        return category;
    }

    public double getBudget() {
        return budget;
    }
}

class Criteria {
    String category;
    double maxPrice;
    double minRating;

    public Criteria(String category, double maxPrice, double minRating) {
        this.category = category;
        this.maxPrice = maxPrice;
        this.minRating = minRating;
    }

    public boolean matches(Item item) {
        return item.category.equalsIgnoreCase(category) &&
               item.price <= maxPrice &&
               item.rating >= minRating;
    }
}

class ShoppingAssistant {
    private final List<Item> items;

    public ShoppingAssistant() {
        this.items = new ArrayList<>();
    }

    public void addItem(Item item) {
        if (item != null) {
            items.add(item);
        }
    }

    public Item suggestBestItem(User user) {
        return items.stream()
                .filter(item -> item.category.equalsIgnoreCase(user.preferredCategory))
                .filter(item -> item.price <= user.budget)
                .max(Comparator.comparingDouble(item -> item.rating))
                .orElse(null);
    }

    public Item suggestLowerBudgetItem(User user) {
        return items.stream()
                .filter(item -> item.category.equalsIgnoreCase(user.preferredCategory))
                .filter(item -> item.price < user.budget)
                .max(Comparator.comparingDouble(item -> item.rating))
                .orElse(null);
    }

    public void removeItem(Item item) {
        items.remove(item);
    }
}

public class ShoppingAssistantApp {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        ShoppingAssistant assistant = new ShoppingAssistant();

        assistant.addItem(new Item("Laptop", "Electronics", 900.00, 4.5));
        assistant.addItem(new Item("Smartphone", "Electronics", 700.00, 4.7));
        assistant.addItem(new Item("Headphones", "Electronics", 200.00, 4.3));
        assistant.addItem(new Item("Coffee Maker", "Home Appliances", 100.00, 4.6));

        User user = new User("Alice", "Electronics", 800.00);
        UserPreference userPreference = new UserPreference(user.preferredCategory, user.budget);

        Item suggestedItem = assistant.suggestBestItem(user);
        System.out.println(suggestedItem != null
                ? "Suggested Item: " + suggestedItem
                : "No suitable items found within your preferences.");

        while (true) {
            Item lowerBudgetItem = assistant.suggestLowerBudgetItem(user);
            if (lowerBudgetItem == null) {
                System.out.println("No lower budget items available.");
                break;
            }

            System.out.println("Suggested Lower Budget Item: " + lowerBudgetItem);
            System.out.print("Do you want this item? (y/n): ");

            String response = scanner.nextLine().trim().toLowerCase();

            if (response.equals("y")) {
                System.out.println("You have chosen: " + lowerBudgetItem);
                break;
            } else {
                assistant.removeItem(lowerBudgetItem);
            }
        }

        scanner.close();
    }
}
