// Run on every provisioning pass, even when a bootstrap marker already exists.
// Reuse the private key when present and ensure its public key is on GitHub.
{
 ssh_keys: [{
  name: "git"
  type: "ed25519"
  path: "{{ .User.home }}/.ssh/"
  comment: "levi@fynx.me"
  no_passphrase: true
  copy_to_github: true
 }]
}
