#!/usr/bin/python

hostPort = 20545
containerPort =20545

namespace = "improvshark"
name = "tworld"

import subprocess
def cmd (bashCommand):
	process = subprocess.Popen(bashCommand.split(), stdout=subprocess.PIPE, stderr=subprocess.PIPE)
	out, err = process.communicate()
	if out:
		print out
	if err:
		print err
def launch ():
	print 'begin launch'
	cmd("docker run  --name %s -d --privileged=true --net host %s/%s" % (name,namespace,name) )

def build ():
	print 'begin building image'
	cmd("docker build -t %s/%s . " % (namespace,name) )
	print 'done'
def main():
        import argparse
	parser = argparse.ArgumentParser(description='Tool to manage a %s docker container' % name)
	parser.add_argument('-l','--launch', help="Launch the game", action='store_true')
	parser.add_argument('-b','--build', help="Build the container", action='store_true')
	parser.add_argument('-s','--shell', help="Open a busybox shell in the container", action='store_true')
	arg = parser.parse_args()
	
	if arg.launch:
		launch()
	if arg.build:
		build()
	if arg.shell:
		shell()
	if not any(vars(arg).values()):
		parser.print_help()
main()
