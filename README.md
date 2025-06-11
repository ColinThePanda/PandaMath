# Panda Math

A high-performance Python library for vector and matrix operations, designed specifically for mathematical computing and game development. Built with NumPy compatibility and modern Python features.

## Features

- **Complete Vector Support**: 2D, 3D, and 4D vector classes with full mathematical operations
- **Rich Operator Overloading**: Natural mathematical syntax with `+`, `-`, `*`, `/`, `//`, `%`, `**`
- **NumPy Integration**: Seamless conversion to/from NumPy arrays
- **Type Safety**: Full type hints and generic base classes
- **Performance Optimized**: Efficient implementations for real-time applications
- **Game Development Ready**: Cross products, normalization, distance calculations
- **Matrix Operations**: Vector-matrix multiplication support

## Installation

```bash
pip install panda-math
```

## Quick Start

```python
from panda_math import Vector2, Vector3, Vector4, vec2, vec3, vec4

# Create vectors
v1 = Vector2(3, 4)
v2 = vec3(1, 2, 3)  # Convenient aliases
v3 = Vector4([1, 0, 0, 1])  # From iterable

# Basic operations
result = v1 + Vector2(1, 1)  # Vector2(4, 5)
scaled = v2 * 2.5           # Vector3(2.5, 5.0, 7.5)
magnitude = v2.magnitude    # 3.74...

# Advanced operations
normalized = v2.normalize()
distance = v1.distance_to(Vector2(0, 0))
dot_product = v2.dot(Vector3(1, 1, 1))
```

## Vector Classes

### Vector2
Perfect for 2D graphics, UI positioning, and planar mathematics.

```python
from panda_math import Vector2

# Creation
pos = Vector2(10, 20)
velocity = Vector2([5, -3])  # From list/tuple

# Properties
print(pos.x, pos.y)          # 10 20
print(pos.magnitude)         # 22.36...
print(len(pos))             # 2

# Operations
new_pos = pos + velocity * 0.016  # Frame-based movement
normalized_vel = velocity.normalize()
```

### Vector3
Essential for 3D graphics, physics simulations, and spatial calculations.

```python
from panda_math import Vector3

# 3D operations
forward = Vector3(0, 0, 1)
up = Vector3(0, 1, 0)
right = forward.cross(up)    # Cross product: Vector3(1, 0, 0)

# Lighting calculations
light_dir = Vector3(1, 1, 1).normalize()
surface_normal = Vector3(0, 1, 0)
intensity = light_dir.dot(surface_normal)
```

### Vector4
Ideal for homogeneous coordinates, quaternions, and RGBA colors.

```python
from panda_math import Vector4

# Homogeneous coordinates
point = Vector4(10, 20, 30, 1)
direction = Vector4(0, 1, 0, 0)

# Color manipulation
red = Vector4(1.0, 0.0, 0.0, 1.0)  # RGBA
transparent_red = red * Vector4(1, 1, 1, 0.5)
```

## Supported Operations

### Arithmetic Operations
```python
v1 = Vector3(1, 2, 3)
v2 = Vector3(4, 5, 6)

# Vector-vector operations
addition = v1 + v2        # Element-wise addition
subtraction = v1 - v2     # Element-wise subtraction
multiplication = v1 * v2  # Element-wise multiplication
division = v1 / v2        # Element-wise division

# Scalar operations
scaled = v1 * 2.5         # Scalar multiplication
divided = v1 / 2          # Scalar division
powered = v1 ** 2         # Element-wise power
```

### In-Place Operations
```python
v = Vector3(1, 2, 3)
v += Vector3(1, 1, 1)     # v is now Vector3(2, 3, 4)
v *= 2                    # v is now Vector3(4, 6, 8)
v.reverse()               # Negates all components in-place
```

### Comparison Operations
```python
v1 = Vector2(1, 2)
v2 = Vector2(3, 4)

print(v1 < v2)            # True (all components less)
print(v1 == Vector2(1, 2)) # True
print(v1 >= 0)            # True (all components >= 0)
```

## Advanced Features

### NumPy Integration
```python
import numpy as np
from panda_math import Vector3

# Convert to NumPy
v = Vector3(1, 2, 3)
array = v.to_numpy()      # np.array([1, 2, 3])

# Create from NumPy
np_array = np.array([4, 5, 6, 7])
v2 = Vector3.from_numpy(np_array)  # Uses first 3 elements
```

### Conversion Between Dimensions
```python
from panda_math import vec2_to_vec3, vec3_to_vec2, vec3_to_vec4

# Convert between vector dimensions
v2d = Vector2(10, 20)
v3d = vec2_to_vec3(v2d, z=0)      # Add z component
v4d = vec3_to_vec4(v3d, w=1)      # Add w component

# Project back down
projected = vec3_to_vec2(v3d)     # Drop z component
```

### Matrix Multiplication
```python
from panda_math import Vector3
# Assuming Matrix class is imported

v = Vector3(1, 2, 3)
# transform_matrix = Matrix(...)  # 3x3 or 4x3 transformation matrix
# transformed = v * transform_matrix
```

## Common Use Cases

### Game Development
```python
# Player movement
player_pos = Vector2(100, 200)
movement_input = Vector2(1, 0)  # Right direction
speed = 150  # pixels per second
delta_time = 0.016  # 60 FPS

new_position = player_pos + movement_input * speed * delta_time

# 3D camera calculations
camera_pos = Vector3(0, 10, -20)
target = Vector3(0, 0, 0)
camera_forward = (target - camera_pos).normalize()
```

### Physics Simulations
```python
# Projectile motion
initial_velocity = Vector3(10, 15, 0)
gravity = Vector3(0, -9.81, 0)
time = 2.0

position = initial_velocity * time + 0.5 * gravity * (time ** 2)
```

### Computer Graphics
```python
# Surface normal calculation
v1 = Vector3(1, 0, 0)
v2 = Vector3(0, 1, 0)
normal = v1.cross(v2).normalize()

# Distance-based effects
light_pos = Vector3(0, 10, 0)
object_pos = Vector3(5, 0, 5)
distance = light_pos.distance_to(object_pos)
attenuation = 1.0 / (1.0 + 0.1 * distance + 0.01 * distance ** 2)
```

## Performance Tips

1. **Use in-place operations** (`+=`, `*=`, etc.) when possible to avoid creating new objects
2. **Normalize vectors once** and reuse when the direction is needed multiple times  
3. **Use appropriate vector dimensions** - don't use Vector4 when Vector2 suffices
4. **Leverage NumPy conversion** for bulk operations on many vectors

## API Reference

### VectorBase (Generic Base Class)
- `magnitude: float` - Vector length/magnitude
- `normalize() -> T` - Returns normalized vector (unit length)
- `distance_to(other: T) -> float` - Euclidean distance to another vector
- `dot(other: T) -> float` - Dot product with another vector
- `reverse()` - Negates all components in-place
- `reversed: T` - Returns a new vector with negated components
- `to_list() -> List[float]` - Convert to Python list
- `to_tuple() -> Tuple[float, ...]` - Convert to Python tuple
- `to_numpy() -> np.ndarray` - Convert to NumPy array
- `from_numpy(array: np.ndarray) -> T` - Create from NumPy array
- `from_iterable(iterable: Iterable) -> T` - Create from any iterable

### Vector3 Specific
- `cross(other: Vector3) -> Vector3` - Cross product (3D only)

## Requirements

- Python 3.7+
- NumPy

## License

MIT License - see LICENSE file for details.

## Contributing

Contributions welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

## Changelog

### Version 1.0.0
- Initial release
- Complete Vector2, Vector3, Vector4 implementations  
- NumPy integration
- Full operator overloading
- Type hints and documentation