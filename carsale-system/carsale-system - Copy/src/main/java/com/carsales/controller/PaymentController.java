package com.carsales.controller;

import com.carsales.model.Payment;
import com.carsales.model.PaymentMethod;
import com.carsales.service.PaymentService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.logging.Logger;


@Controller
@RequestMapping("/payments")
public class PaymentController {

    private static final Logger logger = Logger.getLogger(PaymentController.class.getName());
    private final PaymentService paymentService;

    public PaymentController() {
        this.paymentService = new PaymentService();
    }

    @GetMapping("")
    public String displayPayments(Model model, HttpSession session) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }

        model.addAttribute("paymentList", paymentService.getPaymentsByBookingId(null));
        return "payment/display";
    }

    @GetMapping("/create")
    public String showCreateForm(HttpSession session) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }

        return "payment/create";
    }

    @PostMapping("/save")
    public String createPayment(@RequestParam String userId,
                                @RequestParam String amount,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {

        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }

        try {
            double amountValue = Double.parseDouble(amount);

            String bookingId = "BK" + System.currentTimeMillis();
            String receiptNumber = "RCPT" + System.currentTimeMillis();
            String cashierName = session.getAttribute("username") != null ?
                    (String)session.getAttribute("username") : "System";

            paymentService.processCashPayment(
                    bookingId,
                    amountValue,
                    receiptNumber,
                    cashierName
            );

            redirectAttributes.addFlashAttribute("message", "Payment processed successfully");
        } catch (NumberFormatException e) {
            redirectAttributes.addFlashAttribute("error", "Invalid amount format");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error processing payment: " + e.getMessage());
        }

        return "redirect:/payments";
    }

    @GetMapping("/edit")
    public String showEditForm(@RequestParam String id,
                               Model model,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }

        try {
            PaymentMethod paymentMethod = paymentService.findPaymentById(id);

            if (paymentMethod != null) {
                Payment payment = new Payment(
                        paymentMethod.getPaymentId(),
                        paymentMethod.getBookingId(),
                        paymentMethod.getAmount(),
                        paymentMethod.getStatus()
                );
                model.addAttribute("payment", payment);
            } else {
                redirectAttributes.addFlashAttribute("error", "Payment not found");
                return "redirect:/payments";
            }

            return "payment/edit";
        } catch (Exception e) {
            logger.severe("Error loading payment for edit: " + e.getMessage());
            redirectAttributes.addFlashAttribute("error", "Error loading payment: " + e.getMessage());
            return "redirect:/payments";
        }
    }

    @PostMapping("/update")
    public String updatePayment(@RequestParam String id,
                                @RequestParam String userId,
                                @RequestParam String amount,
                                @RequestParam String status,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {

        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }

        try {
            double amountValue = Double.parseDouble(amount);

            // Update with all fields including status
            boolean updated = paymentService.updatePayment(
                    id,
                    amountValue,
                    userId,
                    status
            );

            if (updated) {
                redirectAttributes.addFlashAttribute("message", "Payment updated successfully");
            } else {
                redirectAttributes.addFlashAttribute("error", "Error updating payment");
            }
        } catch (NumberFormatException e) {
            redirectAttributes.addFlashAttribute("error", "Invalid amount format");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error updating payment: " + e.getMessage());
        }

        return "redirect:/payments";
    }

    @GetMapping("/delete")
    public String deletePayment(@RequestParam String id,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {

        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }

        try {
            boolean deleted = paymentService.deletePayment(id);

            if (deleted) {
                redirectAttributes.addFlashAttribute("message", "Payment deleted successfully");
            } else {
                redirectAttributes.addFlashAttribute("error", "Payment not found or couldn't be deleted");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error deleting payment: " + e.getMessage());
        }

        return "redirect:/payments";
    }
}