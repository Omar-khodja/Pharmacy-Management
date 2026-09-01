class ApiErrorHandler {



   String handleError(String statusCode) {
    switch (statusCode) {
      case "401":
        return "Not logged in or token expired. Please log in again.";
      case "403":
        return "Account inactive.";
      case "404":
        return "Resource not found.";
      case "422":
        return "Validation error. Please check your Email or password.";
      case "500":
        return "Server error. Please try again later.";
      default:
        return "Unexpected error occurred (code $statusCode).";
    }
  }
}
