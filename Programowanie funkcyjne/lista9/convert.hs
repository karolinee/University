-- zadanie 3
import qualified QBF
import qualified NestedQBF

scopeChceck :: (QBF.Var -> Maybe v) -> QBF.Formula -> Maybe (NestedQBF.Formula v)
scopeChceck env (QBF.Var v) = NestedQBF.Var <$> env v
scopeChceck _ QBF.Bot = pure NestedQBF.Bot
scopeChceck env (QBF.Not f) = NestedQBF.Not <$> scopeChceck env f
scopeChceck env (QBF.And f1 f2) = (NestedQBF.And <$> scopeChceck env f1) <*> scopeChceck env f2
scopeChceck env (QBF.All v f) = NestedQBF.All <$> scopeChceck (\x -> if x == v then pure NestedQBF.Z else NestedQBF.S <$> env x) f

