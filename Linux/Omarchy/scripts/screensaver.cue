// Drop the retired Midgar screensaver on every apply. The theme no longer
// ships it, but machines provisioned earlier may still have the launcher,
// the levi.idle clone, the branding hook, or the theme copy. Absent pieces
// are skipped, so a second run changes nothing.
{
	"scripts": [
		{
			"action": "run",
			"exec": "bash",
			"name": "retire-midgar-screensaver.sh",
			"source": "./"
		}
	]
}
