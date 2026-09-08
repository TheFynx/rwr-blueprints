#!/usr/bin/env python3
"""Fit shade-character text without cropping; original source stays untouched."""
from pathlib import Path
import math, sys

def fit(text, columns, lines):
    rows = text.splitlines()
    width, height = max(map(len, rows)), len(rows)
    scale = min(1.0, max(1, columns - 4) / width, max(1, lines - 4) / height)
    w, h = max(1, int(width * scale)), max(1, int(height * scale))
    if scale == 1:
        return "\n".join(r.rstrip() for r in rows) + "\n"
    chars = " ░▒▓█"
    pixels = [[chars.find(c) / 4 if c in chars else 1 for c in r.ljust(width)] for r in rows]
    result = []
    for y in range(h):
        row = ""
        for x in range(w):
            left, right = x * width / w, (x + 1) * width / w
            top, bottom = y * height / h, (y + 1) * height / h
            value = 0
            for sy in range(int(top), min(height, math.ceil(bottom))):
                for sx in range(int(left), min(width, math.ceil(right))):
                    weight = (min(right, sx + 1) - max(left, sx)) * (min(bottom, sy + 1) - max(top, sy))
                    value += pixels[sy][sx] * weight
            value /= (right - left) * (bottom - top)
            row += chars[min(4, round(value * 4))]
        result.append(row.rstrip())
    return "\n".join(result) + "\n"

if __name__ == "__main__":
    print(fit(Path(sys.argv[1]).read_text(), int(sys.argv[2]), int(sys.argv[3])), end="")
