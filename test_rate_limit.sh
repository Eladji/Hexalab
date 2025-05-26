#!/bin/bash

# URL to test (adjust if your server is not on localhost or you want to test a specific page)
URL="http://10.1.7.1/"
# URL_PHP="http://localhost/index.php" # Uncomment to test a PHP page specifically

# Number of requests to send in a burst
TOTAL_REQUESTS=10

# Small delay between requests (in seconds), you can set this to 0 for a faster burst
DELAY_BETWEEN_REQUESTS=0.1 # 100 milliseconds

echo "Starting rate limit test on $URL..."
echo "Configuration: 1 request/second, burst of 5, nodelay"
echo "----------------------------------------------------"

for i in $(seq 1 $TOTAL_REQUESTS)
do
  echo -n "Request $i: "
  # Use -s for silent, -o /dev/null to discard output, -w "%{http_code}" to get status code
  # Use --connect-timeout 5 to avoid waiting too long if the server is down
  # Use -I to fetch headers only, which is often enough for testing and lighter
  STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" --connect-timeout 5 -I "$URL")
  # To test a PHP page instead (if you have one):
  # STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" --connect-timeout 5 "$URL_PHP")
  echo "Status Code: $STATUS_CODE"

  # If you want to see the server's response for 503s, you can remove -o /dev/null
  # and inspect the output, e.g.:
  # if [ "$STATUS_CODE" -eq 503 ]; then
  #   curl -v "$URL" # This will be verbose
  # fi

  sleep $DELAY_BETWEEN_REQUESTS
done

echo "----------------------------------------------------"
echo "Test finished."
echo "Expected behavior:"
echo " - First ~5 requests should ideally be 200 OK (or 404 if the root/index.php isn't found)."
echo " - Subsequent requests might be 503 Service Temporarily Unavailable if the rate limit is hit."
echo "Note: Actual behavior can depend on precise timing and server load."
