#!/bin/bash
#Please check resources/ for individual scripts

current_utc_timestamp=$(date -u "+%Y-%m-%dT%H:%M:%S%z")
# The following code will get u a time stamp that you can prove in your ownership
echo "Starting hash script, please provide which file you want to store as a hash"
function get_file_hash() {
  local file_path="$1"
  local hash_algorithm="sha256"

  if [[ ! -f "$file_path" ]]; then
    echo "Error: File '$file_path' does not exist." >&2
    return 1
  fi
  # Calculating the hash
  hash_value=$(openssl dgst -"$hash_algorithm" "$file_path" | awk '{print $2}')
  echo "Your Hash Value is:'$hash_value'"
}
# Get the file path from the user
read -p "Enter the file path: " file_path
file_hash=$(get_file_hash "$file_path")
if [[ $? -eq 0 ]]; then
  echo "SHA256 hash of '$file_path': $file_hash"
fi
# DNS gen script
function generate_random_string() {
  local length="${1:-500}" 
  local chars="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
  local random_string=""
  for (( i=0; i<$length; i++ )); do
    random_string+=${chars:$(tr -dc A-Za-z0-9 </dev/urandom | fold -w1 | head -n1):1}}
  done
  echo "$random_string"
}
random_alphanumeric=$(generate_random_string)
output="owner.asop.asia={$random_alphanumeric}"
echo "please create a dns record named _proof and set it as a TXT record and put the following string in your record"
echo $output
echo "Please make sure that you include This Timpstamp in your certificate aswell:"
echo "Current timestamp in UTC: $current_utc_timestamp"

echo "Create another dns record named _owner and enter the following value"
echo "owha=h21oiH9JSDN4snfb2j4hHSBIWQPLZ9ajzAKlwqpMnwbr"

