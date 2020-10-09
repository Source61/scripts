import json, os, subprocess, sys

# Searches for a youtube video based on video title/metadata and optionally opens in a video player (mpv by default)
# Depends on youtube-dl python package and MPV for video playback

searchNum = 3 # How many results to show
playVideo = True # Play the first video?

if len(sys.argv) < 2:
	print("Syntax: %s text-to-search" % (sys.argv[1],))
	exit()

plain = "[\n\t%s\n]\n" % (subprocess.getoutput('''youtube-dl "ytsearch%s: %s" -j''' % (str(searchNum) if searchNum else "", " ".join(sys.argv[1:]))).replace("}\n", "},\n\t"),)

j = json.loads(plain)

for v in j:
	print('''"%s" -> "%s" - %d views: %s''' % (v["uploader_id"], v["fulltitle"], v["view_count"], v["webpage_url"]))
	if playVideo:
		subprocess.Popen("mpv %s" % (v['webpage_url'],))
		break
