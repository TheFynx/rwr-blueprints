"""Build terminal-native sword art from the user's diagonal reference."""
from pathlib import Path
import random
rng=random.Random(7)
W,H=108,34
canvas=[[' ']*W for _ in range(H)]
def inside(x,y,points):
    hit=False
    j=len(points)-1
    for i,(xi,yi) in enumerate(points):
        xj,yj=points[j]
        if (yi>y)!=(yj>y) and x<(xj-xi)*(y-yi)/(yj-yi)+xi: hit=not hit
        j=i
    return hit

def paint(poly,chars):
    for y in range(H):
        for x in range(W):
            if inside(x+.5,y+.5,poly):
                canvas[y][x]=rng.choice(chars(x,y) if callable(chars) else chars)

# Long, wide blade, with an acute clipped tanto point at the lower left.
blade=[(2,33),(13,22),(78,5),(94,10)]
paint(blade,lambda x,y:'%%%%%%%%%%%%%###' if x<52 else '#########%%%**')
# The cutting bevel tracks the upper edge and widens across the clipped tip.
paint([(2,33),(13,22),(78,5),(80,6),(16,23)],'======++')
# A dark spine following the lower edge.
paint([(2,33),(94,10),(94,10.7),(5,32.5)],'%%%%@@')
# Long wrapped grip, extending beyond the guard toward the upper right.
paint([(87,6.8),(103,0.4),(106,0.5),(105,2),(90,8)],'##%%%%@@')
paint([(88,6.1),(103,0.4),(106,0.5),(104,1.1),(89,7)],'**##')
# Heavy diagonal guard crossing the base of the blade.
paint([(79,2),(81,1.8),(95,10),(94,11.5),(91,11.2),(78,3.2)],'##%%#*')
paint([(78,3.2),(91,11.2),(94,11.5),(93,12),(90,11.6),(77.5,3.7)],'%%@@')
# Two recessed materia fittings close to the guard.
for cx,cy in [(78,8.2),(83,9.2)]:
    for y in range(H):
        for x in range(W):
            r=((x-cx)/1.7)**2+((y-cy)/.65)**2
            if r<1: canvas[y][x]='+' if r<.3 else '*'

out=Path(__file__).parent/'screensaver.txt'
# Reduce the full design uniformly for more space around it.
scale = 0.85
small = [[canvas[min(H-1, int(y/scale))][min(W-1, int(x/scale))]
          for x in range(round(W*scale))] for y in range(round(H*scale))]
out.write_text('\n'.join(''.join(row).rstrip() for row in small)+'\n')
print(out.read_text())
