import socket
import sys
import argparse
import logging
import random
import signal
from time import sleep, time

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger()

stop = False

def signal_handler(sig, frame):
	global stop
	if (sig == signal.SIGINT):
		logger.info("user asked shutdown")
		stop = True

if __name__=="__main__":
	signal.signal(signal.SIGINT, signal_handler)

	parser = argparse.ArgumentParser(description="Send log lines taken from a file.")
	parser.add_argument('host', action='store', type=str)
	parser.add_argument('port', action='store', type=int)
	parser.add_argument('-n', dest="num_lines", action='store', default=0, type=int)
	parser.add_argument('-f', '--file', dest="file", action='append', required=True, type=str)
	parser.add_argument('-i', '--infinite', dest="infinite", action='store_true')
	parser.add_argument('-r', '--random', dest="random", action='store_true')
	parser.add_argument('-d', '--delay', dest="delay", action='store', default=0, type=float)
	parser.add_argument('--variance', dest="variance", action='store', default=0, type=float)

	args = parser.parse_args(sys.argv[1:])

	print(args)

	client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
	client.settimeout(5)
	try:
		client.connect((args.host, args.port))
	except Exception as e:
		logger.error(f"could not connect to server {args.host}:{args.port} -> {e}")
		sys.exit(1)

	if args.infinite and args.num_lines != 0:
		logger.warning("'-i' and '-n' are incompatible, '-n' will be ignored")
		args.num_lines = 0

	lines = []
	for filename in args.file:
		logger.info(f"Getting log lines from {filename}")
		try:
			logfile = open(filename, 'r')
			newlines =logfile.readlines()
			lines.extend(newlines)
			logger.info(f"added {len(newlines)} to the pool of lines")
		except OSError as e:
			logger.error(f"Could not open file {filename}: {e}")
			sys.exit(1)

	logger.info(f"Finished getting log lines from logfile(s), {len(lines)} lines in buffer")

	num_lines = args.num_lines if args.num_lines != 0 else len(lines)
	num_lines = min(num_lines, len(lines))

	sent_lines = 0

	if not args.infinite:
		logger.info(f"will send {num_lines} lines")
		start = time()
		for i in range(0, num_lines):
			if stop:
				break
			if args.random:
				index = int(random.uniform(0, len(lines)))
			else:
				index = i
			try:
				client.sendall(lines[index].encode("utf-8"))
				sent_lines += 1
			except Exception as e:
				logger.error(f"error while sending line: {e}")
				sys.exit(1)

			if args.delay != 0:
				sleep(max(random.normalvariate(args.delay, args.variance), 0))

		end = time()

	else:
		logger.info(f"will send lines repeatedly, stop program with Ctrl+C")
		start = time()

		while not stop:
			if args.random:
				index = int(random.uniform(0, len(lines)))
			else:
				index = i
			try:
				client.sendall(lines[index].encode("utf-8"))
				sent_lines += 1
			except Exception as e:
				logger.error(f"error while sending line: {e}")
				sys.exit(1)

			if args.delay != 0:
				sleep(max(random.normalvariate(args.delay, args.variance), 0))

		end = time()


	logger.info(f"sent {sent_lines} in {end-start}s")

