package com.carsales.service;

import com.carsales.dao.BookingDao;
import com.carsales.model.Booking;
import com.carsales.model.CardPayment;
import com.carsales.model.CashPayment;
import com.carsales.model.PaymentMethod;
import com.carsales.util.IdGenerator;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class PaymentService {
    private static final Logger logger = Logger.getLogger(PaymentService.class.getName());
    private final String paymentFilePath = "src/main/resources/data/payments.txt";
    private final BookingDao bookingDao;

    public PaymentService() {
        this.bookingDao = new BookingDao();
        // Ensure data directory exists
        ensureDataDirectoryExists();
    }


    private void ensureDataDirectoryExists() {
        try {
            File dataDir = new File("src/main/resources/data");
            if (!dataDir.exists()) {
                boolean created = dataDir.mkdirs();
                if (created) {
                    logger.info("Created data directory: " + dataDir.getAbsolutePath());
                } else {
                    logger.warning("Failed to create data directory: " + dataDir.getAbsolutePath());
                }
            }

            // Check if payment file exists and create empty file if needed
            File paymentFile = new File(paymentFilePath);
            if (!paymentFile.exists()) {
                boolean created = paymentFile.createNewFile();
                if (created) {
                    logger.info("Created empty payment file: " + paymentFile.getAbsolutePath());
                } else {
                    logger.warning("Failed to create payment file: " + paymentFile.getAbsolutePath());
                }
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error ensuring data directory exists", e);
        }
    }

    public PaymentMethod processCardPayment(String bookingId, double amount,
                                            String cardNumber, String cardholderName,
                                            String expiryDate, String cvv) {
        logger.info("Processing card payment for booking: " + bookingId);

        // Update booking status if it exists
        Booking booking = bookingDao.findById(bookingId);
        if (booking != null) {
            booking.setStatus("COMPLETED");
            bookingDao.update(booking);
        } else {
            logger.warning("Booking not found for ID: " + bookingId);
        }

        String paymentId = IdGenerator.generateId();
        Date paymentDate = new Date(); // Current date

        CardPayment payment = new CardPayment(
                paymentId, bookingId, amount, paymentDate, "COMPLETED",
                cardNumber, cardholderName, expiryDate, cvv
        );

        // Store payment in file
        boolean stored = storePayment(payment);
        if (!stored) {
            logger.severe("Failed to store card payment: " + paymentId);
        }

        return payment;
    }

    public PaymentMethod processCashPayment(String bookingId, double amount,
                                            String receiptNumber, String cashierName) {
        logger.info("Processing cash payment for booking: " + bookingId);

        // Update booking status if it exists
        Booking booking = bookingDao.findById(bookingId);
        if (booking != null) {
            booking.setStatus("COMPLETED");
            bookingDao.update(booking);
        } else {
            logger.warning("Booking not found for ID: " + bookingId + " but processing payment anyway");
        }

        String paymentId = IdGenerator.generateId();
        Date paymentDate = new Date(); // Current date

        CashPayment payment = new CashPayment(
                paymentId, bookingId, amount, paymentDate, "COMPLETED",
                receiptNumber, cashierName
        );

        // Store payment in file
        boolean stored = storePayment(payment);
        if (!stored) {
            logger.severe("Failed to store cash payment: " + paymentId);
        }

        return payment;
    }

    private boolean storePayment(PaymentMethod payment) {
        try {
            logger.info("Storing payment to file: " + paymentFilePath);

            File paymentFile = new File(paymentFilePath);
            if (!paymentFile.exists()) {
                File dir = paymentFile.getParentFile();
                if (!dir.exists()) {
                    dir.mkdirs();
                }
                paymentFile.createNewFile();
            }

            java.io.FileWriter fw = new java.io.FileWriter(paymentFilePath, true);
            java.io.BufferedWriter bw = new java.io.BufferedWriter(fw);

            bw.write(payment.toFileString());
            bw.newLine();

            bw.close();
            fw.close();

            logger.info("Payment stored successfully: " + payment.getPaymentId());
            return true;
        } catch (java.io.IOException e) {
            logger.log(Level.SEVERE, "Error storing payment", e);
            return false;
        }
    }

    public PaymentMethod findPaymentById(String paymentId) {
        List<PaymentMethod> allPayments = getPaymentsByBookingId(null);
        for (PaymentMethod payment : allPayments) {
            if (payment.getPaymentId().equals(paymentId)) {
                return payment;
            }
        }
        return null;
    }

    public boolean updatePayment(String paymentId, double amount, String bookingId, String status) {
        List<String> lines = new ArrayList<>();
        boolean updated = false;

        try {
            // Read all lines
            File file = new File(paymentFilePath);
            if (!file.exists()) {
                logger.warning("Payment file does not exist: " + paymentFilePath);
                return false;
            }

            java.io.FileReader fr = new java.io.FileReader(paymentFilePath);
            java.io.BufferedReader br = new java.io.BufferedReader(fr);
            String line;

            while ((line = br.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length > 0 && parts[0].equals(paymentId)) {
                    // Update all relevant fields
                    parts[1] = bookingId;
                    parts[2] = String.valueOf(amount);
                    parts[4] = status;

                    line = String.join(",", parts);
                    updated = true;
                }
                lines.add(line);
            }

            br.close();
            fr.close();

            // Write back all lines
            if (updated) {
                java.io.FileWriter fw = new java.io.FileWriter(paymentFilePath, false);
                java.io.BufferedWriter bw = new java.io.BufferedWriter(fw);

                for (String updatedLine : lines) {
                    bw.write(updatedLine);
                    bw.newLine();
                }

                bw.close();
                fw.close();
                logger.info("Payment updated successfully: " + paymentId);
            }
        } catch (java.io.IOException e) {
            logger.severe("Error updating payment: " + e.getMessage());
            return false;
        }

        return updated;
    }

    public List<PaymentMethod> getPaymentsByBookingId(String bookingId) {
        List<PaymentMethod> payments = new ArrayList<>();
        File file = new File(paymentFilePath);

        if (!file.exists()) {
            logger.warning("Payment file does not exist: " + paymentFilePath);
            return payments;
        }

        try {
            java.io.FileReader fr = new java.io.FileReader(paymentFilePath);
            java.io.BufferedReader br = new java.io.BufferedReader(fr);

            String line;
            while ((line = br.readLine()) != null) {
                if (bookingId == null || line.contains(bookingId)) {
                    if (line.contains("CARD")) {
                        payments.add(parseCardPayment(line));
                    } else {
                        payments.add(parseCashPayment(line));
                    }
                }
            }

            br.close();
            fr.close();
        } catch (java.io.IOException e) {
            logger.log(Level.SEVERE, "Error reading payments from file", e);
        }

        return payments;
    }

    private CardPayment parseCardPayment(String line) {
        // Simplified parsing; in a real implementation, you'd need more robust parsing
        String[] parts = line.split(",");
        String paymentId = parts[0];
        String bookingId = parts[1];
        double amount = Double.parseDouble(parts[2]);
        Date paymentDate = new Date(); // Simplified; you should parse the date
        String status = parts[4];
        String cardNumber = parts[6];
        String cardholderName = parts[7];
        String expiryDate = parts[8];

        return new CardPayment(paymentId, bookingId, amount, paymentDate, status,
                cardNumber, cardholderName, expiryDate, "");
    }

    private CashPayment parseCashPayment(String line) {
        // Simplified parsing
        String[] parts = line.split(",");
        String paymentId = parts[0];
        String bookingId = parts[1];
        double amount = Double.parseDouble(parts[2]);
        Date paymentDate = new Date(); // Simplified
        String status = parts[4];
        String receiptNumber = parts[6];
        String cashierName = parts[7];

        return new CashPayment(paymentId, bookingId, amount, paymentDate, status,
                receiptNumber, cashierName);
    }

    public boolean deletePayment(String id) {
        List<String> lines = new ArrayList<>();
        boolean found = false;

        try {
            // Read all lines except the one to delete
            File file = new File(paymentFilePath);
            if (!file.exists()) {
                logger.warning("Payment file does not exist: " + paymentFilePath);
                return false;
            }

            java.io.FileReader fr = new java.io.FileReader(paymentFilePath);
            java.io.BufferedReader br = new java.io.BufferedReader(fr);
            String line;

            while ((line = br.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length > 0 && parts[0].equals(id)) {
                    found = true;
                    continue; // Skip this line
                }
                lines.add(line);
            }

            br.close();
            fr.close();

            // Write back remaining lines
            if (found) {
                java.io.FileWriter fw = new java.io.FileWriter(paymentFilePath, false);
                java.io.BufferedWriter bw = new java.io.BufferedWriter(fw);

                for (String remainingLine : lines) {
                    bw.write(remainingLine);
                    bw.newLine();
                }

                bw.close();
                fw.close();
                logger.info("Payment deleted successfully: " + id);
            }
        } catch (java.io.IOException e) {
            logger.severe("Error deleting payment: " + e.getMessage());
            return false;
        }

        return found;
    }
}