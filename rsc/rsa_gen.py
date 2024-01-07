from Crypto.Util.number import *
import random
from pprint import pprint

KEY_LEN=2
KEY_EXPOSANT=3

def print_bin(src):
	b = str(bin(src))
	print(" ".join([b[::-1][i:i+8] for i in range(0, len(b), 8)])[::-1])

def	byteToLong(text: str) -> int:
	number = 0
	for letter in text:
		number = (number << 8) + letter
	return number

def	longToByte(number: int) -> str:
	text = ""
	while number:
		text = chr(number & 0xff) + text
		number >>=8
	return text

def	gen_key(name: str = "id_mc_rsa"):
	while True:
		# Test message
		m = byteToLong(b"A")
		print(f"{m = }")
		p = getPrime(KEY_LEN * 4)
		q = getPrime(KEY_LEN * 4)

		# Public key
		n = p * q

		# Crypt m
		c = pow(m, KEY_EXPOSANT, n)
		print(f"{c = }")

		phi = (p - 1) * (q - 1)

		try:
			# Private key
			d = inverse(KEY_EXPOSANT, phi)
		except ValueError:
			print("Cannot get private key, relaunching")
			continue

		# Cipher test message
		c_m = pow(c, d, n)

		if m != c_m:
			print("Cannot decipher m, relaunching")
			continue

		len_n = len(longToByte(n))
		len_d = len(longToByte(d))

		if len_n != len_d or len_n != KEY_LEN or len_d != KEY_LEN:
			print("Key len differ, relaunching")
			continue
		break

	print(f"{longToByte(m)}")
	print(f"{longToByte(c_m)}")
	print(f"pub key {str(n)}")
	print(f"private key {str(d)}")

	with open(name + ".pub", "w") as f:
		f.write(str(n) + "\n")

	with open(name, "w") as f:
		f.write(str(n) + "\n" + str(d) + "\n")

gen_key()
