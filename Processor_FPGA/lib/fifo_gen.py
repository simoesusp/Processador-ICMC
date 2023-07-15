import argparse
from amaranth.lib.fifo import SyncFIFOBuffered
from amaranth.back import verilog

parser = argparse.ArgumentParser()
parser.add_argument("--output", type=str, help="Output file (default: fifo_<WIDTH>b_<DEPTH>w.v)")
parser.add_argument("width", type=int, help="Width of each element of the FIFO, in bits")
parser.add_argument("depth", type=int, help="Number of elements the FIFO can hold")

args = parser.parse_args()

fifo = SyncFIFOBuffered(width=args.width, depth=args.depth)
a = verilog.convert(
    fifo,
    "fifo_8b_16w",
    emit_src=False,
    ports=[fifo.r_en, fifo.r_rdy, fifo.r_data, fifo.r_level, fifo.w_en, fifo.w_rdy, fifo.w_data, fifo.w_level]
)
output = args.output
if not output:
    output = f"fifo_{args.width}b_{args.depth}w.v"
with open(output, "w") as f:
    f.write(a)
