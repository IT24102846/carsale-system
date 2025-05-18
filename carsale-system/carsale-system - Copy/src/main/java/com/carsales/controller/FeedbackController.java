package com.carsales.controller;

import com.carsales.model.Feedback;
import com.carsales.service.FeedbackService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/feedback")
public class FeedbackController {

    private final FeedbackService feedbackService;

    public FeedbackController() {
        this.feedbackService = new FeedbackService();
    }

    @GetMapping("")
    public String displayFeedback(Model model) {
        List<Feedback> feedbackList = feedbackService.findAll();
        model.addAttribute("feedbackList", feedbackList);
        return "Feedback/display";
    }

    @GetMapping("/create")
    public String showCreateForm() {
        return "Feedback/create";
    }

    @PostMapping("/create")
    public String createFeedback(@RequestParam String username,
                                 @RequestParam String comment,
                                 HttpSession session,
                                 RedirectAttributes redirectAttributes) {

        // Get user ID from session if available, otherwise use a default
        String userId = (String) session.getAttribute("userId");
        if (userId == null) {
            userId = "guest";
        }

        // For simplicity, we're treating this as general feedback
        boolean success = feedbackService.addUserFeedback(
                userId, "SYSTEM", "N/A", 5, comment
        );

        if (success) {
            redirectAttributes.addFlashAttribute("message", "Feedback submitted successfully");
        } else {
            redirectAttributes.addFlashAttribute("error", "Error submitting feedback");
        }

        return "redirect:/feedback";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable String id, Model model) {
        Feedback feedback = feedbackService.findById(id);
        if (feedback == null) {
            return "redirect:/feedback";
        }

        model.addAttribute("feedback", feedback);
        return "Feedback/edit";
    }

    @PostMapping("/update/{id}")
    public String updateFeedback(@PathVariable String id,
                                 @RequestParam String username,
                                 @RequestParam String comment,
                                 RedirectAttributes redirectAttributes) {

        Feedback feedback = feedbackService.findById(id);
        if (feedback == null) {
            redirectAttributes.addFlashAttribute("error", "Feedback not found");
            return "redirect:/feedback";
        }

        // Update only comment field for simplicity
        feedback.setComment(comment);

        boolean updated = feedbackService.updateFeedback(feedback);

        if (updated) {
            redirectAttributes.addFlashAttribute("message", "Feedback updated successfully");
        } else {
            redirectAttributes.addFlashAttribute("error", "Error updating feedback");
        }

        return "redirect:/feedback";
    }

    @GetMapping("/delete/{id}")
    public String deleteFeedback(@PathVariable String id,
                                 RedirectAttributes redirectAttributes) {

        boolean deleted = feedbackService.deleteFeedback(id);

        if (deleted) {
            redirectAttributes.addFlashAttribute("message", "Feedback deleted successfully");
        } else {
            redirectAttributes.addFlashAttribute("error", "Error deleting feedback");
        }

        return "redirect:/feedback";
    }
}