// Shared Linux data-drive profile. Select --profile data-drives on the
// workstation that has these UUIDs; absent disks are safe no-ops.
{
	"scripts": [
		{
			"import": "../../../Common/scripts/data-drives.cue"
		}
	]
}
