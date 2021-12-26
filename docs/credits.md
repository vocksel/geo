---
sidebar_position: 3
---

# Credits

Geo would not have been possible without the following papers:

[A Simple Approach to Recognise Geometric Shapes Interactively](https://www.academia.edu/580171/A_Simple_Approach_to_Recognise_Geometric_Shapes_Interactively)

This paper was invaluable in forming a basis for how to tackle shape recognition. In summary, they calculate the convex hull from a series of vertices, compare approximate equality with geoemtric ratios, and use a decision tree to move between checking each type of shape based on the certainty of the ratio.

[Maximum-Area Triangle in a Convex Polygon, Revisited](https://www.sciencedirect.com/science/article/abs/pii/S0020019020300302)

_Algorithm 2_ outlined in this paper was used as the basis for finding the maximum-area triangle inscribed within the convex hull. After many false starts and several days of researching, we now have a functional implementation.