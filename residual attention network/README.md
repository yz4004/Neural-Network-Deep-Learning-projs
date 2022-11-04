# Residual Attention Network for Image Classification 

e4040-2021Fall-project

# Intro
"Residual Attention Network", a convolutional neural network using attention mechanism which can incorporate with state-of-art feed forward network architecture in an end-to-end training fashion. Our Residual Attention Network is built by stacking Attention Modules which generate attention-aware features. The attention-aware features from different modules change adaptively as layers going deeper. Inside each Attention Module, bottom-up top-down feedforward structure is used to unfold the feedforward and feedback attention process into a single feedforward process. Authors propose attention residual learning to train very deep Residual Attention Networks which can be easily scaled up to hundreds of layers. 

# Reference Paper
https://openaccess.thecvf.com/content_cvpr_2017/papers/Wang_Residual_Attention_Network_CVPR_2017_paper.pdf

# Organization of this directory
To be populated by students, as shown in previous assignments.
Create a directory/file tree

```
.
├── Draft1.pdf
├── README.md
└── model
    ├── layer_func.py
    ├── my_ran_56.ipynb
    ├── my_ran_92.ipynb
    └── ran_model.py

```
