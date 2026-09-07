// Omarchy firewall/sshd unlock. Omarchy's ufw drops all incoming by default -
// this is the headless equivalent of its Setup > Security > SSHD toggle.
// Gated behind the omarchy profile. See scripts/omarchy-ssh.sh.
{
	"scripts": [
		{
			"action": "run",
			"exec": "bash",
			"elevated": true,
			"name": "omarchy-ssh.sh",
			"profiles": ["omarchy"],
			"source": "./"
		}
	]
}
