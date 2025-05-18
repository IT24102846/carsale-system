<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Create Payment | AutoMarket</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .payment-form {
      max-width: 650px;
      margin: 50px auto;
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 0 20px rgba(0,0,0,0.1);
      background-color: white;
    }
    .form-header {
      text-align: center;
      margin-bottom: 30px;
    }
  </style>
</head>
<body>
<div class="container">
  <div class="payment-form">
    <div class="form-header">
      <h2>Create Payment</h2>
      <p class="text-muted">Enter payment details</p>
    </div>

    <c:if test="${not empty message}">
      <div class="alert alert-success alert-dismissible fade show" role="alert">
          ${message}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      </div>
    </c:if>

    <c:if test="${not empty error}">
      <div class="alert alert-danger alert-dismissible fade show" role="alert">
          ${error}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      </div>
    </c:if>

    <form action="/payments/save" method="post">
      <div class="mb-3">
        <label for="userId" class="form-label">User ID</label>
        <input type="text" class="form-control" id="userId" name="userId" required>
      </div>

      <div class="mb-3">
        <label for="amount" class="form-label">Amount</label>
        <div class="input-group">
          <span class="input-group-text">$</span>
          <input type="number" step="0.01" min="0" class="form-control" id="amount" name="amount" required>
        </div>
      </div>

      <div class="mb-3">
        <label for="paymentType" class="form-label">Payment Type</label>
        <select class="form-select" id="paymentType" name="paymentType">
          <option value="CARD">Credit/Debit Card</option>
          <option value="CASH">Cash</option>
          <option value="BANK_TRANSFER">Bank Transfer</option>
          <option value="PAYPAL">PayPal</option>
        </select>
      </div>

      <!-- Card payment fields (shown by default) -->
      <div id="cardFields">
        <div class="mb-3">
          <label for="cardNumber" class="form-label">Card Number</label>
          <input type="text" class="form-control" id="cardNumber" name="cardNumber" placeholder="XXXX XXXX XXXX XXXX">
        </div>
        <div class="row">
          <div class="col-md-6">
            <div class="mb-3">
              <label for="cardholderName" class="form-label">Cardholder Name</label>
              <input type="text" class="form-control" id="cardholderName" name="cardholderName">
            </div>
          </div>
          <div class="col-md-3">
            <div class="mb-3">
              <label for="expiryDate" class="form-label">Expiry Date</label>
              <input type="text" class="form-control" id="expiryDate" name="expiryDate" placeholder="MM/YY">
            </div>
          </div>
          <div class="col-md-3">
            <div class="mb-3">
              <label for="cvv" class="form-label">CVV</label>
              <input type="text" class="form-control" id="cvv" name="cvv" placeholder="XXX">
            </div>
          </div>
        </div>
      </div>

      <!-- Cash payment fields (hidden by default) -->
      <div id="cashFields" style="display: none;">
        <div class="mb-3">
          <label for="receiptNumber" class="form-label">Receipt Number</label>
          <input type="text" class="form-control" id="receiptNumber" name="receiptNumber">
        </div>
        <div class="mb-3">
          <label for="cashierName" class="form-label">Cashier Name</label>
          <input type="text" class="form-control" id="cashierName" name="cashierName">
        </div>
      </div>

      <div class="d-grid gap-2 mt-4">
        <button type="submit" class="btn btn-primary">Process Payment</button>
        <a href="/payments" class="btn btn-outline-secondary">Cancel</a>
      </div>
    </form>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
  // Show/hide payment-specific fields
  document.getElementById('paymentType').addEventListener('change', function() {
    const paymentType = this.value;
    const cardFields = document.getElementById('cardFields');
    const cashFields = document.getElementById('cashFields');

    cardFields.style.display = 'none';
    cashFields.style.display = 'none';

    if (paymentType === 'CARD') {
      cardFields.style.display = 'block';
    } else if (paymentType === 'CASH') {
      cashFields.style.display = 'block';
    }
  });
</script>
</body>
</html>