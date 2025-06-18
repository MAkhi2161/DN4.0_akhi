package singleton;

public class SingletonLoggerTest {

    static class Logger {
        private static Logger instance;

        private Logger() {
            System.out.println("Logger initialized.");
        }

        public static Logger getInstance() {
            if (instance == null) {
                instance = new Logger();
            }
            return instance;
        }

        public void log(String message) {
            System.out.println("LOG: " + message);
        }
    }

    public static void main(String[] args) {
        Logger logger1 = Logger.getInstance();
        logger1.log("User clicked on 'Login' button.");

        Logger logger2 = Logger.getInstance();
        logger2.log("Database connection established.");

        Logger logger3 = Logger.getInstance();
        logger3.log("User successfully logged in.");

        if (logger1 == logger2 && logger2 == logger3) {
            System.out.println("All logger references point to the same instance.");
        } else {
            System.out.println("Singleton pattern failed: multiple instances exist.");
        }
    }
}
