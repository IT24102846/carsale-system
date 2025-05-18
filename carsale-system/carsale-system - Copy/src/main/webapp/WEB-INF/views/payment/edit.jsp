<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Edit Payment</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
  <h2>Edit Payment</h2>
  <p class="text-muted">Update payment details</p>

  <form action="/payments/update" method="post">
    <input type="hidden" name="id" value="${payment.id}" />

    <div class="mb-3">
      <label for="userId" class="form-label">User ID</label>
      <input type="text" class="form-control" id="userId" name="userId" value="${payment.userId}" required>
    </div>

    <div class="mb-3">
      <label for="amount" class="form-label">Amount</label>
      <input type="number" step="0.01" class="form-control" id="amount" name="amount" value="${payment.amount}" required>
    </div>

    <div class="mb-3">
      <label for="status" class="form-label">Status</label>
      <select class="form-select" id="status" name="status">
        <option value="PENDING" ${payment.status == 'PENDING' ? 'selected' : ''}>Pending</option>
        <option value="COMPLETED" ${payment.status == 'COMPLETED' ? 'selected' : ''}>Completed</option>
        <option value="CANCELLED" ${payment.status == 'CANCELLED' ? 'selected' : ''}>Cancelled</option>
        <option value="FAILED" ${payment.status == 'FAILED' ? 'selected' : ''}>Failed</option>
      </select>
    </div>

    <div class="d-grid gap-2">
      <button type="submit" class="btn btn-primary">Update Payment</button>
      <a href="/payments" class="btn btn-outline-secondary">Cancel</a>
    </div>
  </form>
</div>
</body>
</html>