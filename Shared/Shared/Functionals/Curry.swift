//
//  Created by Joachim Kret on 13/05/2019.
//  Copyright © 2019 Enterpryze. All rights reserved.
//

import Foundation

// MARK: Curry

public func curry <A, B, C>(_ f: @escaping (A, B) -> C) -> (A) -> (B) -> C {
    
    return { a in
        
        return { b in
            
            return f(a, b)
        }
    }
}

public func curry <A, B, C, D>(_ f: @escaping (A, B, C) -> D) -> (A) -> (B) -> (C) -> D {
    
    return { a in
        
        return { b in
            
            return { c in
                
                return f(a, b, c)
            }
        }
    }
}

public func curry <A, B, C, D, E>(_ f: @escaping (A, B, C, D) -> E) -> (A) -> (B) -> (C) -> (D) -> E {
    
    return { a in
        
        return { b in
            
            return { c in
                
                return { d in
                    
                    return f(a, b, c, d)
                }
            }
        }
    }
}

public func curry <A, B, C, D, E, F>(_ f: @escaping (A, B, C, D, E) -> F) -> (A) -> (B) -> (C) -> (D) -> (E) -> F {
    
    return { a in
        
        return { b in
            
            return { c in
                
                return { d in
                    
                    return { e in
                        
                        return f(a, b, c, d, e)
                    }
                }
            }
        }
    }
}

public func curry <A, B, C, D, E, F, G>(_ fn: @escaping (A, B, C, D, E, F) -> G) -> (A) -> (B) -> (C) -> (D) -> (E) -> (F) -> G {
    
    return { a in
        
        return { b in
            
            return { c in
                
                return { d in
                    
                    return { e in
                        
                        return { f in
                            
                            return fn(a, b, c, d, e, f)
                        }
                    }
                }
            }
        }
    }
}

// MARK: Curry + Throws

public func curry <A, B, C>(_ f: @escaping (A, B) throws -> C) -> (A) -> (B) throws -> C {
    
    return { a in
        
        return { b in
            
            return try f(a, b)
        }
    }
}

public func curry <A, B, C, D>(_ f: @escaping (A, B, C) throws -> D) -> (A) -> (B) -> (C) throws -> D {
    
    return { a in
        
        return { b in
            
            return { c in
                
                return try f(a, b, c)
            }
        }
    }
}

public func curry <A, B, C, D, E>(_ f: @escaping (A, B, C, D) throws -> E) -> (A) -> (B) -> (C) -> (D) throws -> E {
    
    return { a in
        
        return { b in
            
            return { c in
                
                return { d in
                    
                    return try f(a, b, c, d)
                }
            }
        }
    }
}

public func curry <A, B, C, D, E, F>(_ f: @escaping (A, B, C, D, E) throws -> F) -> (A) -> (B) -> (C) -> (D) -> (E) throws -> F {
    
    return { a in
        
        return { b in
            
            return { c in
                
                return { d in
                    
                    return { e in
                        
                        return try f(a, b, c, d, e)
                    }
                }
            }
        }
    }
}

public func curry <A, B, C, D, E, F, G>(_ fn: @escaping (A, B, C, D, E, F) throws -> G) -> (A) -> (B) -> (C) -> (D) -> (E) -> (F) throws -> G {
    
    return { a in
        
        return { b in
            
            return { c in
                
                return { d in
                    
                    return { e in
                        
                        return { f in
                            
                            return try fn(a, b, c, d, e, f)
                        }
                    }
                }
            }
        }
    }
}
