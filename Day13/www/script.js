const statusElement = document.querySelector("#site-status");

if (statusElement) {
  const loadedAt = new Date().toLocaleString();
  statusElement.textContent = `Static assets loaded from S3 through CloudFront on ${loadedAt}.`;
}
