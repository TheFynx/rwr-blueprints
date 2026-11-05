// Shared Linux CUPS printer profile. Select --profile printer on the
// workstation that has the office Brother MFC; the script skips cleanly
// when the printer is not reachable.
{
	"scripts": [
		{
			"import": "../../../Common/scripts/printer.cue"
		}
	]
}
