import Polyglot.Core.Lir
import Polyglot.Typescript.Ast

-- Smoke: forces the imported atlas oleans (fetched from the GitHub release asset
-- via //lean:atlas) to actually load — version check + symbol table. If the
-- archive held dangling symlinks or a toolchain-mismatched olean, this fails.
def smokeAtlasLoads : Nat := 0
