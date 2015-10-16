# Numpy

### Create array
```
import numpy as np

a = np.array([1,2 ,3], dtype='float32')
```

### Check dtype
```
a.dtype
```

### Cast array to other type
```
a.astype('float32')
```

### Get shape
```
a.shape
```

### Reshape
```
a.reshape(4, 4)
```

### Generate arrays
```
np.zeros((3, 3))
np.empty((3, 3))
np.ones((3, 3), dtype='float32')
np.random.rand(3, 3) # Random numbers between 0 and 1
```

### Filter values
```
a > 0.5 # Show per each element True/False
```

### Retrieve only the filtered elements
```
a[a > 0.5]
```

### Numexpr, high optimized operations
```
from numpy import numexpr

a = np.random.rand(10000)
b = np.random.rand(10000)
c = np.random.rand(10000)
d = ne.evaluate('a + b * c')
```
